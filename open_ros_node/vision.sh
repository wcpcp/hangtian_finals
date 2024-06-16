#!/bin/bash

sudo systemctl restart nvargus-daemon.service

cd ~/catkin_ws/

source ./devel/setup.bash

roslaunch vision vision.launch