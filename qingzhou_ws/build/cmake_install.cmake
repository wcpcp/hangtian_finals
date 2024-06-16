# Install script for directory: /home/learningx/qingzhou_ws/src

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/home/learningx/qingzhou_ws/install")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Install shared libraries without execute permission?
if(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  set(CMAKE_INSTALL_SO_NO_EXE "1")
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "FALSE")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  
      if (NOT EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}")
        file(MAKE_DIRECTORY "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}")
      endif()
      if (NOT EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/.catkin")
        file(WRITE "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/.catkin" "")
      endif()
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/learningx/qingzhou_ws/install/_setup_util.py")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/home/learningx/qingzhou_ws/install" TYPE PROGRAM FILES "/home/learningx/qingzhou_ws/build/catkin_generated/installspace/_setup_util.py")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/learningx/qingzhou_ws/install/env.sh")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/home/learningx/qingzhou_ws/install" TYPE PROGRAM FILES "/home/learningx/qingzhou_ws/build/catkin_generated/installspace/env.sh")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/learningx/qingzhou_ws/install/setup.bash;/home/learningx/qingzhou_ws/install/local_setup.bash")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/home/learningx/qingzhou_ws/install" TYPE FILE FILES
    "/home/learningx/qingzhou_ws/build/catkin_generated/installspace/setup.bash"
    "/home/learningx/qingzhou_ws/build/catkin_generated/installspace/local_setup.bash"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/learningx/qingzhou_ws/install/setup.sh;/home/learningx/qingzhou_ws/install/local_setup.sh")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/home/learningx/qingzhou_ws/install" TYPE FILE FILES
    "/home/learningx/qingzhou_ws/build/catkin_generated/installspace/setup.sh"
    "/home/learningx/qingzhou_ws/build/catkin_generated/installspace/local_setup.sh"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/learningx/qingzhou_ws/install/setup.zsh;/home/learningx/qingzhou_ws/install/local_setup.zsh")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/home/learningx/qingzhou_ws/install" TYPE FILE FILES
    "/home/learningx/qingzhou_ws/build/catkin_generated/installspace/setup.zsh"
    "/home/learningx/qingzhou_ws/build/catkin_generated/installspace/local_setup.zsh"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/learningx/qingzhou_ws/install/.rosinstall")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/home/learningx/qingzhou_ws/install" TYPE FILE FILES "/home/learningx/qingzhou_ws/build/catkin_generated/installspace/.rosinstall")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for each subdirectory.
  include("/home/learningx/qingzhou_ws/build/gtest/cmake_install.cmake")
  include("/home/learningx/qingzhou_ws/build/qinzhou_odom/imu_tools/imu_tools/cmake_install.cmake")
  include("/home/learningx/qingzhou_ws/build/navigation_msgs/move_base_msgs/cmake_install.cmake")
  include("/home/learningx/qingzhou_ws/build/qinzhou_odom/mrobot_calibration/cmake_install.cmake")
  include("/home/learningx/qingzhou_ws/build/qingzhou_cloud/cmake_install.cmake")
  include("/home/learningx/qingzhou_ws/build/qingzhou_nav/cmake_install.cmake")
  include("/home/learningx/qingzhou_ws/build/map_server/cmake_install.cmake")
  include("/home/learningx/qingzhou_ws/build/qinzhou_odom/imu_calibrate/imu_calib/cmake_install.cmake")
  include("/home/learningx/qingzhou_ws/build/navigation_msgs/map_msgs/cmake_install.cmake")
  include("/home/learningx/qingzhou_ws/build/particle_filter/cmake_install.cmake")
  include("/home/learningx/qingzhou_ws/build/qinzhou_odom/imu_tools/imu_complementary_filter/cmake_install.cmake")
  include("/home/learningx/qingzhou_ws/build/laser_scan_matcher_odometry-master/cmake_install.cmake")
  include("/home/learningx/qingzhou_ws/build/qinzhou_odom/qingzhou_bringup/cmake_install.cmake")
  include("/home/learningx/qingzhou_ws/build/rf2o_laser_odometry/cmake_install.cmake")
  include("/home/learningx/qingzhou_ws/build/qinzhou_odom/robot_pose_ekf/cmake_install.cmake")
  include("/home/learningx/qingzhou_ws/build/amcl/cmake_install.cmake")
  include("/home/learningx/qingzhou_ws/build/fake_localization/cmake_install.cmake")
  include("/home/learningx/qingzhou_ws/build/qinzhou_odom/imu_tools/imu_filter_madgwick/cmake_install.cmake")
  include("/home/learningx/qingzhou_ws/build/pure_pursuit/cmake_install.cmake")
  include("/home/learningx/qingzhou_ws/build/qinzhou_odom/imu_tools/rviz_imu_plugin/cmake_install.cmake")
  include("/home/learningx/qingzhou_ws/build/voxel_grid/cmake_install.cmake")
  include("/home/learningx/qingzhou_ws/build/costmap_2d/cmake_install.cmake")
  include("/home/learningx/qingzhou_ws/build/nav_core/cmake_install.cmake")
  include("/home/learningx/qingzhou_ws/build/base_local_planner/cmake_install.cmake")
  include("/home/learningx/qingzhou_ws/build/carrot_planner/cmake_install.cmake")
  include("/home/learningx/qingzhou_ws/build/clear_costmap_recovery/cmake_install.cmake")
  include("/home/learningx/qingzhou_ws/build/dwa_local_planner/cmake_install.cmake")
  include("/home/learningx/qingzhou_ws/build/move_slow_and_clear/cmake_install.cmake")
  include("/home/learningx/qingzhou_ws/build/navfn/cmake_install.cmake")
  include("/home/learningx/qingzhou_ws/build/global_planner/cmake_install.cmake")
  include("/home/learningx/qingzhou_ws/build/reeds-shepp-paths/cmake_install.cmake")
  include("/home/learningx/qingzhou_ws/build/relaxed_astar/cmake_install.cmake")
  include("/home/learningx/qingzhou_ws/build/rotate_recovery/cmake_install.cmake")
  include("/home/learningx/qingzhou_ws/build/move_base/cmake_install.cmake")
  include("/home/learningx/qingzhou_ws/build/hypharos_minicar/cmake_install.cmake")
  include("/home/learningx/qingzhou_ws/build/racecar/cmake_install.cmake")
  include("/home/learningx/qingzhou_ws/build/simple_navigation_goals/cmake_install.cmake")
  include("/home/learningx/qingzhou_ws/build/teb_local_planner/cmake_install.cmake")
  include("/home/learningx/qingzhou_ws/build/ydlidar-master/cmake_install.cmake")

endif()

if(CMAKE_INSTALL_COMPONENT)
  set(CMAKE_INSTALL_MANIFEST "install_manifest_${CMAKE_INSTALL_COMPONENT}.txt")
else()
  set(CMAKE_INSTALL_MANIFEST "install_manifest.txt")
endif()

string(REPLACE ";" "\n" CMAKE_INSTALL_MANIFEST_CONTENT
       "${CMAKE_INSTALL_MANIFEST_FILES}")
file(WRITE "/home/learningx/qingzhou_ws/build/${CMAKE_INSTALL_MANIFEST}"
     "${CMAKE_INSTALL_MANIFEST_CONTENT}")
