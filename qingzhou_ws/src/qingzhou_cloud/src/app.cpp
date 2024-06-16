#include "app.h"
#include <tf2/convert.h>
#include <tf2/utils.h>

#include "tf2_geometry_msgs/tf2_geometry_msgs.h"


app::app(ros::NodeHandle nh) {
     //variable init
     cloudsendrate = 5;
     recvflag = 0;
     disconnectFlag = 0;
     mfcCloudPortNum = 8050;
     heartFlag = 0;
     heartdisconnectCommand = 0;
     recvAckFlag = 0;
     clientIsConnect = 0;
     carstatusMsg.data = 0;

     nh.param("cloudsendrate",cloudsendrate,cloudsendrate);
     nh.param("mfcCloudIP",mfcCloudIP,mfcCloudIP);
     nh.param("mfcCloudPortNum",mfcCloudPortNum,mfcCloudPortNum);
     nh.param("bdebug",bdebug,bdebug);

    pub_app_command = nh.advertise<qingzhou_cloud::qingzhou_cloud>("clientCommand", 5);
    pub_start_stop_command = nh.advertise<qingzhou_cloud::startstopCommand>("startStopCommand", 5);
    pub_stop_point = nh.advertise<qingzhou_cloud::stoppoint>("stoppoint", 5);
    //pub_trafficLight = nh.advertise<dzcloud::trafficLight>("trafficLight", 5);

    clientdetectConnectThread = boost::thread(boost::bind(&app::detectConnectThread, this));
    clientRecvThread = boost::thread(boost::bind(&app::RecvThreadFromMfc, this));
    //sendHeart = boost::thread(boost::bind(&app::sendHeartThread, this));
    // sub_current_position = nh.subscribe("/amcl_pose",1,&app::callback_location,this);
    sub_current_position = nh.subscribe("odom_data",1,&app::callback_location,this);
    sub_current_battery = nh.subscribe("battery",1,&app::callback_battery,this);
    sub_car_status = nh.subscribe("carstatus",1,&app::callback_carstatus,this);
    sub_nav_status = nh.subscribe("navstatus",1,&app::callback_navstatus,this);     
    sub_car_speed = nh.subscribe("/cmd_vel",1,&app::callback_speed,this);

 }

  double getYaw(geometry_msgs::PoseStamped pose)
  {
      return tf2::getYaw(pose.pose.orientation);
  }

 app::~app()
 {
 }
void app::callback_carstatus(const std_msgs::UInt8::ConstPtr &msg){
    carstatusMsg = *msg;
 	//printf("qingzhou_cloud-->callback_carstatus:%d\n",carstatusMsg.data);
}
void app::callback_navstatus(const std_msgs::UInt8::ConstPtr &msg){
    navstatusMsg = *msg;
// 	printf("qingzhou_cloud-->callback_navstatus\n");
}
// void app::callback_location(const qingzhou_cloud::current_location::ConstPtr &msg){
//     current_location = *msg;
//  	//printf("qingzhou_cloud-->callback_location\n");
// }
void app::callback_location(const nav_msgs::Odometry::ConstPtr &msg){
    current_location = *msg;
}
// void app::callback_location(const geometry_msgs::PoseWithCovarianceStamped::ConstPtr &msg){
//     current_location = *msg;
//  	//printf("qingzhou_cloud-->callback_location\n");
// }
  
void app::callback_battery(const std_msgs::Float32::ConstPtr &msg){
    current_battery = *msg;
    //printf("qingzhou_cloud-->callback_battery = %.2f\n",current_battery.data);
}
  
void app::callback_speed(const geometry_msgs::Twist::ConstPtr &msg){
    sCmd_vel = *msg;
    //printf("qingzhou_cloud-->callback_speed = %.2f, %.2f\n",sOdom.twist.twist.angular.z,sOdom.twist.twist.linear.x);
}

void app::run()
{
    ros::Rate rate(cloudsendrate);
    while(ros::ok()){
    ros::spinOnce();
	if(clientIsConnect == 1){
	    dataProcKernelNet(0x01);
	}
//	dzcloud::trafficLight lightMsg;
//	pub_trafficLight.publish(lightMsg);

    rate.sleep();
    }
 }

//实时发送小车位置信息
void app::dataProcKernelNet(int carID){   
    float x = current_location.pose.pose.position.x;
    float y = current_location.pose.pose.position.y;
    float z = current_location.pose.pose.orientation.z;
    float w = current_location.pose.pose.orientation.w;
    float currentAngleSpeed = sCmd_vel.angular.z;
    float currentLinerSpeed =sCmd_vel.linear.x;
    float power = current_battery.data;
    char navstatus = 0;  
    char carstatus = carstatusMsg.data;   

 	// printf("qingzhou_cloud--> x:%.4f,y:%.4f,z:%4f,AngleSpeed:%.2f,LinerSpeed:%.2f\n",x,y,z,currentAngleSpeed,currentLinerSpeed);

    struct info{
	int carID1;float x1;float y1;float z1;float w1;float angleSpeed;float linerSpeed;float power;char navstatus1;char carstatus1;
	};
	
    struct info info1{
        carID,
        x,
        y,
        z,
        w,
        currentAngleSpeed,
	    currentLinerSpeed,
        power,
	    navstatus,
	    carstatus,
    };

    int ret = send(clientfd, (char *)&info1, sizeof(info1), 0);
    if(ret < 0)
	printf("qingzhou_cloud-->send to MFC server error %d\n",errno);
}


