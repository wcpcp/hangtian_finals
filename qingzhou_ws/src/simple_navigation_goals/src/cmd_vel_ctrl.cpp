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
ros::Subscriber twist_sub_move_base;

//定义存储r\p\y的容器
double roll, pitch, yaw;
/**
 * @brief 导航控制底盘回调函数
 * 
 * @param msg 
 */
void twistNavCmdCallback(const geometry_msgs::Twist::ConstPtr &msg)
{
    int cmd_vel_flag = ros::param::param("/offset_enable",0);
    // if(cmd_vel_flag == 0)
    // {
    //     geometry_msgs::Twist twist;
    //     twist.linear.x = msg->linear.x;
    //     twist.angular.z = msg->angular.z;
    //     twist_pub.publish(twist);
    // }
    geometry_msgs::Twist twist;
    twist.linear.x = msg->linear.x;
    twist.angular.z = msg->angular.z;
    twist_pub.publish(twist);
}
/**
 * @brief 视觉控制底盘回调函数
 * 
 * @param msg 
 */
void twistLineCmdCallback(const geometry_msgs::Twist::ConstPtr &msg)
{
     int cmd_vel_flag = ros::param::param("/offset_enable",0);
     if(cmd_vel_flag == 1)
     {
         geometry_msgs::Twist twist;
         twist.linear.x = msg->linear.x;
         twist.angular.z = msg->angular.z;
         twist_pub.publish(twist);
     }
 }

// void twistMoveCmdCallback(const geometry_msgs::Twist::ConstPtr &msg)
// {
//     int cmd_vel_flag = ros::param::param("/enable_move_base",0);
//     if(cmd_vel_flag == 1)
//     {
//         ROS_INFO("Move_base -Control!!!!!!!!!!!!!!!");
//         geometry_msgs::Twist twist;
//         twist.linear.x = msg->linear.x;
//         twist.angular.z = msg->angular.z;
//         twist_pub.publish(twist);
//     }
//     else
//     {
//         ROS_INFO   ("Path_contral!!!!!!!!");
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

    // twist_sub_move_base = nh.subscribe<geometry_msgs::Twist>("cmd_vel_move_base", 5, twistMoveCmdCallback);

    ros::spin();
    return 0;
}
