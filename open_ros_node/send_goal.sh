#!/bin/bash


cd ~/qingzhou_ws/

source ./devel/setup.bash

rosrun simple_navigation_goals send_goal &
sleep 2

source ./devel/setup.bash

rosrun simple_navigation_goals line_final
