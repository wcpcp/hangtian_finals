#include "PurePursuit.h"


    // Constructor
    PPControl::PPControl(ros::NodeHandle& nh):
     _nh("~"), _nextWP(0), _meta(true), _velmax(0.3), _velocity(0.1), _tfListener(_tfBuffer){
        getParameters();
    }

    PPControl::~PPControl(){}

    void PPControl::getParameters(){

        _nh.param<double>("distancia_lookahead", _ld, 1.0);
        _nh.param<double>("vel_angular_max", _w_max, 1.0);
        // _nh.param<double>("vel_linear_max", _velmax, 0.1); // Sera configurable a tiempo real
        _nh.param<double>("tolerancia_posicion", _posTolerance, 0.1);
        _nh.param<std::string>("path_topic", _pathTopic, "/move_base/SBPLLatticePlanner/plan");
        _nh.param<std::string>("odom_topic", _odomTopic, "/steer_bot/odom");
        _nh.param<std::string>("cmdVel_topic", _cmdVelTopic, "/purepursuit/cmd_vel");
        _nh.param<std::string>("map_frameid", _mapFrameid, "map");
        _nh.param<std::string>("robot_frameid", _robotFrameid, "base_link");
        _nh.param<std::string>("lookahead_frameid", _ldFrameid, "lookahead");

    }

    void PPControl::spin(){

        _tfLookahead.header.frame_id = _robotFrameid;
        _tfLookahead.child_frame_id = _ldFrameid;
        
        /* Inicializo los suscriptores y el publicador */
        _pathSub = _nh.subscribe(_pathTopic,1,&PPControl::getPath,this);
        _odomSub = _nh.subscribe(_odomTopic,1,&PPControl::getOdom,this);
        _cmdVelPub = _nh.advertise<geometry_msgs::Twist>(_cmdVelTopic, 1);

        /* Establezco el servidor para la configuracion dinamica de los parametros */
        dynamic_reconfigure::Server<pure_pursuit::PurePursuitConfig> server;
        dynamic_reconfigure::Server<pure_pursuit::PurePursuitConfig>::CallbackType f;
        f = boost::bind(&PPControl::configcallback, this, _1, _2);
        server.setCallback(f);
        ros::spin();
    }

    void PPControl::configcallback(pure_pursuit::PurePursuitConfig &config, uint32_t level){
        ROS_INFO("Reconfigure Request: %f", config.vel_linear_max);
        if(level==0) _velmax = config.vel_linear_max;
    }

    void PPControl::getPath(const nav_msgs::Path &path){

        /* Si se recibe un nuevo path y tiene el frame_id del mapa se sobreescribe el anterior */
        if (path.header.frame_id==_mapFrameid){
            _cpath = path;
            _pathFrameid = path.header.frame_id;
            _pathlength = path.poses.size();
            _cpathFinalPose = path.poses.back().pose;
            _nextWP = 0;

            // Comprobamos que la trayectoria no esté vacía
            if (_pathlength>0){
                _meta=false;
                std::cout << "Trayectoria valida iniciada" << std::endl;
            }
            else{
                _meta=true;
                ROS_WARN_STREAM("Trayectoria vacia, ingrese nueva trayectoria");
            }
        }
        else    ROS_WARN_STREAM("El frame_id del path debe ser " << _mapFrameid << 
                " pero esta publicado en el frame " << path.header.frame_id);
        
    }

    void PPControl::getOdom(const nav_msgs::Odometry& odom){

        /* En vez de usar la odometria directamente se trabajara con el arbol de tfs */
        _tf_BLMap = getTF_BLMap();
        int wp = getWayPoint();
        // std::cout << "waypoint: " << wp << std::endl;

        /* Si el path no esta vacio y el waypoint obtenido sobrepasa los limites de tamaño del path 
        significa que no se ha encontrado ningun wp cuya distancia con respecto al robot sea mayor
        que la distancia lookahead. O lo que es lo mismo, significa que nos estamos acercando a la
        meta (punto final) que esta a menor distancia que la lookahead */
        if (!_cpath.poses.empty() && wp >= _pathlength){

            /* La pose de la meta la paso del frame map al frame BL */
            KDL::Frame F_goal_BL = getFrame_MapBL(_cpathFinalPose);
            geometry_msgs::Pose pose_goal_BL = tf2::toMsg(F_goal_BL);

            /* Si la posicion de la meta es menor que una determinada tolerancia medida en el eje x del robot,
            significara que hemos llegado a nuestro destino y reseteamos el path */
            if (fabs(pose_goal_BL.position.x) <= _posTolerance){
                _meta = true;
                std::cout << "posicion en x de la meta: " << pose_goal_BL.position.x << std::endl;
                std::cout << "posicion en y de la meta: " << pose_goal_BL.position.y << std::endl;
                _cpath = nav_msgs::Path();
            }
            /* Si no se ha llegado modificamos la tf del lookahead para que apunte al wp obtenido*/ 
            else{
                computeNewLookahead_tf(F_goal_BL);
            }
        }

        /* Si aun no se ha llegado a la meta calculamos las nuevas velocidades para que el robot siga avanzando
        hacia el siguiente waypoint */
        if (!_meta){

            _velocity = copysign(_velmax, _velocity);

            /* Calculamos el error lateral que viene siendo la coordenada Y del punto lookahead
             en el frame de base_link */
            double error_lat = _tfLookahead.transform.translation.y;

            /* Calculamos la velocidad angular cuya formula ha seguido el siguiente desarrollo: 
            El error lateral viene dado por e = ld*sin(alpha) y la curvatura (inversa del radio)
            viene dada por k = 2*sin(alpha)/ld. Sustituyendo el seno del error en el de la curvatura
            podemos obtener que k = (2*e)/ ld². Por tanto, w = v/R = v*k = (2*v*e) / ld² . */
            double w = (2 * _velocity * error_lat)/ (_ld*_ld);

            /* La velocidad angular que publiquemos sera el minimo entre la calculada y una w maxima predefinida */
            _cmdVel.angular.z = std::min(w, _w_max);

            /* Establecemos la velocidad linear con la que avanzara el robot */
            _cmdVel.linear.x = _velocity;
        }

        /* Si en cambio se ha llegado a la meta pararemos el robot y resetearemos el punto del lookahead */
        else{
            
            _tfLookahead.transform = geometry_msgs::Transform();
            _tfLookahead.transform.rotation.w = 1.0;
            _tfLookahead.header.frame_id = _robotFrameid;
            _tfLookahead.child_frame_id = _ldFrameid;
            
            _cmdVel.linear.x = 0.0;
            _cmdVel.angular.z = 0.0;
        }

        /* Publicamos la transformada del punto lookahead*/
        _tfLookahead.header.stamp = ros::Time::now();
        _tfBroadcaster.sendTransform(_tfLookahead);

        /* Finalmente publicamos las velocidades linear y angular */
        _cmdVelPub.publish(_cmdVel);
    }

    geometry_msgs::TransformStamped PPControl::getTF_BLMap(){
        
        geometry_msgs::TransformStamped tfGeom;
        try{
            bool tf_found = _tfBuffer.canTransform(_mapFrameid, _robotFrameid, ros::Time(0), ros::Duration(3), NULL);
            if (tf_found)   tfGeom = _tfBuffer.lookupTransform(_mapFrameid, _robotFrameid, ros::Time(0));
            else    std::cout << "Error en la tf de map a base_link: " << std::endl;
        }
        
        catch (tf2::TransformException &ex) {
            ROS_WARN_STREAM("Error en PPControl::getTF_BLMap: " << ex.what());
        }

        return tfGeom;
    }

    KDL::Frame PPControl::getFrame_MapBL(const geometry_msgs::Pose& pose_map){
        
        /* Convertimos la transformada _tf_BLMap y la pose con respecto al mapa que le pasamos como argumento
        a un tipo de dato de la librería KDL para operar mejor con ellas */
        KDL::Frame Frame_pose_Map;
        KDL::Frame Frame_tf = tf2::transformToKDL(_tf_BLMap);
        tf2::fromMsg(pose_map, Frame_pose_Map);

        /* Aplicamos la inversa a la tf para que ahora sea de map a base_link y la multiplicamos por la pose dada
        para obtener así una pose con respecto a base_link */
        KDL::Frame Frame_pose_BL = Frame_tf.Inverse()*Frame_pose_Map;          
        // geometry_msgs::Pose pose_BL = tf2::toMsg(Frame_pose_BL);

        return Frame_pose_BL;
    }

    int PPControl::getWayPoint(){

        geometry_msgs::Vector3 pos_robot = _tf_BLMap.transform.translation;

        /* Recorro todos los elementos del path (partiendo desde el wp actual) y aquel cuya distancia con respecto
        a la pose del robot sea mayor que la distancia del lookahead será el siguiente waypoint al que llegar */
        for (; _nextWP < _cpath.poses.size(); _nextWP++){
            geometry_msgs::Point pos_wp = _cpath.poses[_nextWP].pose.position;
            
            if (getDistance(pos_wp, pos_robot) > _ld){

                /* Paso la transformada del lookahead que estaba en el frame map al frame base_link
                para luego poder medir el error lateral */
                KDL::Frame F_lookahead_BL = getFrame_MapBL(_cpath.poses[_nextWP].pose);
                _tfLookahead = tf2::kdlToTransform(F_lookahead_BL);
                _tfLookahead.header.frame_id = _robotFrameid;
                _tfLookahead.child_frame_id = _ldFrameid;

                break;
            }
        }

        return _nextWP;
    }

    void PPControl::computeNewLookahead_tf (const KDL::Frame& F_goal){

        /* Obtengo los angulos RPY de la pose de la meta */
        double roll, pitch, yaw;
        F_goal.M.GetRPY(roll, pitch, yaw);

        /* El vector origen de la nueva transformada de la distancia lookahead se obtendrá tras
        calcular la intersección entre el circulo de radio la distancia ld y la linea definida
        por la ultima pose del path */

        /* Calculo primero las componentes necesarias para la ec. de la recta y - y0 = m*(x-x0)
        siendo y=ld_y, y0=y_posefinal, x=ld_x y por ultimo x0=x_posefinal */
        double m = tan(yaw); // Pendiente de dicha recta

        /* Extracto de la recta que pasa por el punto (x_posefinal, y_posefinal) con pendiente m
         -> y_pfin - m*x_pfin */
        double r_pfin =  F_goal.p.y() - m*F_goal.p.x();

        /* La ec. de la circunferencia de radio ld centrada en base_link será ld_x² + ld_y² = ld² 
        sustituimos la ld_y de la ec de la recta en la ec de la circunf obteniendo una ecuacion
        cuadratica para ld_x con los siguientes terminos y solucion ld_x² = (-b +- sqrt(b² - 4ac))/2a */
        double a = 1 + m * m; // 1+m²
        double b = 2 * m * r_pfin; // 2*m*(y_pfin - m*x_pfin)
        double c = r_pfin * r_pfin - _ld * _ld; // (y_pfin - m*x_pfin)² - ld²
        double D = sqrt(b*b - 4*a*c); 
        double ld_x = (-b + copysign(D,_velocity)) / (2*a);
        double ld_y = m * ld_x + r_pfin; // ld_y = m*(ld_x - x_pfin) + y_pfin

        /* Modifico los parametros del vector de posicion y del de rotacion de la tf de la lookahead */
        _tfLookahead.transform.translation.x = ld_x;
        _tfLookahead.transform.translation.y = ld_y;
        _tfLookahead.transform.translation.z = F_goal.p.z();
        F_goal.M.GetQuaternion(_tfLookahead.transform.rotation.x,
                               _tfLookahead.transform.rotation.y,
                               _tfLookahead.transform.rotation.z,
                               _tfLookahead.transform.rotation.w);

    }


