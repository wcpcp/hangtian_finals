# CMake generated Testfile for 
# Source directory: /home/learningx/qingzhou_ws/src/map_server
# Build directory: /home/learningx/qingzhou_ws/build/map_server
# 
# This file includes the relevant testing commands required for 
# testing this directory and lists subdirectories to be tested as well.
add_test(_ctest_map_server_gtest_map_server_utest "/home/learningx/qingzhou_ws/build/catkin_generated/env_cached.sh" "/usr/bin/python2" "/opt/ros/melodic/share/catkin/cmake/test/run_tests.py" "/home/learningx/qingzhou_ws/build/test_results/map_server/gtest-map_server_utest.xml" "--return-code" "/home/learningx/qingzhou_ws/devel/lib/map_server/map_server_utest --gtest_output=xml:/home/learningx/qingzhou_ws/build/test_results/map_server/gtest-map_server_utest.xml")
add_test(_ctest_map_server_rostest_test_rtest.xml "/home/learningx/qingzhou_ws/build/catkin_generated/env_cached.sh" "/usr/bin/python2" "/opt/ros/melodic/share/catkin/cmake/test/run_tests.py" "/home/learningx/qingzhou_ws/build/test_results/map_server/rostest-test_rtest.xml" "--return-code" "/usr/bin/python2 /opt/ros/melodic/share/rostest/cmake/../../../bin/rostest --pkgdir=/home/learningx/qingzhou_ws/src/map_server --package=map_server --results-filename test_rtest.xml --results-base-dir \"/home/learningx/qingzhou_ws/build/test_results\" /home/learningx/qingzhou_ws/src/map_server/test/rtest.xml ")
