#!/bin/bash


cd ~/qingzhou_ws/

# source ./devel/setup.bash

# rosrun simple_navigation_goals send_goal_xiugai &
# sleep 2

source ./devel/setup.bash

rosrun simple_navigation_goals cmd_vel_ctrl
