#!/bin/bash

cd ~/catkin_ws/

source ./devel/setup.bash
#开启雷达
# roslaunch ydlidar_ros_driver X4.launch &
roslaunch ydlidar_ros_driver X4.launch &
sleep 5



# cd ~/lidar_ws/
# source ./devel/setup.bash
# roslaunch ydlidar lidar.launch &
# sleep 5


cd ~/catkin_ws/
source ./devel/setup.bash
roslaunch urdf01_rviz qingzhou_car.launch &
sleep 2


cd ~/qingzhou_ws/
source ./devel/setup.bash
roslaunch qingzhou_nav qingzhou_bringup.launch 
#sleep 1


# roslaunch qingzhou_nav carto_robot_localization.launch
#source ./devel/setup.bash

#roslaunch qingzhou_nav robot_localization.launch




