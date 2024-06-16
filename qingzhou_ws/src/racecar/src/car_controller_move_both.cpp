/*
Copyright (c) 2017, ChanYuan KUO, YoRu LU,
latest editor: HaoChih, LIN
All rights reserved. (Hypha ROS Workshop)

This file is part of hypha_racecar package.

hypha_racecar is free software: you can redistribute it and/or modify
it under the terms of the GNU LESSER GENERAL PUBLIC LICENSE as published
by the Free Software Foundation, either version 3 of the License, or
any later version.

hypha_racecar is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU LESSER GENERAL PUBLIC LICENSE for more details.

You should have received a copy of the GNU LESSER GENERAL PUBLIC LICENSE
along with hypha_racecar.  If not, see <http://www.gnu.org/licenses/>.
*/

#include "nav_msgs/Path.h"
#include "ros/ros.h"
#include <geometry_msgs/PoseStamped.h>
#include <geometry_msgs/Twist.h>
#include <iostream>
#include <nav_msgs/Odometry.h>
#include <tf/transform_datatypes.h>
#include <tf/transform_listener.h>
#include <visualization_msgs/Marker.h>
#include <dynamic_reconfigure/server.h>

#include <geometry_msgs/PoseWithCovarianceStamped.h>


#include <cmath>
#include <std_msgs/Float64.h>

#define PI 3.14159265358979
double last_steeringangle = 0;
double L, Lfw, Lrv, Lfw_, Vcmd, lfw, lrv, steering, u, v;
double Gas_gain, baseAngle, baseSpeed, Angle_gain_p, Angle_gain_d, goalRadius;
int controller_freq;
bool foundForwardPt, goal_received, goal_reached;
double k_rou;
double vp_max_base, vp_min;
double stop_flag = 0.0;
int mapPathNum;
double slow_final, fast_final;
int stopIdx = 0;
double line_wight = 0.0;
double initbaseSpeed;
double obs_flag = 0.0;
double line_final_x,line_final_y;
double toward=1; //判断前进还是倒退   前进为1   倒退为-1

int last_task_flag=0,task_flag=1;
int enable_move=0;
bool path_kong=false;

bool red_traffic=false;   //判断是否是看到红灯
int vision_control=0;   //判断是否s弯用视觉控制



/********************/
/* CLASS DEFINITION */
/********************/
class L1Controller
{
public:
  L1Controller();
  void initMarker();
  bool isWayPtAwayFromLfwDist(const geometry_msgs::Point &wayPt, const geometry_msgs::Point &car_pos);
  bool isWayPtAwayFromLfwDist_twice(const geometry_msgs::Point &wayPt, const geometry_msgs::Point &car_pos);
  bool isForwardWayPt(const geometry_msgs::Point &wayPt, const geometry_msgs::Pose &carPose);
  double getYawFromPose(const geometry_msgs::Pose &carPose);
  double getEta(const geometry_msgs::Pose &carPose);
  double getCar2GoalDist();
  double getL1Distance(const double &_Vcmd);
  double getSteeringAngle(double eta);
  double getGasInput(const float &current_v);
  double isline(double line_wight);
  geometry_msgs::Point get_odom_car2WayPtVec(const geometry_msgs::Pose &carPose);

private:
  ros::NodeHandle n_;
  ros::Subscriber odom_sub, path_sub, goal_sub, encoder_sub, final_goal_sub, line_sub;
  ros::Publisher pub_, marker_pub;
  ros::Timer timer1,timer2,timer3;
  tf::TransformListener tf_listener;

  ros::Subscriber amcl_sub;

  visualization_msgs::Marker points, line_strip, goal_circle;
  geometry_msgs::Twist cmd_vel;
  geometry_msgs::Point odom_goal_pos;
  nav_msgs::Odometry odom, encoder;
  nav_msgs::Path map_path, odom_path;



  geometry_msgs::PoseWithCovarianceStamped amcl_pose;


  void odomCB(const nav_msgs::Odometry::ConstPtr &odomMsg);
  void pathCB(const nav_msgs::Path::ConstPtr &pathMsg);
  void goalCB(const geometry_msgs::PoseStamped::ConstPtr &goalMsg);
  void goalReachingCB(const ros::TimerEvent &);
  void controlLoopCB(const ros::TimerEvent &);
  void odomgoalCB(const ros::TimerEvent &);

  void amclCB(const geometry_msgs::PoseWithCovarianceStamped::ConstPtr &amclMsg);

}; // end of class

L1Controller::L1Controller()
{
  // Private parameters handler
  ros::NodeHandle pn("~");
  
  ros::NodeHandle nh;
  nh.param("toward",toward,1.0);  //这是判断是前进还是倒退

  // Car parameter
  pn.param("L", L, 0.335);      //前后轮轴距
  pn.param("Vcmd", Vcmd, 1.0);  //期望速度
  pn.param("lfw", lfw, 0.1675); //车身转向控制点
  pn.param("Lfw", Lfw, 0.3);   //这个是前瞻点

  // Controller parameter
  pn.param("controller_freq", controller_freq, 20); //控制循环频率
  pn.param("Angle_gain_p", Angle_gain_p, -1.0);
  pn.param("Angle_gain_d", Angle_gain_d, -0.0);
  pn.param("baseSpeed", baseSpeed, 0.0); //基础速度
  pn.param("baseAngle", baseAngle, 0.0); //舵机中值     舵机打角steeringangle设为-90度～90度
  pn.param("k_rou", k_rou, 0.0);         //类曲率调速的系数
  pn.param("vp_max_base", vp_max_base, 0.0);
  pn.param("vp_min", vp_min, 0.0);
  pn.param("goalRadius", goalRadius, 1.0);
  pn.param("slow_final", slow_final, 0.8);
  pn.param("fast_final", fast_final, 1.1);
  pn.param("end_point_x", line_final_x, 0.0);//这是传入的每个任务路径的终点
  pn.param("end_point_y", line_final_y, 0.0);

  //odom_goal_pos.x = line_final_x;   //这个是用来计算车辆当前位置和任务路径终点的
  //odom_goal_pos.y = line_final_y;
  
  initbaseSpeed = baseSpeed;
  odom_sub = n_.subscribe("/odom_data", 1, &L1Controller::odomCB, this); //订阅里程计
  path_sub = n_.subscribe("/path2", 1, &L1Controller::pathCB, this);



  goal_sub = n_.subscribe("/move_base_simple/goal", 1, &L1Controller::goalCB, this); //订阅movebase目标点
  amcl_sub = n_.subscribe("/amcl_pose", 1, &L1Controller::amclCB, this); //订阅里程计
  
  marker_pub = n_.advertise<visualization_msgs::Marker>("car_path_move", 10); //发布路径到rviz

  pub_ = n_.advertise<geometry_msgs::Twist>("/cmd_vel_move", 1);           //发布速度、角速度

  // Timer
  timer3 = n_.createTimer(ros::Duration((10.0) / controller_freq), &L1Controller::odomgoalCB, this);  // Duration(0.05) -> 20Hz
  timer1 = n_.createTimer(ros::Duration((1.0) / controller_freq), &L1Controller::controlLoopCB, this);  // Duration(0.05) -> 20Hz
  // timer2 = n_.createTimer(ros::Duration((0.5) / controller_freq), &L1Controller::goalReachingCB, this); // Duration(0.05) -> 20Hz

  // 初始化变量
  foundForwardPt = false;
  goal_received = true;
  goal_reached = false;
  cmd_vel.linear.x = baseSpeed;          // 0 for stop
  cmd_vel.angular.z = baseAngle; //中值

  // Show info
  ROS_INFO("[param] baseSpeed: %f", baseSpeed);
  ROS_INFO("[param] baseAngle: %f", baseAngle);
  ROS_INFO("[param] Angle_gain_p: %f", Angle_gain_p);
  ROS_INFO("[param] Angle_gain_d: %f", Angle_gain_d);
  ROS_INFO("[param] Vcmd: %f", Vcmd);
  ROS_INFO("[param] Lfw: %f", Lfw);

  // Visualization Marker Settings
  initMarker();
}

//rviz可视化初始化
void L1Controller::initMarker()
{
  points.header.frame_id = line_strip.header.frame_id = goal_circle.header.frame_id = "odom";
  points.ns = line_strip.ns = goal_circle.ns = "Markers";
  points.action = line_strip.action = goal_circle.action = visualization_msgs::Marker::ADD;
  points.pose.orientation.w = line_strip.pose.orientation.w = goal_circle.pose.orientation.w = 1.0;
  points.id = 0;
  line_strip.id = 1;
  goal_circle.id = 2;

  points.type = visualization_msgs::Marker::POINTS;
  line_strip.type = visualization_msgs::Marker::LINE_STRIP;
  goal_circle.type = visualization_msgs::Marker::CYLINDER;
  // POINTS markers use x and y scale for width/height respectively
  points.scale.x = 0.2;
  points.scale.y = 0.2;

  // LINE_STRIP markers use only the x component of scale, for the line width
  line_strip.scale.x = 0.1;

  goal_circle.scale.x = goalRadius;
  goal_circle.scale.y = goalRadius;
  goal_circle.scale.z = 0.1;

  // Points are green
  points.color.g = 1.0f;
  points.color.a = 1.0;

  // Line strip is blue
  line_strip.color.b = 1.0;
  line_strip.color.a = 1.0;

  // goal_circle is yellow
  goal_circle.color.r = 1.0;
  goal_circle.color.g = 1.0;
  goal_circle.color.b = 0.0;
  goal_circle.color.a = 0.5;
}

void L1Controller::odomCB(const nav_msgs::Odometry::ConstPtr &odomMsg)
{ //里程计回调函数
  odom = *odomMsg;
}



void L1Controller::amclCB(const geometry_msgs::PoseWithCovarianceStamped::ConstPtr &amclMsg)
{ //里程计回调函数
  amcl_pose=*amclMsg;
  // if(amclMsg->pose.pose.position.x  < 1.0  && amclMsg->pose.pose.position.x > -1.5  && amclMsg->pose.pose.position.y <-7.0)
  //   //if(  p->pose.pose.position.y > 1.68*p->pose.pose.position.x )
  //   {
  //       ros::param::set("/is_podao",1);
  //       ROS_INFO("limit  Angle amplitude!!  ");
  //   }
  ros::param::get("toward",toward);
  if(amcl_pose.pose.pose.position.y<-6.5)
  {
    toward=0.6;
    ros::param::set("Angle_gain_p",-3.4);
    ros::param::set("Angle_gain_d",-4.6);
  }
}

void L1Controller::pathCB(const nav_msgs::Path::ConstPtr &pathMsg)
{ //路径点回调函数
  //如果没路径了按上次路径走
  static int pathCBidx = 0;
  static nav_msgs::Path last_map_path;
  if (pathCBidx == 0)
  {

    last_map_path.poses.clear();
  }
  map_path = *pathMsg;
  mapPathNum = map_path.poses.size();
  if (map_path.poses.size() <= 0)
  {
    path_kong = true;
    for (int i = 0; i < last_map_path.poses.size(); i++)
    {
      map_path.poses.push_back(last_map_path.poses[i]);
    }
  }
  else
  {
    path_kong = false;
    last_map_path.poses.clear();
    for (int i = 0; i < map_path.poses.size(); i++)
    {
      last_map_path.poses.push_back(map_path.poses[i]);
    }

  }
  pathCBidx++;
}









void L1Controller::goalCB(const geometry_msgs::PoseStamped::ConstPtr &goalMsg)
{ //目标点回调函数
  try
  {
    geometry_msgs::PoseStamped odom_goal;
    tf_listener.transformPose("odom", ros::Time(0), *goalMsg, "map", odom_goal);

    odom_goal_pos = odom_goal.pose.position;
    // goal_received = true;
    // goal_reached = false;

    /*Draw Goal on RVIZ*/
    goal_circle.pose = odom_goal.pose;
    marker_pub.publish(goal_circle);
  }
  catch (tf::TransformException &ex)
  {
    ROS_ERROR("%s", ex.what());
    ros::Duration(1.0).sleep();
  }

}

double L1Controller::getYawFromPose(const geometry_msgs::Pose &carPose)
{ //计算航向角
  float x = carPose.orientation.x;
  float y = carPose.orientation.y;
  float z = carPose.orientation.z;
  float w = carPose.orientation.w;

  double tmp, yaw;
  tf::Quaternion q(x, y, z, w);
  tf::Matrix3x3 quaternion(q);
  quaternion.getRPY(tmp, tmp, yaw);

  return yaw;
}

bool L1Controller::isForwardWayPt(const geometry_msgs::Point &wayPt,
                                  const geometry_msgs::Pose &carPose)
{
  float car2wayPt_x = wayPt.x - carPose.position.x;
  float car2wayPt_y = wayPt.y - carPose.position.y;
  double car_theta = getYawFromPose(carPose);

  float car_car2wayPt_x = cos(car_theta) * car2wayPt_x + sin(car_theta) * car2wayPt_y;
  float car_car2wayPt_y = -sin(car_theta) * car2wayPt_x + cos(car_theta) * car2wayPt_y;

  if(toward>=0){    //toward=1则是前进
    if (car_car2wayPt_x > 0) /*is Forward WayPt*/
      return true;
    else
      return false;
  }else{
    if (car_car2wayPt_x < 0) /*is backward WayPt*/
      return true;
    else
      return false;
  }
}

bool L1Controller::isWayPtAwayFromLfwDist(const geometry_msgs::Point &wayPt, const geometry_msgs::Point &car_pos)
{ //判断是否是前瞻外的一个点
  double dx = wayPt.x - car_pos.x;
  double dy = wayPt.y - car_pos.y;
  double dist = sqrt(dx * dx + dy * dy);

  if (dist < Lfw)
    return false;
  else if (dist >= Lfw)
    return true;
  return 0;
}

bool L1Controller::isWayPtAwayFromLfwDist_twice(const geometry_msgs::Point &wayPt, const geometry_msgs::Point &car_pos)
{ //判断是否是前瞻外2倍的一个点
  double dx = wayPt.x - car_pos.x;
  double dy = wayPt.y - car_pos.y;
  double dist = sqrt(dx * dx + dy * dy);
  // ROS_INFO("dist = %.2f",dist);

  if(dist>=2*Lfw){
    return true;
  }else{
    return false;
  }
}

// void callback(const art_racecar::racecarConfig &config, const uint32_t level)
// { //reconfigure配置动态参数
//   ROS_INFO("param changed");
//   L = config.L;
//   Vcmd = config.Vcmd;
//   Lfw = config.lfw;
//   controller_freq = config.controller_freq;
//   Angle_gain_p = config.Angle_gain_p;
//   Angle_gain_d = config.Angle_gain_d;
//   baseSpeed = config.baseSpeed;
//   k_rou = config.k_rou;
// }

geometry_msgs::Point L1Controller::get_odom_car2WayPtVec(const geometry_msgs::Pose &carPose)
{ //计算前瞻向量
  geometry_msgs::Point carPose_pos = carPose.position;
  double carPose_yaw = getYawFromPose(carPose);
  geometry_msgs::Point forwardPt;
  forwardPt.x = amcl_pose.pose.pose.position.x;
  forwardPt.y = amcl_pose.pose.pose.position.y;

  geometry_msgs::PoseStamped odom_path_pose;


  // try
  // {
  //   tf_listener.transformPose("odom", ros::Time(0), map_path.poses[map_path.poses.size()-1], "map", odom_path_pose);
  //   forwardPt.x = odom_path_pose.pose.position.x;
  //   forwardPt.y = odom_path_pose.pose.position.y;
  // }
  // catch (tf::TransformException &ex)
  // {
  //   ROS_ERROR("%s", ex.what());
  //   // ros::Duration(1.0).sleep();
  // }

  geometry_msgs::Point odom_car2WayPtVec;
  foundForwardPt = false;
  double car2goal_dist = getCar2GoalDist();
  bool start_flag = false;
  if(map_path.poses.size()<=0){
    forwardPt.x = amcl_pose.pose.pose.position.x;
    forwardPt.y = amcl_pose.pose.pose.position.y;

    // try
    // {
    //   tf_listener.transformPose("odom", ros::Time(0), map_path.poses[map_path.poses.size()-1], "map", odom_path_pose);
    //   forwardPt.x = odom_path_pose.pose.position.x;
    //   forwardPt.y = odom_path_pose.pose.position.y;
    // }
    // catch (tf::TransformException &ex)
    // {
    //   ROS_ERROR("%s", ex.what());
    //   // ros::Duration(1.0).sleep();
    // }
    // // forwardPt = odom_goal_pos;
    // foundForwardPt = true;
  }else
  {
    if (!goal_reached)
    {
      for (int i = 0; i < map_path.poses.size(); i++)
      {
        geometry_msgs::PoseStamped map_path_pose = map_path.poses[i];
        geometry_msgs::PoseStamped odom_path_pose;
        // geometry_msgs::PoseStamped odom_path_pose = map_path.poses[i];
        try
        {
          car2goal_dist = getCar2GoalDist();
          
          tf_listener.transformPose("odom", ros::Time(0), map_path_pose, "map", odom_path_pose);
          geometry_msgs::Point odom_path_wayPt = odom_path_pose.pose.position;

          if(isWayPtAwayFromLfwDist_twice(odom_path_wayPt, carPose_pos))   //如果是两倍距离的   直接跳过  
          {
            continue;
          }


          bool _isForwardWayPt = isForwardWayPt(odom_path_wayPt, carPose);   //是否是前面的点

          if (_isForwardWayPt && start_flag == false)
          {
            start_flag = true;
          }
          if (start_flag == false)
          {
            continue;
          }


          if (_isForwardWayPt || 1)
          {
            bool _isWayPtAwayFromLfwDist = isWayPtAwayFromLfwDist(odom_path_wayPt, carPose_pos);
            if (_isWayPtAwayFromLfwDist)
            {
              forwardPt = odom_path_wayPt;
              foundForwardPt = true;
              break;
            }
          }


          if (car2goal_dist < Lfw)
          {
            try
            {
              tf_listener.transformPose("odom", ros::Time(0), map_path.poses[map_path.poses.size()-1], "map", odom_path_pose);
              forwardPt.x = odom_path_pose.pose.position.x;
              forwardPt.y = odom_path_pose.pose.position.y;
            }
            catch (tf::TransformException &ex)
            {
              ROS_ERROR("%s", ex.what());
              // ros::Duration(1.0).sleep();
            }
            // forwardPt = odom_goal_pos;
            foundForwardPt = true;
          }
        }
        catch (tf::TransformException &ex)
        {
          ROS_ERROR("%s", ex.what());
          ros::Duration(1.0).sleep();
        }
      }
      
    }
    else if(goal_reached)   //如果到目标点范围内
    {
      try
      {
        tf_listener.transformPose("odom", ros::Time(0), map_path.poses[map_path.poses.size()-1], "map", odom_path_pose);
        forwardPt.x = odom_path_pose.pose.position.x;
        forwardPt.y = odom_path_pose.pose.position.y;
      }
      catch (tf::TransformException &ex)
      {
        ROS_ERROR("%s", ex.what());
        // ros::Duration(1.0).sleep();
      }
      foundForwardPt = true;
      // ROS_INFO("goal REACHED!");
    }
  }

  /*Visualized Target Point on RVIZ*/
  /*Clear former target point Marker*/
  points.points.clear();
  line_strip.points.clear();

  // if (foundForwardPt && !goal_reached)
  // {
  //   points.points.push_back(carPose_pos);
  //   points.points.push_back(forwardPt);
  //   line_strip.points.push_back(carPose_pos);
  //   line_strip.points.push_back(forwardPt);
  // }

  points.points.push_back(carPose_pos);
  points.points.push_back(forwardPt);
  line_strip.points.push_back(carPose_pos);
  line_strip.points.push_back(forwardPt);

  marker_pub.publish(points);
  marker_pub.publish(line_strip);

  ROS_INFO("forward_point_x = %.2f   forward_point_y = %.2f",forwardPt.x,forwardPt.y);


  odom_car2WayPtVec.x = cos(carPose_yaw) * (forwardPt.x - carPose_pos.x) + sin(carPose_yaw) * (forwardPt.y - carPose_pos.y);
  odom_car2WayPtVec.y = -sin(carPose_yaw) * (forwardPt.x - carPose_pos.x) + cos(carPose_yaw) * (forwardPt.y - carPose_pos.y);
  return odom_car2WayPtVec;
}

double L1Controller::getEta(const geometry_msgs::Pose &carPose)
{ //根据前瞻向量求车到前瞻点和车中心线的夹角
  geometry_msgs::Point odom_car2WayPtVec = get_odom_car2WayPtVec(carPose);
  double eta = atan2(odom_car2WayPtVec.y, odom_car2WayPtVec.x);
  return eta;
}

double L1Controller::getCar2GoalDist()
{ //计算车到目标点的距离
  geometry_msgs::Point car_pose = amcl_pose.pose.pose.position;
  double car2goal_x = odom_goal_pos.x - car_pose.x;
  double car2goal_y = odom_goal_pos.y - car_pose.y;


  double dist2goal = sqrt(car2goal_x * car2goal_x + car2goal_y * car2goal_y);
  return dist2goal;
}

double L1Controller::getL1Distance(const double &_Vcmd)
{ //根据速度变前瞻距离
  double L1 = 0;
  double car2goal_dist = getCar2GoalDist();
  double v = _Vcmd;
  /*if (   < 1)
  {
   L1 = 0.5; 
  }
  else
  {*/
  L1 = 1.45;
  //}
  // L1 = 0.65 + 0.6 * _Vcmd;

  return L1;
}

double L1Controller::getSteeringAngle(double eta)
{ //纯追踪算舵机打角
  double steeringAnge=0;
  // ros::param::get("toward",toward);
  if(toward>=0){
    steeringAnge = atan2((L * sin(eta)), ((Lfw / 2) + lfw * cos(eta))) * (180.0 / PI);
  }else{
    steeringAnge = atan2((2*L*sin(eta)),Lfw)*(180.0/PI);
  }
  // ROS_INFO("Steering Angle = %.2f ,    eta = %.2f,   toward = %d",steeringAnge,eta,toward);
  return steeringAnge;
}

// double L1Controller::getSteeringAngle(double eta)
// { //纯追踪算舵机打角
//   // double steeringAnge = atan2((L * sin(eta)), ((Lfw / 2) + lfw * cos(eta))) * (180.0 / PI);
//   double steeringAnge = atan2((2*L*sin(eta)),Lfw)*(180.0/PI);
//   ROS_INFO("Steering Angle = %.2f", steeringAnge);
//   return steeringAnge;
// }

void L1Controller::goalReachingCB(const ros::TimerEvent &)
{ //小车到达目标点后

  if (goal_received)
  {
    double car2goal_dist = getCar2GoalDist();
    ROS_INFO("the car to the goal is = %.2f",car2goal_dist); 
    if (car2goal_dist < goalRadius)
    {
      goal_reached = true;

      // goal_received = false;
      cmd_vel.linear.x = 0;
      cmd_vel.angular.z = 0;
      if(vision_control==0){
        pub_.publish(cmd_vel);
      }
      // ros::param::set("/path_choose",3);
      ROS_INFO("Path_goal!!!!!!!!!!!!!!!!!!!!!!!");

      //关闭节点
      // ros::Duration(5).sleep();
      // system("rosnode kill car_controller");
      // line_final_x=2.302;
      // line_final_y=-3.49;
      // ros::param::set("Lfw",0.6);
    }else{
      goal_reached = false;
    }
  }
}

void L1Controller::odomgoalCB(const ros::TimerEvent &)
{ //刷新目标点
  ros::param::get("end_point_x",line_final_x);
  ros::param::get("end_point_y",line_final_y);

  ros::param::get("Angle_gain_p",Angle_gain_p);
  ros::param::get("Angle_gain_d",Angle_gain_d);
  ros::param::get("Lfw",Lfw);

  ros::param::get("red_traffic",red_traffic);
  ros::param::get("offset_enable",vision_control);
  
  ros::param::get("/task",task_flag);
  if (task_flag!=last_task_flag)
  {
    goal_reached=false;
    last_task_flag=task_flag;
  }
  ROS_INFO("goal_reached = %d",goal_reached);

  odom_goal_pos.x = line_final_x;   //这个是用来计算车辆当前位置和任务路径终点的
  odom_goal_pos.y = line_final_y;

}

double L1Controller::isline(double line_wight)
{
  if (line_wight == 0.0)
  {
    return initbaseSpeed;
  }
  double line_acc = 0.0;
  //tow versions
  line_acc = line_wight * 0.5;
  baseSpeed = baseSpeed + line_acc;
  ROS_WARN("WE ARE CHAMPION!!!!!!!!!!!!");
  return baseSpeed;
}

void L1Controller::controlLoopCB(const ros::TimerEvent &)
{
  // ros::param::get("toward",toward);
  ROS_INFO("toward = %.2f",toward);
  geometry_msgs::Pose carPose = odom.pose.pose;
  geometry_msgs::Twist carVel = odom.twist.twist;

  double encoder_speed = encoder.twist.twist.linear.x;
  static double speedlast;
  static double anglelast;
  //Lfw = getL1Distance(encoder_speed);
  if(goal_received)
  {
    double eta = getEta(carPose);
    // cmd_vel.linear.x = 0.3;
    // cmd_vel.angular.z = 0;
    if(foundForwardPt)
    {
      if (!goal_reached)
      {
        cmd_vel.linear.x = toward*baseSpeed;
        if(toward>=0){
          cmd_vel.angular.z =  -1*(getSteeringAngle(eta) * Angle_gain_p + Angle_gain_d * (getSteeringAngle(eta) - last_steeringangle))/57.3; //纯追踪pd
        }else{
          cmd_vel.angular.z =  (getSteeringAngle(eta) * Angle_gain_p + Angle_gain_d * (getSteeringAngle(eta) - last_steeringangle))/57.3; //纯追踪pd
        }
        last_steeringangle = getSteeringAngle(eta);

        // if (cmd_vel.linear.x < vp_min)   //速度限幅   现在不用
        //   cmd_vel.linear.x = vp_min;
        // if (cmd_vel.linear.x > vp_max_base)
        //   cmd_vel.linear.x = vp_max_base;

        // if (mapPathNum <= 0)  //如果是空路径
        // {
        //   //if now the path is empty then v=kv
        //   ROS_WARN("---------------NO PATH TO GO");
        //   cmd_vel.linear.x = 0;
        //   cmd_vel.angular.z = 0;
        // }


        // if (cmd_vel.angular.z > 15/57.3)            //角度限幅   上坡的时候后面再考虑
        //   cmd_vel.angular.z =  15/57.3;
        // else if (cmd_vel.angular.z <0 -(15/57.3))
        //   cmd_vel.angular.z = 0-(15/57.3);

        // ROS_INFO("Lfw = %.2f", Lfw);
        // ROS_INFO("eta = %.2f", eta * 180 / PI);
        // ROS_INFO("encoder_v = %.2f", encoder_speed);
        // ROS_INFO("out_speed = %.2f", cmd_vel.linear.x);
        // ROS_INFO("out_angle = %.2f", cmd_vel.angular.z);
        // ROS_INFO("------------------------");
      }else{
        cmd_vel.linear.x = 0;
        cmd_vel.angular.z = 0;
        // ROS_INFO("Goal_Reached                     ");
      }
    }
  }
  else
  {
    cmd_vel.linear.x = 0;
    cmd_vel.angular.z = 0;
    ROS_INFO("Goal_NOT_Received~                    ");
    // ros::param::set("/move_base/planner_frequency",1);
  }
  speedlast = cmd_vel.linear.x;
  anglelast = cmd_vel.angular.z;

  if(red_traffic==true){
    cmd_vel.linear.x=0;
    cmd_vel.angular.z=0;
    // red_traffic = false;
    // ros::param::set("red_traffic",red_traffic);
  }
  if(vision_control==0){
    pub_.publish(cmd_vel);
  }
}

/*****************/
/* MAIN FUNCTION */
/*****************/
int main(int argc, char **argv)
{
  // Initiate ROS
  ros::init(argc, argv, "art_car_controller");
  L1Controller controller;

  ros::spin();
  return 0;
}
