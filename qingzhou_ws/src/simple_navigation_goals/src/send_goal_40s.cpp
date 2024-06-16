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

int send_point(float x,float y,float z,float w,int flag = 1) //flag==1为等待结果，0为不等待结果
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
    if(flag == 1)
    {
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

        
 }

// void doPose(const geometry_msgs::PoseWithCovarianceStamped::ConstPtr &p)
// {
//     if(p->pose.pose.position.x  <0  && p->pose.pose.position.y == -1.51069987133)
//     {
//         ros::param::set("/offset_enable",0); //关闭视觉寻线
//         ROS_INFO("send start point");
//         send_point( 0.0762921684785, -0.185374767488 ,-0.00707084883084,0.999975001236 ); //路径规划回到起点
//     }
// }

int main(int argc, char** argv){
    ros::init(argc, argv, "a_goals_sender"); //初始化ros节点的常规操作
     
    //在ctrl+c时有效执行退出操作，方便扩展（参见参考【3】）
    signal(SIGINT, DoShutdown);
   
    ros::NodeHandle nh;
    //ros::Subscriber sub = nh.subscribe<geometry_msgs::PoseWithCovarianceStamped>("/amcl_pose",1000,doPose);
    bool task01_flag = false;
    bool task02_flag = false;
    bool task03_flag = false;
    nh.setParam("task",0);
    ros::Rate loop_rate(5); 

    while (ros::ok())
    {
        int ai_car_task = nh.param("task",0);
        int flag1 = 0,flag2 = 0,flag3 = 0,flag4 = 0;
        if(ai_car_task == 0)
        {
            //ROS_INFO("0");
        }
        else if(ai_car_task == 1)//任务1
        {
            if(task01_flag == false)
            {
                // send_point( 1.87963995799,-0.854647570704,-0.261180319862,0.965290029223  ,0);
                // ros::Duration du1(1.5);//持续2秒钟,参数是double类型的，以秒为单位
                // du1.sleep();//按照指定的持续时间休眠
                flag1 = send_point( 2.32412975448,-3.14056424034,-0.714674199607,0.69945749579 ,1);
                task01_flag = true;
                task02_flag = false;
                task03_flag = false;

            }
            if(flag1 == 1)
            {
               ros::param::set("/trafficlight_enable",1); 
               nh.setParam("task",2);
               flag1 = 0;
            }
        }
        else if(ai_car_task == 2)//任务2
        {
            if(task02_flag ==false)
            {
                // send_point( 1.7210414866,-7.25555593007,-0.939386006215, 0.342861387921 ,0);
                // ros::Duration du2(4);//持续10秒钟,参数是double类型的，以秒为单位
                // du2.sleep();//按照指定的持续时间休眠

                send_point( 1.56193296357,-7.40401029612,-0.919874503345, 0.392212822453 ,0);
                ros::Duration du5(6);//持续10秒钟,参数是double类型的，以秒为单位
                du5.sleep();//按照指定的持续时间休眠

                send_point( -1.77835896055,-7.2557132282,0.882714342118, 0.469909980975 ,0);
                ros::Duration du3(3);//持续10秒钟,参数是double类型的，以秒为单位
                du3.sleep();//按照指定的持续时间休眠
                flag2 = send_point(-2.09220962325, -6.09676885726, 0.653692505623  ,0.756760271217  ,1 );
                task01_flag = false;
                task02_flag = true;
                task03_flag = false;
            }
            if(flag2 == 1)
            {
                ros::param::set("/trafficlight_enable",0);
                nh.setParam("task",3);
                flag2 = 0;
            }
        }       
        else if(ai_car_task == 3)//任务3
        {
            if(task03_flag ==false)
            {
                send_point(-2.03154004915, -5.23774881256, 0.653692505623  ,0.744273530533  ,0 );
                ros::Duration du4(0.8);//持续10秒钟,参数是double类型的，以秒为单位
                du4.sleep();//按照指定的持续时间休眠
                // send_point(-0.177613420793, -6.34050991687, -0.300774244618  , 0.953695367386 ,0 );
                // ros::Duration du6(3);//持续10秒钟,参数是double类型的，以秒为单位
                // du6.sleep();//按照指定的持续时间休眠
                flag3 = send_point( 1.05,-4.14554367687 ,0.734472153866, 0.678638825293  ,1);
                task01_flag = false;
                task02_flag = false;
                task03_flag = true ;
            }
            if(flag3 == 1)
            {
            //     // flag4 = send_point(1.15927792495,-3.356694317 ,0.806299081284, 0.591508065474);
            //     // if(flag4 == 1)
            //     // {
                ros::param::set("/offset_enable",1); //启动视觉寻线
            //     //     flag4 = 0;
            //     // }
                
                flag3 = 0;
            }
               
        }         
        ros::spinOnce();

        loop_rate.sleep();
    }
    return 0;
}
