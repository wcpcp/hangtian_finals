#!/bin/bash
#slam   cartographer算法

cd ~/carto_ws/

source ./devel_isolated/setup_new.bash

roslaunch cartographer_ros demo_revo_lds_real.launch

