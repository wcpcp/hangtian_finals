#!/bin/bash
#交通灯
cd ~/catkin_ws/

source ./devel/setup.bash

rosrun robot_vision traffic_twist_ctrl &
sleep 2

echo "traffic_twist_ctrl starting success " 


cd ~/catkin_ws/src/robot_vision/scripts
python3 final_line_detector_cap.py

echo "line_detector_cap   success" 
