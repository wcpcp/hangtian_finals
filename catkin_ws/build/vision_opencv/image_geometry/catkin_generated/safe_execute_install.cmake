execute_process(COMMAND "/home/learningx/catkin_ws/build/vision_opencv/image_geometry/catkin_generated/python_distutils_install.sh" RESULT_VARIABLE res)

if(NOT res EQUAL 0)
  message(FATAL_ERROR "execute_process(/home/learningx/catkin_ws/build/vision_opencv/image_geometry/catkin_generated/python_distutils_install.sh) returned error code ")
endif()