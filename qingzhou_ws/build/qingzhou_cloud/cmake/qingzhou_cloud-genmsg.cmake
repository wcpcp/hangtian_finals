# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "qingzhou_cloud: 6 messages, 0 services")

set(MSG_I_FLAGS "-Iqingzhou_cloud:/home/learningx/qingzhou_ws/src/qingzhou_cloud/msg;-Istd_msgs:/opt/ros/melodic/share/std_msgs/cmake/../msg")

# Find all generators
find_package(gencpp REQUIRED)
find_package(geneus REQUIRED)
find_package(genlisp REQUIRED)
find_package(gennodejs REQUIRED)
find_package(genpy REQUIRED)

add_custom_target(qingzhou_cloud_generate_messages ALL)

# verify that message/service dependencies have not changed since configure



get_filename_component(_filename "/home/learningx/qingzhou_ws/src/qingzhou_cloud/msg/stoppoint.msg" NAME_WE)
add_custom_target(_qingzhou_cloud_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "qingzhou_cloud" "/home/learningx/qingzhou_ws/src/qingzhou_cloud/msg/stoppoint.msg" ""
)

get_filename_component(_filename "/home/learningx/qingzhou_ws/src/qingzhou_cloud/msg/trafficlight.msg" NAME_WE)
add_custom_target(_qingzhou_cloud_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "qingzhou_cloud" "/home/learningx/qingzhou_ws/src/qingzhou_cloud/msg/trafficlight.msg" ""
)

get_filename_component(_filename "/home/learningx/qingzhou_ws/src/qingzhou_cloud/msg/current_location.msg" NAME_WE)
add_custom_target(_qingzhou_cloud_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "qingzhou_cloud" "/home/learningx/qingzhou_ws/src/qingzhou_cloud/msg/current_location.msg" ""
)

get_filename_component(_filename "/home/learningx/qingzhou_ws/src/qingzhou_cloud/msg/qingzhou_cloud.msg" NAME_WE)
add_custom_target(_qingzhou_cloud_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "qingzhou_cloud" "/home/learningx/qingzhou_ws/src/qingzhou_cloud/msg/qingzhou_cloud.msg" ""
)

get_filename_component(_filename "/home/learningx/qingzhou_ws/src/qingzhou_cloud/msg/startstopCommand.msg" NAME_WE)
add_custom_target(_qingzhou_cloud_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "qingzhou_cloud" "/home/learningx/qingzhou_ws/src/qingzhou_cloud/msg/startstopCommand.msg" ""
)

get_filename_component(_filename "/home/learningx/qingzhou_ws/src/qingzhou_cloud/msg/roadLine.msg" NAME_WE)
add_custom_target(_qingzhou_cloud_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "qingzhou_cloud" "/home/learningx/qingzhou_ws/src/qingzhou_cloud/msg/roadLine.msg" ""
)

#
#  langs = gencpp;geneus;genlisp;gennodejs;genpy
#

### Section generating for lang: gencpp
### Generating Messages
_generate_msg_cpp(qingzhou_cloud
  "/home/learningx/qingzhou_ws/src/qingzhou_cloud/msg/stoppoint.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/qingzhou_cloud
)
_generate_msg_cpp(qingzhou_cloud
  "/home/learningx/qingzhou_ws/src/qingzhou_cloud/msg/trafficlight.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/qingzhou_cloud
)
_generate_msg_cpp(qingzhou_cloud
  "/home/learningx/qingzhou_ws/src/qingzhou_cloud/msg/current_location.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/qingzhou_cloud
)
_generate_msg_cpp(qingzhou_cloud
  "/home/learningx/qingzhou_ws/src/qingzhou_cloud/msg/qingzhou_cloud.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/qingzhou_cloud
)
_generate_msg_cpp(qingzhou_cloud
  "/home/learningx/qingzhou_ws/src/qingzhou_cloud/msg/startstopCommand.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/qingzhou_cloud
)
_generate_msg_cpp(qingzhou_cloud
  "/home/learningx/qingzhou_ws/src/qingzhou_cloud/msg/roadLine.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/qingzhou_cloud
)

### Generating Services

### Generating Module File
_generate_module_cpp(qingzhou_cloud
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/qingzhou_cloud
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(qingzhou_cloud_generate_messages_cpp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)
add_dependencies(qingzhou_cloud_generate_messages qingzhou_cloud_generate_messages_cpp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/learningx/qingzhou_ws/src/qingzhou_cloud/msg/stoppoint.msg" NAME_WE)
add_dependencies(qingzhou_cloud_generate_messages_cpp _qingzhou_cloud_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/learningx/qingzhou_ws/src/qingzhou_cloud/msg/trafficlight.msg" NAME_WE)
add_dependencies(qingzhou_cloud_generate_messages_cpp _qingzhou_cloud_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/learningx/qingzhou_ws/src/qingzhou_cloud/msg/current_location.msg" NAME_WE)
add_dependencies(qingzhou_cloud_generate_messages_cpp _qingzhou_cloud_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/learningx/qingzhou_ws/src/qingzhou_cloud/msg/qingzhou_cloud.msg" NAME_WE)
add_dependencies(qingzhou_cloud_generate_messages_cpp _qingzhou_cloud_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/learningx/qingzhou_ws/src/qingzhou_cloud/msg/startstopCommand.msg" NAME_WE)
add_dependencies(qingzhou_cloud_generate_messages_cpp _qingzhou_cloud_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/learningx/qingzhou_ws/src/qingzhou_cloud/msg/roadLine.msg" NAME_WE)
add_dependencies(qingzhou_cloud_generate_messages_cpp _qingzhou_cloud_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(qingzhou_cloud_gencpp)
add_dependencies(qingzhou_cloud_gencpp qingzhou_cloud_generate_messages_cpp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS qingzhou_cloud_generate_messages_cpp)

### Section generating for lang: geneus
### Generating Messages
_generate_msg_eus(qingzhou_cloud
  "/home/learningx/qingzhou_ws/src/qingzhou_cloud/msg/stoppoint.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/qingzhou_cloud
)
_generate_msg_eus(qingzhou_cloud
  "/home/learningx/qingzhou_ws/src/qingzhou_cloud/msg/trafficlight.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/qingzhou_cloud
)
_generate_msg_eus(qingzhou_cloud
  "/home/learningx/qingzhou_ws/src/qingzhou_cloud/msg/current_location.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/qingzhou_cloud
)
_generate_msg_eus(qingzhou_cloud
  "/home/learningx/qingzhou_ws/src/qingzhou_cloud/msg/qingzhou_cloud.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/qingzhou_cloud
)
_generate_msg_eus(qingzhou_cloud
  "/home/learningx/qingzhou_ws/src/qingzhou_cloud/msg/startstopCommand.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/qingzhou_cloud
)
_generate_msg_eus(qingzhou_cloud
  "/home/learningx/qingzhou_ws/src/qingzhou_cloud/msg/roadLine.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/qingzhou_cloud
)

### Generating Services

### Generating Module File
_generate_module_eus(qingzhou_cloud
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/qingzhou_cloud
  "${ALL_GEN_OUTPUT_FILES_eus}"
)

add_custom_target(qingzhou_cloud_generate_messages_eus
  DEPENDS ${ALL_GEN_OUTPUT_FILES_eus}
)
add_dependencies(qingzhou_cloud_generate_messages qingzhou_cloud_generate_messages_eus)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/learningx/qingzhou_ws/src/qingzhou_cloud/msg/stoppoint.msg" NAME_WE)
add_dependencies(qingzhou_cloud_generate_messages_eus _qingzhou_cloud_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/learningx/qingzhou_ws/src/qingzhou_cloud/msg/trafficlight.msg" NAME_WE)
add_dependencies(qingzhou_cloud_generate_messages_eus _qingzhou_cloud_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/learningx/qingzhou_ws/src/qingzhou_cloud/msg/current_location.msg" NAME_WE)
add_dependencies(qingzhou_cloud_generate_messages_eus _qingzhou_cloud_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/learningx/qingzhou_ws/src/qingzhou_cloud/msg/qingzhou_cloud.msg" NAME_WE)
add_dependencies(qingzhou_cloud_generate_messages_eus _qingzhou_cloud_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/learningx/qingzhou_ws/src/qingzhou_cloud/msg/startstopCommand.msg" NAME_WE)
add_dependencies(qingzhou_cloud_generate_messages_eus _qingzhou_cloud_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/learningx/qingzhou_ws/src/qingzhou_cloud/msg/roadLine.msg" NAME_WE)
add_dependencies(qingzhou_cloud_generate_messages_eus _qingzhou_cloud_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(qingzhou_cloud_geneus)
add_dependencies(qingzhou_cloud_geneus qingzhou_cloud_generate_messages_eus)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS qingzhou_cloud_generate_messages_eus)

### Section generating for lang: genlisp
### Generating Messages
_generate_msg_lisp(qingzhou_cloud
  "/home/learningx/qingzhou_ws/src/qingzhou_cloud/msg/stoppoint.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/qingzhou_cloud
)
_generate_msg_lisp(qingzhou_cloud
  "/home/learningx/qingzhou_ws/src/qingzhou_cloud/msg/trafficlight.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/qingzhou_cloud
)
_generate_msg_lisp(qingzhou_cloud
  "/home/learningx/qingzhou_ws/src/qingzhou_cloud/msg/current_location.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/qingzhou_cloud
)
_generate_msg_lisp(qingzhou_cloud
  "/home/learningx/qingzhou_ws/src/qingzhou_cloud/msg/qingzhou_cloud.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/qingzhou_cloud
)
_generate_msg_lisp(qingzhou_cloud
  "/home/learningx/qingzhou_ws/src/qingzhou_cloud/msg/startstopCommand.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/qingzhou_cloud
)
_generate_msg_lisp(qingzhou_cloud
  "/home/learningx/qingzhou_ws/src/qingzhou_cloud/msg/roadLine.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/qingzhou_cloud
)

### Generating Services

### Generating Module File
_generate_module_lisp(qingzhou_cloud
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/qingzhou_cloud
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(qingzhou_cloud_generate_messages_lisp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)
add_dependencies(qingzhou_cloud_generate_messages qingzhou_cloud_generate_messages_lisp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/learningx/qingzhou_ws/src/qingzhou_cloud/msg/stoppoint.msg" NAME_WE)
add_dependencies(qingzhou_cloud_generate_messages_lisp _qingzhou_cloud_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/learningx/qingzhou_ws/src/qingzhou_cloud/msg/trafficlight.msg" NAME_WE)
add_dependencies(qingzhou_cloud_generate_messages_lisp _qingzhou_cloud_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/learningx/qingzhou_ws/src/qingzhou_cloud/msg/current_location.msg" NAME_WE)
add_dependencies(qingzhou_cloud_generate_messages_lisp _qingzhou_cloud_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/learningx/qingzhou_ws/src/qingzhou_cloud/msg/qingzhou_cloud.msg" NAME_WE)
add_dependencies(qingzhou_cloud_generate_messages_lisp _qingzhou_cloud_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/learningx/qingzhou_ws/src/qingzhou_cloud/msg/startstopCommand.msg" NAME_WE)
add_dependencies(qingzhou_cloud_generate_messages_lisp _qingzhou_cloud_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/learningx/qingzhou_ws/src/qingzhou_cloud/msg/roadLine.msg" NAME_WE)
add_dependencies(qingzhou_cloud_generate_messages_lisp _qingzhou_cloud_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(qingzhou_cloud_genlisp)
add_dependencies(qingzhou_cloud_genlisp qingzhou_cloud_generate_messages_lisp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS qingzhou_cloud_generate_messages_lisp)

### Section generating for lang: gennodejs
### Generating Messages
_generate_msg_nodejs(qingzhou_cloud
  "/home/learningx/qingzhou_ws/src/qingzhou_cloud/msg/stoppoint.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/qingzhou_cloud
)
_generate_msg_nodejs(qingzhou_cloud
  "/home/learningx/qingzhou_ws/src/qingzhou_cloud/msg/trafficlight.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/qingzhou_cloud
)
_generate_msg_nodejs(qingzhou_cloud
  "/home/learningx/qingzhou_ws/src/qingzhou_cloud/msg/current_location.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/qingzhou_cloud
)
_generate_msg_nodejs(qingzhou_cloud
  "/home/learningx/qingzhou_ws/src/qingzhou_cloud/msg/qingzhou_cloud.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/qingzhou_cloud
)
_generate_msg_nodejs(qingzhou_cloud
  "/home/learningx/qingzhou_ws/src/qingzhou_cloud/msg/startstopCommand.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/qingzhou_cloud
)
_generate_msg_nodejs(qingzhou_cloud
  "/home/learningx/qingzhou_ws/src/qingzhou_cloud/msg/roadLine.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/qingzhou_cloud
)

### Generating Services

### Generating Module File
_generate_module_nodejs(qingzhou_cloud
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/qingzhou_cloud
  "${ALL_GEN_OUTPUT_FILES_nodejs}"
)

add_custom_target(qingzhou_cloud_generate_messages_nodejs
  DEPENDS ${ALL_GEN_OUTPUT_FILES_nodejs}
)
add_dependencies(qingzhou_cloud_generate_messages qingzhou_cloud_generate_messages_nodejs)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/learningx/qingzhou_ws/src/qingzhou_cloud/msg/stoppoint.msg" NAME_WE)
add_dependencies(qingzhou_cloud_generate_messages_nodejs _qingzhou_cloud_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/learningx/qingzhou_ws/src/qingzhou_cloud/msg/trafficlight.msg" NAME_WE)
add_dependencies(qingzhou_cloud_generate_messages_nodejs _qingzhou_cloud_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/learningx/qingzhou_ws/src/qingzhou_cloud/msg/current_location.msg" NAME_WE)
add_dependencies(qingzhou_cloud_generate_messages_nodejs _qingzhou_cloud_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/learningx/qingzhou_ws/src/qingzhou_cloud/msg/qingzhou_cloud.msg" NAME_WE)
add_dependencies(qingzhou_cloud_generate_messages_nodejs _qingzhou_cloud_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/learningx/qingzhou_ws/src/qingzhou_cloud/msg/startstopCommand.msg" NAME_WE)
add_dependencies(qingzhou_cloud_generate_messages_nodejs _qingzhou_cloud_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/learningx/qingzhou_ws/src/qingzhou_cloud/msg/roadLine.msg" NAME_WE)
add_dependencies(qingzhou_cloud_generate_messages_nodejs _qingzhou_cloud_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(qingzhou_cloud_gennodejs)
add_dependencies(qingzhou_cloud_gennodejs qingzhou_cloud_generate_messages_nodejs)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS qingzhou_cloud_generate_messages_nodejs)

### Section generating for lang: genpy
### Generating Messages
_generate_msg_py(qingzhou_cloud
  "/home/learningx/qingzhou_ws/src/qingzhou_cloud/msg/stoppoint.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/qingzhou_cloud
)
_generate_msg_py(qingzhou_cloud
  "/home/learningx/qingzhou_ws/src/qingzhou_cloud/msg/trafficlight.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/qingzhou_cloud
)
_generate_msg_py(qingzhou_cloud
  "/home/learningx/qingzhou_ws/src/qingzhou_cloud/msg/current_location.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/qingzhou_cloud
)
_generate_msg_py(qingzhou_cloud
  "/home/learningx/qingzhou_ws/src/qingzhou_cloud/msg/qingzhou_cloud.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/qingzhou_cloud
)
_generate_msg_py(qingzhou_cloud
  "/home/learningx/qingzhou_ws/src/qingzhou_cloud/msg/startstopCommand.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/qingzhou_cloud
)
_generate_msg_py(qingzhou_cloud
  "/home/learningx/qingzhou_ws/src/qingzhou_cloud/msg/roadLine.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/qingzhou_cloud
)

### Generating Services

### Generating Module File
_generate_module_py(qingzhou_cloud
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/qingzhou_cloud
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(qingzhou_cloud_generate_messages_py
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)
add_dependencies(qingzhou_cloud_generate_messages qingzhou_cloud_generate_messages_py)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/learningx/qingzhou_ws/src/qingzhou_cloud/msg/stoppoint.msg" NAME_WE)
add_dependencies(qingzhou_cloud_generate_messages_py _qingzhou_cloud_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/learningx/qingzhou_ws/src/qingzhou_cloud/msg/trafficlight.msg" NAME_WE)
add_dependencies(qingzhou_cloud_generate_messages_py _qingzhou_cloud_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/learningx/qingzhou_ws/src/qingzhou_cloud/msg/current_location.msg" NAME_WE)
add_dependencies(qingzhou_cloud_generate_messages_py _qingzhou_cloud_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/learningx/qingzhou_ws/src/qingzhou_cloud/msg/qingzhou_cloud.msg" NAME_WE)
add_dependencies(qingzhou_cloud_generate_messages_py _qingzhou_cloud_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/learningx/qingzhou_ws/src/qingzhou_cloud/msg/startstopCommand.msg" NAME_WE)
add_dependencies(qingzhou_cloud_generate_messages_py _qingzhou_cloud_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/learningx/qingzhou_ws/src/qingzhou_cloud/msg/roadLine.msg" NAME_WE)
add_dependencies(qingzhou_cloud_generate_messages_py _qingzhou_cloud_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(qingzhou_cloud_genpy)
add_dependencies(qingzhou_cloud_genpy qingzhou_cloud_generate_messages_py)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS qingzhou_cloud_generate_messages_py)



if(gencpp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/qingzhou_cloud)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/qingzhou_cloud
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_cpp)
  add_dependencies(qingzhou_cloud_generate_messages_cpp std_msgs_generate_messages_cpp)
endif()

if(geneus_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/qingzhou_cloud)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/qingzhou_cloud
    DESTINATION ${geneus_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_eus)
  add_dependencies(qingzhou_cloud_generate_messages_eus std_msgs_generate_messages_eus)
endif()

if(genlisp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/qingzhou_cloud)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/qingzhou_cloud
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_lisp)
  add_dependencies(qingzhou_cloud_generate_messages_lisp std_msgs_generate_messages_lisp)
endif()

if(gennodejs_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/qingzhou_cloud)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/qingzhou_cloud
    DESTINATION ${gennodejs_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_nodejs)
  add_dependencies(qingzhou_cloud_generate_messages_nodejs std_msgs_generate_messages_nodejs)
endif()

if(genpy_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/qingzhou_cloud)
  install(CODE "execute_process(COMMAND \"/usr/bin/python2\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/qingzhou_cloud\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/qingzhou_cloud
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_py)
  add_dependencies(qingzhou_cloud_generate_messages_py std_msgs_generate_messages_py)
endif()
