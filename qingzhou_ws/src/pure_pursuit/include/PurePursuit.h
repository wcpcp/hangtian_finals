#ifndef PUREPURSUIT_H
#define PUREPURSUIT_H

#include <string>
#include <cmath>
#include <vector>

#include <ros/ros.h>
#include <nav_msgs/Path.h>
#include <nav_msgs/Odometry.h>
#include <geometry_msgs/PoseStamped.h>
#include <geometry_msgs/PointStamped.h>
#include <geometry_msgs/Twist.h>

#include <tf2_ros/transform_listener.h>
#include <tf2_ros/transform_broadcaster.h>
#include <geometry_msgs/TransformStamped.h>
#include <tf2/LinearMath/Transform.h>
#include <tf2/transform_datatypes.h>
#include <tf2_geometry_msgs/tf2_geometry_msgs.h>
#include <tf2_kdl/tf2_kdl.h>

#include <dynamic_reconfigure/server.h>
#include <pure_pursuit/PurePursuitConfig.h>

class PPControl {
    public:
        // Constructor
        PPControl(ros::NodeHandle& nh);
        // Destructor
        virtual ~PPControl();

        /* ----- spin -----*/
        /// \brief Funcion para iniciar los suscriptores y publicadores, lanzar la configuracion dinamica
        /// y ejecutar el nodo.

        void spin();
        
        template<typename A, typename B>
        double getDistance(A punto1, B punto2){
            return sqrt(pow(punto1.x - punto2.x,2) + pow(punto1.y - punto2.y,2) + pow(punto1.z - punto2.z,2));
        }


    private:

        /* ----- getParameters -----*/
        /// \brief Funcion para obtener del servidor de parametros los que nos interesan.

        void getParameters();

        /* ----- configcallback -----*/
        /// \brief Funcion para modificar en tiempo real los parametros que nos interesan.

        void configcallback(pure_pursuit::PurePursuitConfig &config, uint32_t level);

        /* ----- getPath -----*/
        /// \brief Funcion de tipo callback que sera llamada cada vez que se reciba un path con formato nav_msgs::Path.
        /// \param path Trayectoria (path) que ha recibido el nodo, y la cual se intentará seguir.

        void getPath(const nav_msgs::Path &path);

        /* ----- getOdom-----*/
        /// \brief Funcion de tipo callback que sera llamada cada vez que se reciba la odometría del robot
        /// con formato nav_msgs::Odometry.
        /// \param odom Odometria que ha recibido el nodo, no se usará directamente si no que se hará uso
        /// del arbol de transformadas.

        void getOdom(const nav_msgs::Odometry& odom);
        // void timerCallback(const ros::TimerEvent& event);
        
        /* ----- getTF_BLMap-----*/
        /// \brief Funcion para obtener la transformada desde el frame base_link hasta el frame Map.
        /// \return Devuelve una transformada en formato mensaje stamped (cabecera+child_frame_id).

        geometry_msgs::TransformStamped getTF_BLMap();

        /* ----- getFrame_MapBL-----*/
        /// \brief Funcion para realizar una transformacion desde el frame Map hasta el frame base_link
        /// \param pose_map Pose de tipo mensaje con frame en map
        /// \return Devuelve una transformacion en el frame base_link (en formato Frame de KDL).

        KDL::Frame getFrame_MapBL(const geometry_msgs::Pose& pose_map);

        // geometry_msgs::PoseStamped getPose();
        // double getPoseDist(const geometry_msgs::PoseStamped& pose);

        /* ----- getWayPoint-----*/
        /// \brief Funcion para obtener el siguiente waypoint a seguir por el robot.
        /// \return Devuelve el indice del path en el que se encuentra el waypoint a seguir.

        int getWayPoint();

        /* ----- computeNewLookahead_tf-----*/
        /// \brief Funcion para calcular una nueva transformada para el punto lookahead.
        /// \param F_goal Es la pose del ultimo elemento del path (meta) en el frame base_link en formato frame de KDL.

        void computeNewLookahead_tf (const KDL::Frame& F_goal);

        /* Variable que representa a este nodo de ROS */
        ros::NodeHandle _nh;

        /* Suscriptores al path y a odom, y publicador de la velocidad */
        ros::Subscriber _pathSub;
        ros::Subscriber _odomSub;
        ros::Publisher _cmdVelPub;

        /* Nombre de los topics de ros a los que suscribirse/publicar */
        std::string _pathTopic;
        std::string _odomTopic;
        std::string _cmdVelTopic;

        /* Nombre de los frame_ids que representan la base del robot, la trayectoria y el mapa */
        std::string _robotFrameid;
        std::string _pathFrameid;
        std::string _mapFrameid;
        std::string _ldFrameid;

        
        /* Buffer de tfs para buscar la tf entre base_link y map */
        tf2_ros::Buffer _tfBuffer;
        tf2_ros::TransformListener _tfListener;
        tf2_ros::TransformBroadcaster _tfBroadcaster;

        /* Transformadas de tipo mensaje stamped para el punto lookahead
         y la transformada entre los frames base_link y map */
        geometry_msgs::TransformStamped _tf_BLMap;
        geometry_msgs::TransformStamped _tfLookahead;

        ros::Timer _timer;

        double _velocity; // Velocidad linear que seguira el robot
        double _velmax; // Velocidad linear maxima configurable
        double _w_max; // Velocidad angular maxima predefinida
        
        bool _meta; // Variable para indicar si se ha llegado a la meta o no
        int _nextWP; // Almacena el siguiente waypoint que seguira el robot
        
        double _ld; // Distancia lookahead
        double _posTolerance; // Tolerancia de posicion en el eje x para considerar la llegada o no a la meta

        /* Variables relacionadas con el path recibido */
        nav_msgs::Path _cpath; // Mensaje en el que se guardara el path recibido
        int _pathlength; // Su tamaño (cantidad de poses)
        geometry_msgs::Pose _cpathFinalPose; // Pose de la ultima pose de la trayectoria

        /* Mensaje que contendra las velocidades linear y angular que seran publicadas */
        geometry_msgs::Twist _cmdVel;
};

#endif