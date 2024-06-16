cmake_minimum_required(VERSION 3.0.2)
project(pure_pursuit)

## Compile as C++11, supported in ROS Kinetic and newer
add_compile_options(-std=c++11)

file(GLOB_RECURSE SRC_SRCS "src/*.cpp")
file(GLOB_RECURSE SRC_INCS "include/*.h")

find_package(catkin REQUIRED COMPONENTS
  geometry_msgs
  nav_msgs
  roscpp
  tf2
  tf2_ros
  tf2_geometry_msgs
  dynamic_reconfigure
)

generate_dynamic_reconfigure_options(cfg/*.cfg)

catkin_package(
  CATKIN_DEPENDS geometry_msgs nav_msgs roscpp tf2 tf2_geometry_msgs tf2_ros dynamic_reconfigure
  INCLUDE_DIRS include
  )

include_directories(include ${catkin_INCLUDE_DIRS})
add_library(${PROJECT_NAME}_lib STATIC ${SRC_SRCS} ${SRC_INCS})

# target_include_directories(${PROJECT_NAME}_lib PUBLIC ${catkin_INCLUDE_DIRS} include)
target_link_libraries(${PROJECT_NAME}_lib PUBLIC ${catkin_LIBRARIES})
add_dependencies(${PROJECT_NAME}_lib ${catkin_EXPORTED_TARGETS})

add_executable(${PROJECT_NAME}_node src/main.cpp)
target_link_libraries(${PROJECT_NAME}_node ${PROJECT_NAME}_lib)
add_dependencies(${PROJECT_NAME}_node ${PROJECT_NAME}_gencfg)
