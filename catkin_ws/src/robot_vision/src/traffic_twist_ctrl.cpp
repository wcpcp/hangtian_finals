#include "ros/ros.h"
#include "geometry_msgs/Twist.h"

int main(int argc, char *argv[])
{
    setlocale(LC_ALL,"");

    ros::init(argc,argv,"traffic_twist_control");
    ros::NodeHandle nh;
    nh.setParam("/dingtrafficlight",0);
    ros::Publisher pub = nh.advertise<geometry_msgs::Twist>("/cmd_vel",10);


    while (ros::ok())
    {
        int res1 = nh.param("/dingtrafficlight",0); // 存在，返回对应结果，否则返回默认值
        if(res1)
        {
            geometry_msgs::Twist msg;
            msg.linear.x = 0.0;
            msg.linear.y = 0.0;
            msg.linear.z = 0.0;

            msg.angular.x = 0.0;
            msg.angular.y = 0.0;
            msg.angular.z = 0.0;
            pub.publish(msg);
        }
        

        ros::spinOnce();
    }


    return 0;
}
