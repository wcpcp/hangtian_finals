#include <geometry_msgs/PoseStamped.h>
#include <tf/transform_listener.h>
#include <ros/ros.h>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "nav_msgs/Odometry.h"
#include "nav_msgs/Path.h"
#include "geometry_msgs/PoseStamped.h"
#include <tf/transform_listener.h>
#include <iostream>
#include <fstream>
int main(int argc, char** argv)
{
  ros::init(argc, argv, "goal_publisher");
  ros::NodeHandle nh;
  ros::Publisher goal_pub = nh.advertise<geometry_msgs::PoseStamped>("/move_base_simple/goal", 1);
  // ros::Publisher goal_pub = nh.advertise<geometry_msgs::PoseStamped>("/goal1", 1);
  tf::TransformListener listener;
  ros::Rate rate(20);
  int pub_goal_mode=1;
  
  while (nh.ok())
  {
    // ROS_INFO("pub_goal_mode is: %d",pub_goal_mode);
    if(pub_goal_mode==1){
      tf::StampedTransform transform;
      try
      {
        listener.lookupTransform("map", "/base_footprint", ros::Time(0), transform);
      }
      catch (tf::TransformException ex)
      {
        // ROS_ERROR("%s",ex.what());
        // ros::Duration(0.2).sleep();
        continue;
      }
      geometry_msgs::PoseStamped goal;
      goal.header.stamp = ros::Time::now();
      goal.header.frame_id = "map";
      goal.pose.position.y = std::max(transform.getOrigin().y(),-2.0); // 目标点的x坐标为机器人实时位置的x坐标，但不能小于3    左

      goal.pose.position.x = -1.5; // 目标点的y坐标为0

      goal.pose.orientation.w=1;
        // -0.419 -2.708

      // 发布目标点
      goal_pub.publish(goal);

    }

    rate.sleep();
  }

  return 0;
}
