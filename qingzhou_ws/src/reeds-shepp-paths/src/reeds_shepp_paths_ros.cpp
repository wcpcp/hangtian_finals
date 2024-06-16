/*********************************************************************
*
* Software License Agreement (BSD License)
*
*  Copyright (c) 2016, George Kouros.
*  All rights reserved.
*
*  Redistribution and use in source and binary forms, with or without
*  modification, are permitted provided that the following conditions
*  are met:
*
*   * Redistributions of source code must retain the above copyright
*     notice, this list of conditions and the following disclaimer.
*   * Redistributions in binary form must reproduce the above
*     copyright notice, this list of conditions and the following
*     disclaimer in the documentation and/or other materials provided
*     with the distribution.
*   * Neither the name of the the copyright holder nor the names of its
*     contributors may be used to endorse or promote products derived
*     from this software without specific prior written permission.
*
*  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
*  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
*  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
*  FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
*  COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
*  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
*  BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
*  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
*  CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
*  LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
*  ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
*  POSSIBILITY OF SUCH DAMAGE.
*
* Author:  George Kouros
*********************************************************************/

#include "reeds_shepp_paths_ros/reeds_shepp_paths_ros.h"
#include <tf/tf.h>
#include <boost/foreach.hpp>
#include <tf/transform_listener.h>


namespace reeds_shepp
{
  RSPathsROS::RSPathsROS(
    std::string name,
    costmap_2d::Costmap2DROS* costmapROS,
    tf::TransformListener* tfListener)
    :
      reedsSheppStateSpace_(new ompl::base::ReedsSheppStateSpace),
      simpleSetup_(new ompl::geometric::SimpleSetup(reedsSheppStateSpace_)),
      costmapROS_(), tfListener_(), bx_(10), by_(10), bounds_(2),
      initialized_(false)
  {
    initialize(name, costmapROS, tfListener);
  }


  RSPathsROS::~RSPathsROS()
  {
    delete costmapModel_;
  }


  void RSPathsROS::initialize(
    std::string name,
    costmap_2d::Costmap2DROS* costmapROS,
    tf::TransformListener* tfListener)
  {
    costmapROS_ = costmapROS;
    tfListener_ = tfListener;

    ros::NodeHandle pnh("~/" + name);
    pnh.param("min_turning_radius", minTurningRadius_, 1.0);
    pnh.param("max_planning_duration", maxPlanningDuration_, 0.2);
    pnh.param<int>("valid_state_max_cost", validStateMaxCost_, 252);
    pnh.param<int>("interpolation_num_poses", interpolationNumPoses_, 20);
    pnh.param<bool>("allow_unknown", allowUnknown_, false);
    pnh.param<int>("skip_poses", skipPoses_, 0);
    pnh.param<bool>("display_planner_output", displayPlannerOutput_, false);

    if (costmapROS_)
    {
      costmap_ = costmapROS_->getCostmap();
      costmapModel_ = new base_local_planner::CostmapModel(*costmap_);
      footprint_ = costmapROS_->getRobotFootprint();

      if (!tfListener_)
      {
        ROS_FATAL("No tf listener provided.");
        exit(EXIT_FAILURE);
      }

      robotFrame_ = costmapROS_->getBaseFrameID();
      globalFrame_ = costmapROS_->getGlobalFrameID();

      // initialize the state space boundary
      setBoundaries(costmap_->getSizeInMetersX(), costmap_->getSizeInMetersY());
    }
    else
    {
      ROS_WARN("No costmap provided. Collision checking unavailable. "
        "Same robot_frame and global_frame assumed.");
      robotFrame_ = globalFrame_ = "base_footprint";

      setBoundaries(10.0, 10.0);
    }

    initialized_ = true;
  }

  void RSPathsROS::setBoundaries(const double bx, const double by)
  {
    bx_ = bx;
    by_ = by;
    bounds_.low[0] = -by_ / 2 - 0.1;
    bounds_.low[1] = -bx_ / 2 - 0.1;
    bounds_.high[0] = by_ / 2 + 0.1;
    bounds_.high[1] = bx_ / 2 + 0.1;
    reedsSheppStateSpace_->as<ompl::base::SE2StateSpace>()->setBounds(bounds_);
  }

  void RSPathsROS::transform(const geometry_msgs::PoseStamped& poseIn,
    geometry_msgs::PoseStamped& poseOut, std::string targetFrameID)
  {
    tf::Stamped<tf::Pose> tfIn, tfOut;
    tf::poseStampedMsgToTF(poseIn, tfIn);
    transform(tfIn, tfOut, targetFrameID);
    tf::poseStampedTFToMsg(tfOut, poseOut);
  }

  void RSPathsROS::transform(const tf::Stamped<tf::Pose>& tfIn,
    tf::Stamped<tf::Pose>& tfOut, std::string targetFrameID)
  {
    if (tfListener_)
      tfListener_->transformPose(targetFrameID, stamp_, tfIn,
        tfIn.frame_id_, tfOut);
  }


  void RSPathsROS::state2pose(
    const ompl::base::State* state, geometry_msgs::PoseStamped& pose)
  {
    const ompl::base::SE2StateSpace::StateType *s =
      state->as<ompl::base::SE2StateSpace::StateType>();
    pose.pose.position.x = s->getX();
    pose.pose.position.y = s->getY();
    pose.pose.orientation = tf::createQuaternionMsgFromYaw(s->getYaw());
    pose.header.frame_id = robotFrame_;
    pose.header.stamp = stamp_;
  }


  void RSPathsROS::pose2state(
    const geometry_msgs::PoseStamped& pose, ompl::base::State* state)
  {
    ompl::base::SE2StateSpace::StateType *s =
      state->as<ompl::base::SE2StateSpace::StateType>();
    s->setX(pose.pose.position.x);
    s->setY(pose.pose.position.y);
    s->setYaw(tf::getYaw(pose.pose.orientation));
  }


  bool RSPathsROS::isStateValid(
    const ompl::base::SpaceInformation* si, const ompl::base::State *state)
  {
    // check if state is inside boundary
    if (!si->satisfiesBounds(state))
      return false;

    if (!costmapROS_ || !tfListener_)
      return true;

    const ompl::base::SE2StateSpace::StateType *s =
      state->as<ompl::base::SE2StateSpace::StateType>();

    geometry_msgs::PoseStamped statePose;
    state2pose(s, statePose);

    if (fabs(s->getX()) < 5e-2 && fabs(s->getY()) < 5e-2)
      return true;

    transform(statePose, statePose, globalFrame_);

    uint8_t cost = costmapModel_->footprintCost(
      statePose.pose.position.x, statePose.pose.position.y,
      tf::getYaw(statePose.pose.orientation), footprint_);

    // check if state is in collision
    if (cost > validStateMaxCost_ && cost < 256 - (allowUnknown_?1:0))
      return false;

    return true;
  }


  bool RSPathsROS::planPath(
    const geometry_msgs::PoseStamped& startPose,
    const geometry_msgs::PoseStamped& goalPose,
    std::vector<geometry_msgs::PoseStamped>& pathPoses)
  {
    if (!initialized_)
    {
      ROS_ERROR("Planner not initialized!");
      return false;
    }

    // disable planner console output
    if (!displayPlannerOutput_)
    {
      std::cout.setstate(std::ios_base::failbit);
      std::cerr.setstate(std::ios_base::failbit);
    }

    // create start and goal states
    ompl::base::ScopedState<> start(reedsSheppStateSpace_);
    ompl::base::ScopedState<> goal(reedsSheppStateSpace_);

    // initialize state valididy checker
    ompl::base::SpaceInformationPtr si(simpleSetup_->getSpaceInformation());
    simpleSetup_->setStateValidityChecker(
      boost::bind(&RSPathsROS::isStateValid, this, si.get(), _1));


    stamp_ = startPose.header.stamp;

    // transform the start and goal poses to the robot/local reference frame
    geometry_msgs::PoseStamped localStartPose, localGoalPose;
    if (tfListener_)
    {
      transform(startPose, localStartPose, robotFrame_);
      transform(goalPose, localGoalPose, robotFrame_);
    }
    else
    {
      localStartPose = startPose;
      localGoalPose = goalPose;
    }

    // convert start and goal poses to ompl base states
    pose2state(localStartPose, start());
    pose2state(localGoalPose, goal());

    // clear all planning data
    simpleSetup_->clear();
    // set new start and goal states
    simpleSetup_->setStartAndGoalStates(start, goal);

    if (!simpleSetup_->solve(maxPlanningDuration_))
      return false;
    else
      ROS_DEBUG("[reeds_shepp_planner] Valid plan found");

    // simplify solution
    simpleSetup_->simplifySolution();

    // get solution path
    ompl::geometric::PathGeometric path = simpleSetup_->getSolutionPath();
    // interpolate between poses
    path.interpolate(interpolationNumPoses_);

    if (path.getStateCount() > interpolationNumPoses_)
      return false;


    // resize pathPoses
    pathPoses.resize(path.getStateCount());

    // convert each state to a pose and store it in pathPoses vector
    for (unsigned int i = 0; i < path.getStateCount(); i++)
    {
      const ompl::base::State* state = path.getState(i);
      state2pose(state, pathPoses[i]);
      pathPoses[i].header.frame_id = robotFrame_;
      pathPoses[i].header.stamp = ros::Time::now();
    }

    // enable console output
    std::cout.clear();
    std::cerr.clear();

    return true;
  }


  bool RSPathsROS::planPath(
    const std::vector<geometry_msgs::PoseStamped>& path,
    std::vector<geometry_msgs::PoseStamped>& newPath)
  {
    newPath.clear();

    unsigned int skipPoses = std::min<unsigned int>(skipPoses_, path.size() - 2);

    for (unsigned int i = 0; i < path.size() - 1; i =
      std::min<unsigned int>(i+skipPoses+1, path.size() - skipPoses - 2))
    {
      std::vector<geometry_msgs::PoseStamped> tmpPath;

      if (!planPath(path[i], path[i+skipPoses+1], tmpPath))
      {
        // ROS_ERROR("Failed to plan subplan %d out of %d", i,
          // path.size()/(skipPoses_+1));
        skipPoses++;
        i--;
        continue;
      }

      newPath.insert(newPath.end(), tmpPath.begin(), tmpPath.end());

      if (i >= path.size() - skipPoses - 2)
        break;
    }

    return true;
  }

  bool RSPathsROS::planRecedingPath(
    const std::vector<geometry_msgs::PoseStamped>& path,
    std::vector<geometry_msgs::PoseStamped>& newPath)
  {
    newPath.clear();

    bool success;
    for (unsigned int i = 0; i < floor(sqrt(path.size())); i++)
    {
      success = planPath(
        path.front(), path[(path.size()-1) / (i+1)], newPath);

      if (success)
      {
        for (unsigned j = (path.size()-1)/(i+1); j < path.size(); j++)
        {
          geometry_msgs::PoseStamped pose;
          transform(path[j], pose, robotFrame_);
          newPath.push_back(pose);
        }
      }
    }

    if (!success)
    {
      // ROS_ERROR("Failed to find valid plan even after reducing path");
      return false;
    }
  }

}  // namespace reeds_shepp
