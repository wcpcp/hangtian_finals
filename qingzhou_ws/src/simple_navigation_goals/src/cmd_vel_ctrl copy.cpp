#include <ros/ros.h>
#include <move_base_msgs/MoveBaseAction.h>   // 引用move_base的信息
#include <actionlib/client/simple_action_client.h>   // 引用actionlib库
#include "std_msgs/String.h"
#include "math.h"
#include "geometry_msgs/PoseWithCovarianceStamped.h"
#include <sstream>
#include <iostream>
#include <signal.h>  // 引用signal头文件，为了做节点退出操作
#include <std_msgs/Float32.h>
#include <geometry_msgs/TwistStamped.h>
#include <geometry_msgs/Twist.h>
#include <sensor_msgs/Imu.h>
#include "tf/transform_datatypes.h"//转换函数头文件
using namespace std;


ros::Publisher twist_pub;//声明
ros::Subscriber twist_sub_nav;
ros::Subscriber twist_sub_line;
//定义存储r\p\y的容器
double roll, pitch, yaw;
/**
 * @brief 导航控制底盘回调函数
 * 
 * @param msg 
 */
void twistNavCmdCallback(const geometry_msgs::Twist::ConstPtr &msg)
{
    int cmd_vel_flag = ros::param::param("/cmd_vel_ctrl",0);
    if(cmd_vel_flag == 0)
    {
        geometry_msgs::Twist twist;
        if(ros::param::param("/task",0) == 1)
         {
            twist.linear.x = msg->linear.x*1.15;       
            twist.angular.z = msg->angular.z ;
         }
        else if(ros::param::param("/task",0) == 2 )
        {
            twist.linear.x = msg->linear.x*1.1;
            twist.angular.z = msg->angular.z * 1.2;
        }
        else 
        {
            twist.linear.x = msg->linear.x;
            twist.angular.z = msg->angular.z ;
        }
        // if(ros::param::param("/task",0) == 3)
        twist_pub.publish(twist);
    }
}
/**
 * @brief 视觉控制底盘回调函数
 * 
 * @param msg 
 */
void twistLineCmdCallback(const geometry_msgs::Twist::ConstPtr &msg)
{
    int cmd_vel_flag = ros::param::param("/cmd_vel_ctrl",0);
    if(cmd_vel_flag == 1)
    {
        geometry_msgs::Twist twist;
        twist.linear.x = msg->linear.x;
        twist.angular.z = msg->angular.z;
        twist_pub.publish(twist);
    }
}


// void imuCallback(const sensor_msgs::Imu::ConstPtr &msg)
// {
//     //定义一个四元数quadf
//     tf::Quaternion quat;
//     //把msg形式的四元数转化为tf形式,得到quat的tf形式
//     tf::quaternionMsgToTF(msg->orientation, quat);
//     //进行转换得到RPY欧拉角
//     tf::Matrix3x3(quat).getRPY(roll, pitch, yaw);	//弧度值
//     printf("yaw=%.2f\r\n",yaw);
//     if (ros::param::param("/task",0) == 1)
//     {
//         // if(yaw > -0.1 && yaw <1.5)
//         // {
//         //     ros::param::set("/acc_lim_theta",4.0);//开始点给大角加速度
//         //     ros::param::set("/max_vel_theta",1.2);             
//         // }
//         // else
//         // {
//         //     ros::param::set("/acc_lim_theta",0.35);//恢复初始的参数
//         //     ros::param::set("/max_vel_theta",1.2);                    
//         // }
//     }
// }

int main(int argc, char** argv)
{
    ros::init(argc, argv, "cmd_vel_ctrl"); //初始化ros节点的常规操作
    ros::NodeHandle nh;
    nh.setParam("/cmd_vel_ctrl",0); //0为导航控制底盘，1为视觉控制底盘
    twist_pub = nh.advertise<geometry_msgs::Twist>("cmd_vel", 5);
    twist_sub_nav = nh.subscribe<geometry_msgs::Twist>("cmd_vel_nav", 5, twistNavCmdCallback);
    twist_sub_line = nh.subscribe<geometry_msgs::Twist>("cmd_vel_line", 5, twistLineCmdCallback);
    // ros::Subscriber sub = nh.subscribe<geometry_msgs::PoseWithCovarianceStamped>("/amcl_pose",5,doPose);
    // ros::Subscriber sub_imu = nh.subscribe("/imu_data", 5, imuCallback);
    ros::spin();
    return 0;
}
