#include "ros/ros.h"
#include "std_msgs/String.h"
#include <geometry_msgs/PoseWithCovarianceStamped.h>
#include <iostream>
#include <geometry_msgs/PoseStamped.h>
 
void chatterCallback(const geometry_msgs::PoseWithCovarianceStamped::ConstPtr& msg)
{
  double x=msg->pose.pose.position.x;
  double y=msg->pose.pose.position.y;
  std::cout<<x<<y<<std::endl;
}
 
void chatterCallback1(const geometry_msgs::PoseStamped::ConstPtr& msg)
{
  std::cout<<"1111"<<std::endl;
  double x=msg->pose.position.x;
  double y=msg->pose.position.y;
  std::cout<<"x:  "<<x<<"\t"<<"y: "<<y<<std::endl;

}
int main(int argc, char **argv)
{
  ros::init(argc, argv, "reveive_rviz");
  ros::NodeHandle nh;
 
  ros::Subscriber sub = nh.subscribe("/initialpose", 1, chatterCallback);//队列长度:1000或1或其他
  ros::Subscriber sub1 = nh.subscribe("/move_base_simple/goal", 1, chatterCallback1);//队列长度:1000或1或其他
 
  while(ros::ok())
  {
    ros::spinOnce();
  }
 
  return 0;
}