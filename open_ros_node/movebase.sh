#!/bin/bash
#地盘

cd ~/qingzhou_ws/

source ./devel/setup.bash

# roslaunch qingzhou_nav qingzhou_move_base.launch
roslaunch qingzhou_nav test_amcl.launch