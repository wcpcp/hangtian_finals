#include <ros/ros.h>
#include <move_base_msgs/MoveBaseAction.h>   // 引用move_base的信息
#include <actionlib/client/simple_action_client.h>   // 引用actionlib库
#include "std_msgs/String.h"
#include "geometry_msgs/PoseWithCovarianceStamped.h"
#include <sstream>
#include <iostream>
#include <signal.h>  // 引用signal头文件，为了做节点退出操作

using namespace std;
// 定义一个SimpleActionClient，用来给move_base一个目标点：
typedef actionlib::SimpleActionClient<move_base_msgs::MoveBaseAction> MoveBaseClient;

void DoShutdown(int sig)
{
	//这里主要进行退出前的数据保存、内存清理、告知其他节点等工作
	ROS_INFO("shutting down!");
	ros::shutdown(); 
    exit(sig); //为了更完整，处理一下退出的signal
}

int send_point(float x,float y,float z,float w)
 {
    // 声明一个SimpleActionClient：
    //tell the action client that we want to spin a thread by default
    MoveBaseClient ac("move_base", true);

  //wait for the action server to come up
    while(!ac.waitForServer(ros::Duration(5.0))){
        ROS_INFO("Waiting for the move_base action server to come up");
    }
    // 声明一个目标点goal，注意MoveBaseGoal的格式：
    move_base_msgs::MoveBaseGoal goal;



     // Details here: http://edu.gaitech.hk/turtlebot/map-navigation.html 参见参考【1】
     /*goal.target_pose.header.frame_id = "map" specifies the reference frame for that location. In this example, it is specified as the map frame, which simply means that the coordinates will be considered in the global reference frame related to the map itself. In other words, it is the absolute position on the map. In case where the reference frame is set with respect to the robot, namely goal.target_pose.header.frame_id = "base_link" (like in this tutorial), the coordinate will have a completely other meaning. In fact, in this case the coordinate will represent the (x,y) coordinate with respect to robot base frame attached to the robot, so it is a relative position rather than a absolute position as in the case of using the map frame.
    //goal.target_pose.header.frame_id = "base_link";*/
    goal.target_pose.header.frame_id = "map";
    goal.target_pose.header.stamp = ros::Time::now();
	// 以下是一个随意取的二维目标点：
    goal.target_pose.pose.position.x = x;
    goal.target_pose.pose.position.y = y;
    goal.target_pose.pose.orientation.z = z;
    goal.target_pose.pose.orientation.w = w;

    ROS_INFO("Sending goal");
    // 定义好了goal，就可以调用SimpleActionClient的现成方法sendGoal()，非常方便：
    ac.sendGoal(goal);

    ac.waitForResult();
    // 判断是否执行成功：
    if(ac.getState() == actionlib::SimpleClientGoalState::SUCCEEDED)
    {
        ROS_INFO("Hooray, the base moved to the goal");
        return 1;
    }
       
    else
    {
        ROS_INFO("The base failed to move for some reason");
        return 0;
    }
        
 }

void doPose(const geometry_msgs::PoseWithCovarianceStamped::ConstPtr &p)
{
    if(p->pose.pose.position.x  < -1.1  && p->pose.pose.position.y > -1.45662264376  && p->pose.pose.position.y < -0.6)
    //if(  p->pose.pose.position.y > 1.68*p->pose.pose.position.x )
    {
        send_point( -0.0267403712427, -0.01250383221 ,0.0307858169385,0.999526004402 ); //路径规划回到起点
        ros::param::set("/offset_enable",0); //关闭视觉寻线
        ROS_INFO("send start point  ");
    }
}

int main(int argc, char** argv){
    ros::init(argc, argv, "line_final"); //初始化ros节点的常规操作
    //在ctrl+c时有效执行退出操作，方便扩展（参见参考【3】）
    signal(SIGINT, DoShutdown);
   
    ros::NodeHandle nh;
    ros::Subscriber sub = nh.subscribe<geometry_msgs::PoseWithCovarianceStamped>("/amcl_pose",1000,doPose);

    ros::spin();
    return 0;
}
