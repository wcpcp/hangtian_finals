#include "qingzhou_bringup.h"

long long LeftticksPerMeter = 0;    //左轮编码器每米脉冲数
long long rightticksPerMeter = 0;   //右轮编码器每米脉冲数
long long LeftticksPer2PI = 0;      //左轮每圈编码器脉冲数
long long rightticksPer2PI = 0;     //右轮每圈编码器脉冲数

int traffic_line_enable = 0;
int offset_enable = 0;
float dingtrafficlight = 0.0;    

//定义存储r\p\y的容器
double roll, pitch, yaw;
double imu_th,lastYaw;
double angular_velocity_z;
// 构造函数，初始化
actuator::actuator(ros::NodeHandle handle) 
{ 
   m_baudrate = 115200;             
   m_serialport = "/dev/ttyUSB0";   
   linearSpeed = 0;                 //线速度
   angularSpeed = 0;                //角速度
   batteryVoltage = 0;              //电池电压
   ticksPerMeter = 0;               //一米脉冲数
   ticksPer2PI = 0;                 //每圈脉冲数
   encoderLeft = 0;                 //左编码器
   encoderRight = 0;                //有编码器
   imuYaw = 0;                      
   velDeltaTime = 0;                
   calibrate_lineSpeed = 0;         
   calibrate_angularSpeed = 0;      
   
   memset(&moveBaseControl,0,sizeof(sMartcarControl));
   // 解决启动就右偏的问题
   moveBaseControl.TargetAngle = 60;                       //stm32 program has subtract 60
   
   handle.param("mcubaudrate",m_baudrate,m_baudrate);                                   //波特率
   handle.param("mcuserialport",m_serialport,std::string("/dev/ttyUSB0"));              //定义传输的串口
   handle.param("calibrate_lineSpeed",calibrate_lineSpeed,calibrate_lineSpeed);         //标定线速度
   handle.param("calibrate_angularSpeed",calibrate_angularSpeed,calibrate_angularSpeed);//标定角速度
   handle.param("ticksPerMeter",ticksPerMeter,ticksPerMeter);                           //一米脉冲数
   handle.param("ticksPer2PI",ticksPer2PI,ticksPer2PI);                                 //每圈脉冲数

   handle.setParam("/traffic_line_enable",0);//到达S弯之前发送1
   handle.setParam("/offset_enable",0);//接收是否识别到车道线
   handle.setParam("/red_traffic",false);//接收是否识别红灯
   handle.setParam("/task",0);

	

//    handle.setParam("/dingtrafficlight",0);   //红绿灯是否允许通行

    try{ //异常处理
      std::cout<<"[dzactuator-->]"<<"Serial initialize start!"<<std::endl;              
      ser.setPort(m_serialport.c_str());                                               
      ser.setBaudrate(m_baudrate);                                                    
      serial::Timeout to = serial::Timeout::simpleTimeout(30);                      
      ser.setTimeout(to);                                                            
      ser.open();                                                                     
    }
    catch (serial::IOException& e){
      std::cout<<"[dzactuator-->]"<<"Unable to open port!"<<std::endl;                
    }
    if(ser.isOpen()){
      std::cout<<"[dzactuator-->]"<<"Serial initialize successfully!"<<std::endl;       //如果串口打开，打印串口初始化成功
    }
    else{
      std::cout<<"[dzactuator-->]"<<"Serial port failed!"<<std::endl;                  
    } 
	
    sub_move_base = handle.subscribe("cmd_vel",1,&actuator::callback_move_base,this);                         
    sub_imu_data = handle.subscribe<sensor_msgs::Imu>("/imu_data",5,&actuator::callback_imu_data,this);  

    pub_imu = handle.advertise<sensor_msgs::Imu>("raw", 5);	                                                 
    pub_mag = handle.advertise<sensor_msgs::MagneticField>("imu/mag", 5);                                    
    pub_odom = handle.advertise<nav_msgs::Odometry>("odom", 5);                                               
    poly_pub = handle.advertise<geometry_msgs::PolygonStamped>("polygon",10);                                 
    pub_battery = handle.advertise<std_msgs::Float32>("battery",10);   

    //sub_movebase_angle = handle.subscribe("move_base/currentAngle",1,&actuator::callback_movebase_angle,this);//订阅move_base/currentAngle话题上的消息。
}

//析构函数
actuator::~actuator() 
{
     
}


//imu回调函数
void actuator::callback_imu_data(const sensor_msgs::ImuConstPtr& imu)
{
			// lastYaw = imu_th;

            //定义一个四元数quadf
            tf::Quaternion quat;
            
            //把msg形式的四元数转化为tf形式,得到quat的tf形式
            tf::quaternionMsgToTF(imu->orientation, quat);
 
            //进行转换得到RPY欧拉角
            tf::Matrix3x3(quat).getRPY(roll, pitch, yaw);	//弧度值

            angular_velocity_z = imu->angular_velocity.z;
			// imu_th = yaw;
			// printf("\r\nimu_th = %.2f\r\n ",imu_th*57.3);
            // //定义将要发布的欧拉角数据类型           
            // rpy_pt.x = roll*180/ Pi;
            // rpy_pt.y = pitch*180/ Pi;
            // rpy_pt.z = yaw*180/ Pi;


}

//move_base获得当前角度回调函数  
void actuator::callback_movebase_angle(const std_msgs::Float32::ConstPtr &msg){
    currentAngleMsg = *msg;
}

//定义move_base回调函数
void actuator::callback_move_base(const geometry_msgs::Twist::ConstPtr &msg) //对应cmd_vel话题，对应geometry_msgs/Twist消息
{
   memset(&moveBaseControl,0,sizeof(sMartcarControl));                       //清零movebase数据存储区
   
   float v = msg->linear.x;                                                  //move_base算得的线速度
   float w = msg->angular.z;                                                 //move_base算得的角速度
																			// 32/1.321428571428
   moveBaseControl.TargetSpeed = v*24.2162162162162;			// v*58.2;    计算目标线速度,这里是按最大速度0.59算的
   moveBaseControl.TargetAngle = round(atan(w*CARL/v)*57.3);                 //计算目标角度**************************************************
   moveBaseControl.TargetAngle+=60;                                       
   
		   
//    if(moveBaseControl.TargetAngle < 0){
//       moveBaseControl.TargetAngle = 0;             //角度小于0时 等于0
//    }
//    if(moveBaseControl.TargetAngle > 120){
//       moveBaseControl.TargetAngle = 120;           //角度最大120
//    }
   
   //linear speed
   if(moveBaseControl.TargetSpeed > 0)                 
      moveBaseControl.TargetShiftPosition = 0x02;  //前进
   else if(moveBaseControl.TargetSpeed < 0)         
      moveBaseControl.TargetShiftPosition = 0x01;  //后退
   else if(moveBaseControl.TargetSpeed == 0)           
      moveBaseControl.TargetShiftPosition = 0x00;  //停止
	  
   printf("%.2f,%.2f,%d,%d\n",msg->linear.x,msg->angular.z,                  
	       abs(moveBaseControl.TargetSpeed),abs(moveBaseControl.TargetAngle));
   
//    //期望转向角度符号
//    if(moveBaseControl.TargetAngle > 0)                 
//       moveBaseControl.TargetAngleDir = 0x20;	   //右转（左右跟舵机安装方式有关） 
//    else if(moveBaseControl.TargetAngle < 0)
//       moveBaseControl.TargetAngleDir = 0x10;	   //左转
//    else if(moveBaseControl.TargetAngle == 0)
//       moveBaseControl.TargetAngleDir = 0x00;	   //直行

//   sendCarInfoKernel();
}
  
void actuator::run()
{
    int run_rate = 20;  //default 50              
    ros::Rate rate(run_rate);      

    double x = 0.0;                 //x坐标                       
    double y = 0.0;                 //y坐标
    double th = 0.0;
	double R = 0.0;

	// 定义里程计校正因子
    float odom_linear_scale_correction_ = 1;
    float odom_angular_scale_correction_ = 1;

	// 加载校正因子
    // ros::param::get("/qingzhou_bringup/odom_linear_scale_correction",odom_linear_scale_correction_);
    // ros::param::get("/qingzhou_bringup/odom_angular_scale_correction",odom_angular_scale_correction_);

    ros::Time current_time, last_time;                    
	
    while(ros::ok()){
        ros::spinOnce();                                  
		current_time = ros::Time::now();                  //获得当前时间
	    velDeltaTime = (current_time - last_time).toSec();//转换成秒
	    last_time = ros::Time::now();                     //当前时刻存放为上一时刻
		
        recvCarInfoKernel();                              //接收stm32发来的数据
	    pub_9250();                                       //发布imu数据
		
	    currentBattery.data = batteryVoltage;             //读取当前电池电压
	    pub_battery.publish(currentBattery);              //发布当前电池电压
		

    #if 1
	    if(encoderLeft > 220 || encoderLeft < -220) encoderLeft = 0;
	    if(encoderRight > 220 || encoderRight < -220) encoderRight = 0;
        //encoderLeft = -encoderLeft;
	    encoderRight = -encoderRight;                          

	    detEncode = (encoderLeft + encoderRight)/2;            //求编码器平均值
	    detdistance = detEncode/ticksPerMeter;                 
		if(linearSpeed > 0 && linearSpeed < 0.5 )
	   	 	detth = (encoderRight - encoderLeft)*2*PI/ticksPer2PI; //计算当前角度 通过标定获得ticksPer2PI
		else if(linearSpeed > 0.5 && linearSpeed < 1.2 )
		    detth = imu_th -lastYaw;
		else
	   	 	detth = (encoderRight - encoderLeft)*2*PI/ticksPer2PI; //计算当前角度 通过标定获得ticksPer2PI
	    linearSpeed = detdistance/velDeltaTime;                
	    angularSpeed = detth/velDeltaTime;      

	    if(detdistance != 0){
	        x += odom_linear_scale_correction_* detdistance * cos(th);                        //x坐标
	        y += odom_linear_scale_correction_* detdistance * sin(th);                        //y坐标
	    }
	    if(detth != 0){
	        th += odom_angular_scale_correction_* detth;                                       //总角度
	    }
	    // if(detdistance != 0){
		// 	// 小车中心直线移动距离    R*sin(0.5*detth)*2
		// 	// 原坐标计算
		// 	if (angularSpeed!=0){
		// 		R = linearSpeed/angularSpeed; 
		// 		x += R*sin(0.5*detth)*2 * cos(th+0.5*detth);                        //x坐标
		// 		y += R*sin(0.5*detth)*2 * sin(th+0.5*detth);                        //y坐标
		// 	}
		// 	else{
		// 		x += detdistance * cos(th);                        //x坐标
		// 		y += detdistance * sin(th);                        //y坐标

		// 	}
	    // }
	    // if(detth != 0){
	    //     th += detth;                                       //总角度
	    // }       
	    if(calibrate_lineSpeed == 1){
		    printf("x=%.2f,y=%.2f,th=%.2f,linearSpeed=%.2f,,detEncode=%.2f,LeftticksPerMeter = %lld,rightticksPerMeter = %lld,batteryVoltage = %.2f\n",x,y,th,linearSpeed,detEncode,LeftticksPerMeter,rightticksPerMeter,batteryVoltage);
	    }
	    //send command to stm32
	    sendCarInfoKernel();                                                     
	    geometry_msgs::Quaternion odom_quat = tf::createQuaternionMsgFromYaw(th); 

	    nav_msgs::Odometry odom;                               //创建nav_msgs::Odometry类型的消息odom
	    odom.header.stamp = current_time;                     
	    odom.header.frame_id = "odom";                         
 	    odom.child_frame_id = "base_link";                     

	    //set the position
	    odom.pose.pose.position.x = x;                       
	    odom.pose.pose.position.y = y;                        
	    odom.pose.pose.position.z = 0.0;                       
	    odom.pose.pose.orientation = odom_quat;               
	
	    odom.twist.twist.linear.x = linearSpeed;               //线速度
	    odom.twist.twist.linear.y = 0;
	    odom.twist.twist.linear.z = 0;
	    odom.twist.twist.angular.x = 0;
	    odom.twist.twist.angular.y = 0;
	    odom.twist.twist.angular.z = angularSpeed;             //角速度
	    if(encoderLeft == 0 && encoderRight == 0){//静止
	        odom.pose.covariance = {1e-9, 0, 0, 0, 0, 0,       
				        0, 1e-3, 1e-9, 0, 0, 0,
				        0, 0, 1e6, 0, 0, 0,
				        0, 0, 0, 1e6, 0, 0,
				        0, 0, 0, 0, 1e6, 0,
				        0, 0, 0, 0, 0, 1e-9};
			odom.twist.covariance = {1e-9, 0, 0, 0, 0, 0,      
						0, 1e-3, 1e-9, 0, 0, 0,
						0, 0, 1e6, 0, 0, 0,
						0, 0, 0, 1e6, 0, 0,
						0, 0, 0, 0, 1e6, 0,
						0, 0, 0, 0, 0, 1e-9};
		}
		else{ //运动
			odom.pose.covariance = {1e-3, 0, 0, 0, 0, 0,       
						0, 1e-3, 0, 0, 0, 0,
						0, 0, 1e6, 0, 0, 0,
						0, 0, 0, 1e6, 0, 0,
						0, 0, 0, 0, 1e6, 0,
						0, 0, 0, 0, 0, 1e3};
			odom.twist.covariance = {1e-3, 0, 0, 0, 0, 0,      
						0, 1e-3, 0, 0, 0, 0,
						0, 0, 1e6, 0, 0, 0,
						0, 0, 0, 1e6, 0, 0,
						0, 0, 0, 0, 1e6, 0,
						0, 0, 0, 0, 0, 1e3};
		}
		//publish the message
		pub_odom.publish(odom);                                
		
		// /*******************publish polygon message***********************/
		// geometry_msgs::Point32 point[4];                       //定义点数组
		// // coordinates described in base_link frame
		// point[0].x = -0.18;  point[0].y = -0.12;
		// point[1].x = 0.18;   point[1].y = -0.12;
		// point[2].x = 0.18;   point[2].y = 0.12;
		// point[3].x = -0.18;  point[3].y = 0.12;

		// geometry_msgs::PolygonStamped poly;                    
		// poly.header.stamp = current_time;
		// poly.header.frame_id = "base_link";
		// poly.polygon.points.push_back(point[0]);
		// poly.polygon.points.push_back(point[1]);
		// poly.polygon.points.push_back(point[2]);
		// poly.polygon.points.push_back(point[3]);

		// poly_pub.publish(poly);                                
	
#endif
        rate.sleep();
    }
}

//发送小车数据到下位机
void actuator::sendCarInfoKernel()
{
    unsigned char buf[23] = {0};


    // if (offset_enable)
    // {
	// 	angle = (-traffic_line_offset*K) + 60;                                                 //move_base算得的角速度
	// 	moveBaseControl.TargetAngle = angle;           
	// 	moveBaseControl.TargetSpeed = (int)abs(0.2*49.72972973);                                  //计算目标线速度
	// 	moveBaseControl.TargetShiftPosition = 0x02;//前进
    // }
	// if (offset_enable == 0){//************************调试使用*****************
	// 	moveBaseControl.TargetSpeed = (int)abs(0);        
	// 	moveBaseControl.TargetShiftPosition = 0x00;//停止
	// }

    buf[0] = 0xa5;	                                        
    buf[1] = 0x5a;	                                        
    buf[2] = 0x06;	                                        

	    buf[3] = (int)moveBaseControl.TargetAngleDir;	    //targetangleDirection 0-->go straight,0x10-->turn left,0x20-->turn right
	    buf[4] = (int)abs(moveBaseControl.TargetAngle);	    //targetangle 180-->0xb4期望转向角度值
	    buf[5] = (int)abs(moveBaseControl.TargetSpeed);		//targetSpeed期望线速度
		// printf("\r\n(int)abs(moveBaseControl.TargetAngle) = %d \r\n",(int)abs(moveBaseControl.TargetAngle)-60);
	    buf[6] = (int)moveBaseControl.TargetModeSelect;		//0-->person control,1-->auto control期望模式 人工/自动
	    buf[7] = (int)moveBaseControl.TargetShiftPosition;  //targetshiftposition  0-->P stop;1-->R;2-->D.期望档位 停止/倒车/前进
  
    buf[8] = 0;		                                        
    unsigned char sum = 0;
    for(int i = 2; i < 19; ++i)                             
        sum += buf[i];
        buf[9] = (unsigned char)(sum);                      
    size_t writesize = ser.write(buf,10);
}

//接收下位机发送来的数据
void actuator::recvCarInfoKernel()
{

    std::string recvstr;                                             
    unsigned char tempdata,lenrecv;                                  
    unsigned char count,last_data,last_last_data,last_last_last_data;
    unsigned char str[100];                                          
    bool recvflag = false;                                          
    bool recvd_flag = false;                                         
    memset(&str,0,sizeof(str));                                      
    ros::Time begin_time = ros::Time::now();                         
    double clustering_time = 0;                                      

    while(1){
	    clustering_time = (ros::Time::now () - begin_time).toSec (); //计算时间差，转换成秒
	    if(clustering_time > 1){                                    
	        recvd_flag = false;                                      
	        break;                                                   
	    }
		
	    recvstr = ser.read(1);                                      		
	    if((int)recvstr.size() != 1)                                 
	        continue;                                               
		
	    tempdata = recvstr[0];                                       
	    if(last_last_last_data == 0xa5 && last_last_data == 0x5a){   
	        lenrecv = last_data;                                     
	        recvflag = true;                                         
	        count = 0;                                               
	    }
	    if(recvflag){                                               
	        str[count] = tempdata;                                   
	        count++;                                                
	        if(count == lenrecv){                                   
		        recvflag = false;                                    
		        recvd_flag = true;                                   
		    break;                                                  
	        }
	    }
	    last_last_last_data = last_last_data;                        
	    last_last_data = last_data;                                  
	    last_data = tempdata;                                        
    }

    if(recvd_flag){                                                  //数据解析，接收到的数据转存
	    memcpy(&encoderLeft,str,4);                                  //左轮编码器增量值转存
	    memcpy(&encoderRight,str+4,4);                               //右轮编码器增量值转存
	    memcpy(&batteryVoltage,str+8,4);                             //电池电压值转存
 	
	    memcpy(&tempaccelX,str+12,2);                                //X线加速度转存
	    memcpy(&tempaccelY,str+14,2);                                //Y线加速度转存
		memcpy(&tempaccelZ,str+16,2);                                //z线加速度转存
		
		memcpy(&tempgyroX,str+18,2);                                 //X轴角速度转存
		memcpy(&tempgyroY,str+20,2);                                 //Y轴角速度转存
		memcpy(&tempgyroZ,str+22,2);                                 //z轴角速度转存
		
		memcpy(&tempmagX,str+24,2);                                  //X轴磁力计转存
		memcpy(&tempmagY,str+26,2);                                  //Y轴磁力计转存
		memcpy(&tempmagZ,str+28,2);                                  //Z轴磁力计转存
	
		// memcpy(&distanceA,str+30,4);                                 //超声距离值A转存
		// memcpy(&distanceB,str+34,4);                                 //超声距离值B转存
		// memcpy(&distanceC,str+38,4);                                 //超声距离值C转存
		// memcpy(&distanceD,str+42,4);                                 //超声距离值D转存

		accelX = (float)tempaccelX/2048*9.8;                         //线加速度处理	
		accelY = (float)tempaccelY/2048*9.8;
		accelZ = (float)tempaccelZ/2048*9.8;

		
		gyroX = (float)tempgyroX/16.4/57.3;                          //角速度处理
		gyroY = (float)tempgyroY/16.4/57.3;
		gyroZ = (float)tempgyroZ/16.4/57.3;
		
		magX = (float)tempmagX*0.14;                                 //磁力计处理
		magY = (float)tempmagY*0.14;
		magZ = (float)tempmagZ*0.14;

        if(encoderLeft > 220 || encoderLeft < -220) encoderLeft = 0; //判断编码器脉冲数是否在正确范围
        if(encoderRight > 220 || encoderRight < -220) encoderRight = 0;
        LeftticksPerMeter += encoderLeft;                            //获得左轮总脉冲数
        rightticksPerMeter += encoderRight;                          //获得右轮总脉冲数
    }
}

//发布imu函数
void actuator::pub_9250(){                         
    sensor_msgs::Imu imuMsg;                       
    sensor_msgs::MagneticField magMsg;           
	
    ros::Time current_time = ros::Time::now();    
	         
    imuMsg.header.stamp = current_time;            
    imuMsg.header.frame_id = "imu_link";          
    imuMsg.angular_velocity.x = gyroX;             
    imuMsg.angular_velocity.y = gyroY;             
    imuMsg.angular_velocity.z = gyroZ;             
    imuMsg.angular_velocity_covariance = {         
      0.04,0.0,0.0,
      0.0,0.04,0.0,
      0.0,0.0,0.04
    };
    
    imuMsg.linear_acceleration.x = accelX;        
    imuMsg.linear_acceleration.y = accelY;         
    imuMsg.linear_acceleration.z = accelZ;        
    imuMsg.linear_acceleration_covariance = {      
      0.04,0.0,0.0,
      0.0,0.04,0.0,
      0.0,0.0,0.04
    };
    pub_imu.publish(imuMsg);                       //发布imuMsg 
     
    magMsg.header.stamp = current_time;            
    magMsg.header.frame_id = "base_link";          
    magMsg.magnetic_field.x = magX;                
    magMsg.magnetic_field.y = magY;                
    magMsg.magnetic_field.z = magZ;                
    magMsg.magnetic_field_covariance = {           
      0.0,0.0,0.0,
      0.0,0.0,0.0,
      0.0,0.0,0.0
    };
    pub_mag.publish(magMsg);                       //发布magMsg
}



