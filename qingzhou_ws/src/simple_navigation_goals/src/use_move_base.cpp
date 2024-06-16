#include <ros/ros.h>
#include <move_base_msgs/MoveBaseAction.h>   // 引用move_base的信息
#include <actionlib/client/simple_action_client.h>   // 引用actionlib库
#include "std_msgs/String.h"
#include "geometry_msgs/PoseWithCovarianceStamped.h"
#include <sstream>
#include <iostream>
#include <signal.h>  // 引用signal头文件，为了做节点退出操作
#include <std_msgs/Float32.h>
#include <geometry_msgs/TwistStamped.h>
#include <geometry_msgs/Twist.h>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "nav_msgs/Odometry.h"
#include "nav_msgs/Path.h"
#include "geometry_msgs/PoseStamped.h"
#include <tf/transform_listener.h>
#include <fstream>


using namespace std;


bool task00_flag = false;
bool task01_flag = false;
bool task02_flag = false;
bool task03_flag = false;
bool task04_flag = false;
bool task05_flag = false;
bool task06_flag = false;
bool task07_flag = false;
bool task08_flag = false;




int FLAG_daoche=1;

int flag0=0,flag1 = 0,flag2 = 0,flag3 = 0,flag4 = 0,flag5 = 0,flag6 = 0,flag7 = 0,flag8=0;

int podao_flag=0;

float car_goal_x;
float car_goal_y;



double end_point_x,end_point_y;

nav_msgs::Odometry car_odom;
nav_msgs::Odometry car_odom_;
geometry_msgs::PoseWithCovarianceStamped amcl_pose;

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




void odomCallback(const nav_msgs::Odometry::ConstPtr & odom){
    car_odom=*odom;
}

void odomCallback_(const nav_msgs::Odometry::ConstPtr & odom){
    car_odom_=*odom;
}

void amclCB(const geometry_msgs::PoseWithCovarianceStamped::ConstPtr &amclMsg)
{ //里程计回调函数
  amcl_pose=*amclMsg;
}

double dist(double goal_x,double goal_y)
{
    //计算车到目标点的距离
  double car2goal_x = goal_x - amcl_pose.pose.pose.position.x;
  double car2goal_y = goal_y - amcl_pose.pose.pose.position.y;
  double dist2goal = sqrt(car2goal_x * car2goal_x + car2goal_y * car2goal_y);
  return dist2goal;
}

double dist_(double goal_x,double goal_y)
{ 
    //计算车到目标点的距离
  double car2goal_x = goal_x - car_odom_.pose.pose.position.x;
  double car2goal_y = goal_y - car_odom_.pose.pose.position.y;
  double dist2goal = sqrt(car2goal_x * car2goal_x + car2goal_y * car2goal_y);
  return dist2goal;
}

 int main(int argc, char** argv)
{
    setlocale(LC_ALL, "");
    ros::init(argc, argv, "twist_transform"); //初始化ros节点的常规操作
    //在ctrl+c时有效执行退出操作，方便扩展
    // signal(SIGINT, DoShutdown);

    ros::NodeHandle nh;
    // ros::Subscriber  odom_sub = nh.subscribe<nav_msgs::Odometry>("/odom_data",10,odomCallback);
    // ros::Subscriber  odom_sub_ = nh.subscribe<nav_msgs::Odometry>("/odom",10,odomCallback_);

    ros::Subscriber amcl_sub = nh.subscribe<geometry_msgs::PoseWithCovarianceStamped> ("/amcl_pose", 3,amclCB);


    nh.setParam("task",0);  
    ros::param::set("toward",0.8);
    ros::param::set("/trafficlight_enable",0);

     ros::param::set("enable_move_base",0); //使能movebase规划器件   

    ros::Rate loop_rate(5);
    // tf::TransformListener listener;

    while (ros::ok())
    {
        ros::param::get("end_point_x",end_point_x);
        ros::param::get("end_point_y",end_point_y);
      

        int ai_car_task = ros::param::param("/task",0);

        if(ai_car_task == 0)
        {
            if(task00_flag == false)
            {
                if(dist(end_point_x, end_point_y)<=0.3)
                // if(dist(end_point_x[ai_car_task], end_point_y[ai_car_task])<=0.3)
                {
                    flag0=1;
                }
               //
            //    ROS_INFO("____%.2f________odom_data",dist(end_point_x, end_point_y));
            //    ROS_INFO("----------------------------------正在发往装货点");
            }
            if(flag0 == 1)
            {
                ros::param::set("/task",1);
                // [ INFO] [1688889801.567056174]: Setting goal: Frame:map, Position(2.111, -5.784, 0.000), Orientation(0.000, 0.000, -0.715, 0.699) = Angle: -1.593 红绿灯点
                // [ INFO] [1688889808.180440095]: Setting goal: Frame:map, Position(0.877, -7.606, 0.000), Orientation(0.000, 0.000, 1.000, -0.002) = Angle: -3.138上坡前
                // [ INFO] [1688889812.861655704]: Setting goal: Frame:map, Position(-0.897, -7.599, 0.000), Orientation(0.000, 0.000, 1.000, -0.003) = Angle: -3.135下坡
                ros::param::set("/trafficlight_enable",1);
                task00_flag = true;
                task01_flag = false;
                task02_flag = false;
                task03_flag = false;
                task04_flag = false;
                task05_flag = false;
                task06_flag = false;
                task07_flag = false;
                task08_flag = false;
                flag0 = 0;
                ros::param::set("enable_move_base",1); //使能movebase规划器件   
                ROS_INFO("enable_move_base   is :True");

                ros::Duration du1(2);//
                du1.sleep();//
                send_point(0.810, -7.546, 0.734472153866 , 0.678638825293,0);
                
                // podao_flag=1;
            }
        }

        //任务1    装货区到卸货
        if(ai_car_task == 1)
        {
            if(task01_flag == false)
            {
               
                if(amcl_pose.pose.pose.position.x<0.5 )
                     send_point(-0.875, -7.588, 0.734472153866 , 0.678638825293,0);
                if(amcl_pose.pose.pose.position.y>-7.3)
                    ros::param::set("enable_move_base",0); 
                
                // if  (amcl_pose.pose.pose.position.y<-5.8 && podao_flag==1 )
                // {
                //     send_point(0.948, -7.555, 1 ,1);
                //     podao_flag=2;
                // }
                // if(amcl_pose.pose.pose.position.x>0 && podao_flag==2)
                // {
                //     send_point(-0.925, -7.525, 1 ,1);
                //     podao_flag=3;
                // }
                // if(amcl_pose.pose.pose.position.x<0 && podao_flag==3)
                // {
                //      ros::param::set("enable_move_base",0);
                //      podao_flag=0;
                // }
               

                if(dist(end_point_x, end_point_y)<=0.3)
                // if(dist(end_point_x[ai_car_task], end_point_y[ai_car_task])<=0.3)
                {
                    flag1=1;
                    ros::param::set("/trafficlight_enable",0);
                    // break;
                }
               //装货区坐标
            //    ROS_INFO("____%.2f________odom_data",dist(end_point_x, end_point_y));
            //    ROS_INFO("----------------------------------正在发往卸货点");
            }
            if(flag1 == 1)
            {
                // ros::param::set("Angle_gain_p",-6.6);    //1.5
                // ros::param::set("Angle_gain_d",-11.2);
                ros::param::set("Angle_gain_p",-4.2);    //1.5
                ros::param::set("Angle_gain_d",-6.8);

                ros::param::set("Lfw",0.86);
                // ros::param::set("toward",1.5);
                ros::param::set("toward",1.1);
                ros::param::set("/task",2);
                // ROS_INFP("rUN_________--");
                task00_flag = false;
                task01_flag = true;
                task02_flag = false;
                task03_flag = false;
                task04_flag = false;
                task05_flag = false;
                task06_flag = false;
                task07_flag = false;
                task08_flag = false;
                flag1 = 0;
            }
        }
        //任务2 卸货到倒车点    改为卸货到s弯入口
        else if(ai_car_task == 2){
            if(task02_flag ==false){
                if(dist(end_point_x, end_point_y)<=0.30)
                // if(dist(end_point_x[ai_car_task], end_point_y[ai_car_task])<=0.3)
                {
                    flag2=1;
                }
            //    ROS_INFO("____%.2f________odom_data",dist(end_point_x, end_point_y));
            //    ROS_INFO("----------------------------------即将到达s弯入口");
            }
            if(flag2 == 1)
            {
                ros::param::set("task",3);
                // ros::param::set("offset_enable",1);
                 ros::param::set("offset_enable",0);
                task00_flag = false;
                task01_flag = false;
                task02_flag = true;
                task03_flag = false;
                task04_flag = false;
                task05_flag = false;
                task06_flag = false;
                task07_flag = false;
                task08_flag = false;
                flag2 = 0;
            }
        }
        else if (ai_car_task==3){   //找s弯出口
            if(task03_flag ==false){
                // if(dist(end_point_x, end_point_y)<=0.30)
                // if(dist(end_point_x[ai_car_task], end_point_y[ai_car_task])<=0.3)
                if(amcl_pose.pose.pose.position.y>=end_point_y)
                {   //这个点是自己给的  s弯出口
                    flag3=1;
                    ros::param::set("offset_enable",0);
                }
                // ROS_INFO("____%.2f________odom_data",dist(end_point_x, end_point_y));
                // ROS_INFO("----------------------------------正在前往s弯出口");
            }
            if(flag3 == 1)
            {
                ros::param::set("task",4);
                task00_flag = false;
                task01_flag = false;
                task02_flag = false;
                task03_flag = true;
                task04_flag = false;
                task05_flag = false;
                task06_flag = false;
                task07_flag = false;
                task08_flag = false;
                flag3 = 0;
            }
        }

        else if(ai_car_task==4) {
            if(task04_flag ==false){
                if(dist(end_point_x, end_point_y)<=0.30)
                // if(dist(end_point_x[ai_car_task], end_point_y[ai_car_task])<=0.3)
                {   //这个点是识别第停车标志的点
                    flag4=1;
                }
                // ROS_INFO("____%.2f________odom_data",dist(end_point_x, end_point_y));
                // ROS_INFO("----------------------------------正在前往停车标志位");
            }
            if(flag4 == 1)
            {
                ros::param::get("/word_recognition",FLAG_daoche);

                ros::param::set("Angle_gain_p",-3.4);
                ros::param::set("Angle_gain_d",-4.2);
                ros::param::set("Lfw",0.60);
                if(FLAG_daoche==1){
                    ros::param::set("task",5);
                    ros::param::set("toward",-0.8);          
                    // ros::param::set("toward",-1.0);                 
                }
                if(FLAG_daoche==0){
                    ros::param::set("task",6);                  
                    ros::param::set("toward",-0.8);
                    // ros::param::set("toward",-1.0);
                }
                task00_flag = false;
                task01_flag = false;
                task02_flag = false;
                task03_flag = false;
                task04_flag = true;
                task05_flag = false;
                task06_flag = false;
                task07_flag = false;
                task08_flag = false;
                flag4 = 0;
            }
        }

//任务3    倒车点到车库1
        else if(ai_car_task == 5)
        {
            if(task05_flag ==false)
            {
                if(dist(end_point_x,end_point_y)<=0.30)
                // if(dist(end_point_x[ai_car_task], end_point_y[ai_car_task])<=0.3)
                {
                    flag5=1;
                }
                // ROS_INFO("____%.2f________odom_data",dist(end_point_x, end_point_y));
                // ROS_INFO("----------------------------------正在倒向第一个车库");
            }
            if(flag5 == 1)
            {
                ros::param::set("Angle_gain_p",-3.0);
                ros::param::set("Angle_gain_d",-6.9);
                ros::param::set("task",7);
                ros::param::set("toward",0.8);
                task00_flag = false;                  
                task01_flag = false;
                task02_flag = false;
                task03_flag = false;
                task04_flag = false;
                task05_flag = true;
                task06_flag = false;
                task07_flag = false;
                task08_flag = false;
                flag5 = 0;
            }
        }

//倒车点到车库2
        else if(ai_car_task == 6)
        {
            if(task06_flag ==false)
            {
                if(dist(end_point_x, end_point_y)<=0.30)
                // if(dist(end_point_x[ai_car_task], end_point_y[ai_car_task])<=0.3)
                {
                    flag6=1;
                }
                // ROS_INFO("____%.2f________odom_data",dist(end_point_x, end_point_y));
                // ROS_INFO("----------------------------------正在倒向第二个车库");
            }
            if(flag6 == 1)
            {
                ros::param::set("task",8);   
                ros::param::set("toward",0.8);
                ros::param::set("Angle_gain_p",-3.0);
                ros::param::set("Angle_gain_d",-6.9);
                task00_flag = false;
                task01_flag = false;
                task02_flag = false;
                task03_flag = false;
                task04_flag = false;
                task05_flag = false;
                task06_flag = true;
                task07_flag = false;
                task08_flag = false;
                flag6 = 0;
            } 
        } 
//车库1到起点
        else if(ai_car_task == 7)
        {
            if(task07_flag ==false)
            {
                if(dist(end_point_x,end_point_y)<=0.30)
                // if(dist(end_point_x[ai_car_task], end_point_y[ai_car_task])<=0.3)
                {
                    flag7=1;
                }
                // ROS_INFO("____%.2f________odom_data",dist(end_point_x, end_point_y));
                // ROS_INFO("----------------------------------正在从车库1回到出发点");
            }
            if(flag7 == 1)
            {
                ros::param::set("task",0);
                task00_flag = false;
                task01_flag = false;
                task02_flag = false;
                task03_flag = false;
                task04_flag = false;
                task05_flag = false;
                task06_flag = false;
                task07_flag = true;
                task08_flag = false;
                flag7 = 0;
            } 
        } 
//倒车2到起点
        else if(ai_car_task == 8)
        {
            if(task08_flag ==false)
            {
                if(dist(end_point_x,end_point_y)<=0.30)
                // if(dist(end_point_x[ai_car_task], end_point_y[ai_car_task])<=0.3)
                {
                    flag8=1;
                }
                // ROS_INFO("____%.2f________odom_data",dist(end_point_x, end_point_y));
                // ROS_INFO("----------------------------------正在从车库2回到出发点");
            }
            if(flag8 == 1)
            {
                ros::param::set("task",0);
                task00_flag = false;
                task01_flag = false;
                task02_flag = false;
                task03_flag = false;
                task04_flag = false;
                task05_flag = false;
                task06_flag = false;
                task07_flag = false;
                task08_flag = true;
                flag8 = 0;
            } 
        } 
        ros::spinOnce();
        loop_rate.sleep();
    }
    
    return 0;
}




