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

using namespace std;

int cmd_vel_flag = 0;//0为导航控制底盘，1为视觉控制底盘
bool task01_flag = false;
bool task02_flag = false;
bool task03_flag = false;
bool first_cycle = true;
int flag1 = 0,flag2 = 0,flag3 = 0,flag4 = 0,start_point = 0;
// ros::Publisher twist_pub_;  //声明
// ros::Subscriber  twist_sub_nav;
// ros::Subscriber  twist_sub_line;
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

/**
 * @brief 主控回调函数
 * 
 * @param p 
 */
void doPose(const geometry_msgs::PoseWithCovarianceStamped::ConstPtr &p)
{
    int ai_car_task = ros::param::param("/task",0);      
    if(ai_car_task == 3)//任务3     S弯起点
    {
        if(task03_flag ==false)
        {
            // send_point( 1.4,-4.2654367687 ,0.734472153866 , 0.678638825293  ,0);//往前一秒，可以顺利拐弯
            send_point( 1.45,-4.00 ,0.734472153866 , 0.678638825293  ,0);
            ros::Duration du4(1.0);//
            du4.sleep();//
            ros::param::set("/acc_lim_theta",4.5);
            ros::param::set("/max_vel_theta",3.0);
            ros::Duration du6(3.75);//   3.5->3.6
            du6.sleep();//按照指定的持续时间休眠
            ros::param::set("/acc_lim_theta",1.2); //1.0->1.2
            ros::param::set("/max_vel_theta",1.2);

            ros::param::set("/offset_enable",1); //开启视觉寻线

            // send_point( 1.05,-4.24554367687 ,0.734472153866, 0.678638825293  ,0);
            flag3 = send_point( 1.19,-4.00 ,0.734472153866 , 0.678638825293  ,0); // 1.21 ->1.20
            task01_flag = false;
            task02_flag = false;
            task03_flag = true ;
        }

        // if(flag3 == 1)
        // {
        //     ros::param::set("/offset_enable",1); //开启视觉寻线
        //     ros::param::set("/cmd_vel_ctrl",1); //视觉控制底盘

        // }
        if(p->pose.pose.position.x > 0.15 && p->pose.pose.position.y > -4.3  && p->pose.pose.position.y <-3.5)
        {

            ros::param::set("/cmd_vel_ctrl",1); //视觉控制底盘
            // ros::param::set("/acc_lim_theta",3.0);
            // ros::param::set("/max_vel_theta",1.2);
        }
        if(p->pose.pose.position.x  < -0  && p->pose.pose.position.y > -2.3  && p->pose.pose.position.y <-1.3)
        {
            ros::param::set("/acc_lim_theta",4.0);
            ros::param::set("/max_vel_theta",1.0);
            // send_point( -0.0, 0.07250383221 ,0.0307858169385,0.999526004402,0 );
            send_point( 0 , -0.12 , 0 , 1 ,  0 ); 
            ros::param::set("/cmd_vel_ctrl",0); //导航控制底盘
            ros::Duration du9(0.3);//S弯出来以4.0的角加速度行驶1s
            du9.sleep();//
            ros::param::set("/acc_lim_theta",4.0);
            ros::param::set("/max_vel_theta",1.0);//恢复初始的导航参数
            start_point = send_point( 0 , -0.12 , 0 , 1 ,  1 ); //路径规划回到起点
            ROS_INFO("send start point  ");
            ros::param::set("/offset_enable",0); //关闭视觉寻线
        }
        if(start_point == 1)
        {
            // ros::param::set("/acc_lim_theta",0.4);
            // ros::param::set("/max_vel_theta",1.2);
            ros::param::set("/task",1);
            start_point = 0; 
        }
    }
}

int main(int argc, char** argv)
{
    ros::init(argc, argv, "twist_transform"); //初始化ros节点的常规操作
    //在ctrl+c时有效执行退出操作，方便扩展
    signal(SIGINT, DoShutdown);
    ros::NodeHandle nh;
    nh.setParam("task",0);
    ros::Subscriber sub = nh.subscribe<geometry_msgs::PoseWithCovarianceStamped>("/amcl_pose",5,doPose);
     while (ros::ok())
    {
        int ai_car_task = ros::param::param("/task",0);      
        if(ai_car_task == 0)
        {
            //ROS_INFO("0");
        }
        else if(ai_car_task == 1)//任务1    装货区
        {
            if(task01_flag == false)
            {
                if(first_cycle)
                {
                    ros::param::set("/acc_lim_theta",1.0);//开始点给大角加速度
                    ros::param::set("/max_vel_theta",1.2);
                    send_point(  2.30654840234,-3.18160017373,-0.695234006203,0.718783469912 ,0); 
                    ros::Duration du12(0.5);//大的角加速度行驶1s，使车头可以快速转过来
                    du12.sleep();//
                }
                if(!first_cycle)
                {
                    ros::param::set("/acc_lim_theta",4.0);//开始点给大角加速度
                    ros::param::set("/max_vel_theta",1.2);
                    send_point(  2.30654840234,-3.18160017373,-0.695234006203,0.718783469912 ,0); 
                    ros::Duration du8(1.3);//大的角加速度行驶1s，使车头可以快速转过来
                    du8.sleep();//
                }
                first_cycle = false;
                ros::param::set("/acc_lim_theta",0.35);//恢复初始的参数
                ros::param::set("/max_vel_theta",1.2);
                flag1 = send_point( 2.30654840234,-3.18160017373,-0.695234006203,0.718783469912 ,1); 
                task01_flag = true;
                task02_flag = false;
                task03_flag = false;
            }
            if(flag1 == 1)
            {
                ros::param::set("/trafficlight_enable",1); 
                ros::param::set("task",2);
                ros::param::set("/acc_lim_theta",0.55);

                //xiugai
                ros::param::set("/max_vel_theta",1.5);
                flag1 = 0;
            }
        }
        else if(ai_car_task == 2)//任务2    卸货区
        {
            if(task02_flag ==false)
            {
                send_point( 2.52654840234,-6.13606816442,-0.695234006203,0.718783469912 ,0);
                ros::Duration du2(1.2);
                du2.sleep();//按照指定的持续时间休眠

                send_point( -1.85, -7.0,0.702149203907  ,0.712029841687,0);
                ros::Duration du5(3);//持续10秒钟,参数是double类型的，以秒为单位
                du5.sleep();//按照指定的持续时间休眠


               flag2 = send_point(-1.88, -5.95627867826, 0.702149203907  ,0.712029841687  ,1 );
                task01_flag = false;
                task02_flag = true;
                task03_flag = false;
            }
            if(flag2 == 1)
            {
                ros::param::set("/trafficlight_enable",0);
                ros::param::set("task",3);

                //xiugai
                ros::param::set("/acc_lim_theta",0.4);//恢复初始的参数
                ros::param::set("/max_vel_theta",1.2);

                flag2 = 0;
            }
        } 
        ros::spinOnce();
    }
    return 0;
}
