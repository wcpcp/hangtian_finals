# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.10

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/learningx/qingzhou_ws/src

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/learningx/qingzhou_ws/build

# Include any dependencies generated for this target.
include qingzhou_cloud/CMakeFiles/qingzhou_cloud.dir/depend.make

# Include the progress variables for this target.
include qingzhou_cloud/CMakeFiles/qingzhou_cloud.dir/progress.make

# Include the compile flags for this target's objects.
include qingzhou_cloud/CMakeFiles/qingzhou_cloud.dir/flags.make

qingzhou_cloud/CMakeFiles/qingzhou_cloud.dir/src/qingzhou_cloud.cpp.o: qingzhou_cloud/CMakeFiles/qingzhou_cloud.dir/flags.make
qingzhou_cloud/CMakeFiles/qingzhou_cloud.dir/src/qingzhou_cloud.cpp.o: /home/learningx/qingzhou_ws/src/qingzhou_cloud/src/qingzhou_cloud.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/learningx/qingzhou_ws/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object qingzhou_cloud/CMakeFiles/qingzhou_cloud.dir/src/qingzhou_cloud.cpp.o"
	cd /home/learningx/qingzhou_ws/build/qingzhou_cloud && /usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/qingzhou_cloud.dir/src/qingzhou_cloud.cpp.o -c /home/learningx/qingzhou_ws/src/qingzhou_cloud/src/qingzhou_cloud.cpp

qingzhou_cloud/CMakeFiles/qingzhou_cloud.dir/src/qingzhou_cloud.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/qingzhou_cloud.dir/src/qingzhou_cloud.cpp.i"
	cd /home/learningx/qingzhou_ws/build/qingzhou_cloud && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/learningx/qingzhou_ws/src/qingzhou_cloud/src/qingzhou_cloud.cpp > CMakeFiles/qingzhou_cloud.dir/src/qingzhou_cloud.cpp.i

qingzhou_cloud/CMakeFiles/qingzhou_cloud.dir/src/qingzhou_cloud.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/qingzhou_cloud.dir/src/qingzhou_cloud.cpp.s"
	cd /home/learningx/qingzhou_ws/build/qingzhou_cloud && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/learningx/qingzhou_ws/src/qingzhou_cloud/src/qingzhou_cloud.cpp -o CMakeFiles/qingzhou_cloud.dir/src/qingzhou_cloud.cpp.s

qingzhou_cloud/CMakeFiles/qingzhou_cloud.dir/src/qingzhou_cloud.cpp.o.requires:

.PHONY : qingzhou_cloud/CMakeFiles/qingzhou_cloud.dir/src/qingzhou_cloud.cpp.o.requires

qingzhou_cloud/CMakeFiles/qingzhou_cloud.dir/src/qingzhou_cloud.cpp.o.provides: qingzhou_cloud/CMakeFiles/qingzhou_cloud.dir/src/qingzhou_cloud.cpp.o.requires
	$(MAKE) -f qingzhou_cloud/CMakeFiles/qingzhou_cloud.dir/build.make qingzhou_cloud/CMakeFiles/qingzhou_cloud.dir/src/qingzhou_cloud.cpp.o.provides.build
.PHONY : qingzhou_cloud/CMakeFiles/qingzhou_cloud.dir/src/qingzhou_cloud.cpp.o.provides

qingzhou_cloud/CMakeFiles/qingzhou_cloud.dir/src/qingzhou_cloud.cpp.o.provides.build: qingzhou_cloud/CMakeFiles/qingzhou_cloud.dir/src/qingzhou_cloud.cpp.o


qingzhou_cloud/CMakeFiles/qingzhou_cloud.dir/src/app.cpp.o: qingzhou_cloud/CMakeFiles/qingzhou_cloud.dir/flags.make
qingzhou_cloud/CMakeFiles/qingzhou_cloud.dir/src/app.cpp.o: /home/learningx/qingzhou_ws/src/qingzhou_cloud/src/app.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/learningx/qingzhou_ws/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building CXX object qingzhou_cloud/CMakeFiles/qingzhou_cloud.dir/src/app.cpp.o"
	cd /home/learningx/qingzhou_ws/build/qingzhou_cloud && /usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/qingzhou_cloud.dir/src/app.cpp.o -c /home/learningx/qingzhou_ws/src/qingzhou_cloud/src/app.cpp

qingzhou_cloud/CMakeFiles/qingzhou_cloud.dir/src/app.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/qingzhou_cloud.dir/src/app.cpp.i"
	cd /home/learningx/qingzhou_ws/build/qingzhou_cloud && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/learningx/qingzhou_ws/src/qingzhou_cloud/src/app.cpp > CMakeFiles/qingzhou_cloud.dir/src/app.cpp.i

qingzhou_cloud/CMakeFiles/qingzhou_cloud.dir/src/app.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/qingzhou_cloud.dir/src/app.cpp.s"
	cd /home/learningx/qingzhou_ws/build/qingzhou_cloud && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/learningx/qingzhou_ws/src/qingzhou_cloud/src/app.cpp -o CMakeFiles/qingzhou_cloud.dir/src/app.cpp.s

qingzhou_cloud/CMakeFiles/qingzhou_cloud.dir/src/app.cpp.o.requires:

.PHONY : qingzhou_cloud/CMakeFiles/qingzhou_cloud.dir/src/app.cpp.o.requires

qingzhou_cloud/CMakeFiles/qingzhou_cloud.dir/src/app.cpp.o.provides: qingzhou_cloud/CMakeFiles/qingzhou_cloud.dir/src/app.cpp.o.requires
	$(MAKE) -f qingzhou_cloud/CMakeFiles/qingzhou_cloud.dir/build.make qingzhou_cloud/CMakeFiles/qingzhou_cloud.dir/src/app.cpp.o.provides.build
.PHONY : qingzhou_cloud/CMakeFiles/qingzhou_cloud.dir/src/app.cpp.o.provides

qingzhou_cloud/CMakeFiles/qingzhou_cloud.dir/src/app.cpp.o.provides.build: qingzhou_cloud/CMakeFiles/qingzhou_cloud.dir/src/app.cpp.o


qingzhou_cloud/CMakeFiles/qingzhou_cloud.dir/src/sendthread.cpp.o: qingzhou_cloud/CMakeFiles/qingzhou_cloud.dir/flags.make
qingzhou_cloud/CMakeFiles/qingzhou_cloud.dir/src/sendthread.cpp.o: /home/learningx/qingzhou_ws/src/qingzhou_cloud/src/sendthread.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/learningx/qingzhou_ws/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Building CXX object qingzhou_cloud/CMakeFiles/qingzhou_cloud.dir/src/sendthread.cpp.o"
	cd /home/learningx/qingzhou_ws/build/qingzhou_cloud && /usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/qingzhou_cloud.dir/src/sendthread.cpp.o -c /home/learningx/qingzhou_ws/src/qingzhou_cloud/src/sendthread.cpp

qingzhou_cloud/CMakeFiles/qingzhou_cloud.dir/src/sendthread.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/qingzhou_cloud.dir/src/sendthread.cpp.i"
	cd /home/learningx/qingzhou_ws/build/qingzhou_cloud && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/learningx/qingzhou_ws/src/qingzhou_cloud/src/sendthread.cpp > CMakeFiles/qingzhou_cloud.dir/src/sendthread.cpp.i

qingzhou_cloud/CMakeFiles/qingzhou_cloud.dir/src/sendthread.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/qingzhou_cloud.dir/src/sendthread.cpp.s"
	cd /home/learningx/qingzhou_ws/build/qingzhou_cloud && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/learningx/qingzhou_ws/src/qingzhou_cloud/src/sendthread.cpp -o CMakeFiles/qingzhou_cloud.dir/src/sendthread.cpp.s

qingzhou_cloud/CMakeFiles/qingzhou_cloud.dir/src/sendthread.cpp.o.requires:

.PHONY : qingzhou_cloud/CMakeFiles/qingzhou_cloud.dir/src/sendthread.cpp.o.requires

qingzhou_cloud/CMakeFiles/qingzhou_cloud.dir/src/sendthread.cpp.o.provides: qingzhou_cloud/CMakeFiles/qingzhou_cloud.dir/src/sendthread.cpp.o.requires
	$(MAKE) -f qingzhou_cloud/CMakeFiles/qingzhou_cloud.dir/build.make qingzhou_cloud/CMakeFiles/qingzhou_cloud.dir/src/sendthread.cpp.o.provides.build
.PHONY : qingzhou_cloud/CMakeFiles/qingzhou_cloud.dir/src/sendthread.cpp.o.provides

qingzhou_cloud/CMakeFiles/qingzhou_cloud.dir/src/sendthread.cpp.o.provides.build: qingzhou_cloud/CMakeFiles/qingzhou_cloud.dir/src/sendthread.cpp.o


qingzhou_cloud/CMakeFiles/qingzhou_cloud.dir/src/recvthread.cpp.o: qingzhou_cloud/CMakeFiles/qingzhou_cloud.dir/flags.make
qingzhou_cloud/CMakeFiles/qingzhou_cloud.dir/src/recvthread.cpp.o: /home/learningx/qingzhou_ws/src/qingzhou_cloud/src/recvthread.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/learningx/qingzhou_ws/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_4) "Building CXX object qingzhou_cloud/CMakeFiles/qingzhou_cloud.dir/src/recvthread.cpp.o"
	cd /home/learningx/qingzhou_ws/build/qingzhou_cloud && /usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/qingzhou_cloud.dir/src/recvthread.cpp.o -c /home/learningx/qingzhou_ws/src/qingzhou_cloud/src/recvthread.cpp

qingzhou_cloud/CMakeFiles/qingzhou_cloud.dir/src/recvthread.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/qingzhou_cloud.dir/src/recvthread.cpp.i"
	cd /home/learningx/qingzhou_ws/build/qingzhou_cloud && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/learningx/qingzhou_ws/src/qingzhou_cloud/src/recvthread.cpp > CMakeFiles/qingzhou_cloud.dir/src/recvthread.cpp.i

qingzhou_cloud/CMakeFiles/qingzhou_cloud.dir/src/recvthread.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/qingzhou_cloud.dir/src/recvthread.cpp.s"
	cd /home/learningx/qingzhou_ws/build/qingzhou_cloud && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/learningx/qingzhou_ws/src/qingzhou_cloud/src/recvthread.cpp -o CMakeFiles/qingzhou_cloud.dir/src/recvthread.cpp.s

qingzhou_cloud/CMakeFiles/qingzhou_cloud.dir/src/recvthread.cpp.o.requires:

.PHONY : qingzhou_cloud/CMakeFiles/qingzhou_cloud.dir/src/recvthread.cpp.o.requires

qingzhou_cloud/CMakeFiles/qingzhou_cloud.dir/src/recvthread.cpp.o.provides: qingzhou_cloud/CMakeFiles/qingzhou_cloud.dir/src/recvthread.cpp.o.requires
	$(MAKE) -f qingzhou_cloud/CMakeFiles/qingzhou_cloud.dir/build.make qingzhou_cloud/CMakeFiles/qingzhou_cloud.dir/src/recvthread.cpp.o.provides.build
.PHONY : qingzhou_cloud/CMakeFiles/qingzhou_cloud.dir/src/recvthread.cpp.o.provides

qingzhou_cloud/CMakeFiles/qingzhou_cloud.dir/src/recvthread.cpp.o.provides.build: qingzhou_cloud/CMakeFiles/qingzhou_cloud.dir/src/recvthread.cpp.o


# Object files for target qingzhou_cloud
qingzhou_cloud_OBJECTS = \
"CMakeFiles/qingzhou_cloud.dir/src/qingzhou_cloud.cpp.o" \
"CMakeFiles/qingzhou_cloud.dir/src/app.cpp.o" \
"CMakeFiles/qingzhou_cloud.dir/src/sendthread.cpp.o" \
"CMakeFiles/qingzhou_cloud.dir/src/recvthread.cpp.o"

# External object files for target qingzhou_cloud
qingzhou_cloud_EXTERNAL_OBJECTS =

/home/learningx/qingzhou_ws/devel/lib/qingzhou_cloud/qingzhou_cloud: qingzhou_cloud/CMakeFiles/qingzhou_cloud.dir/src/qingzhou_cloud.cpp.o
/home/learningx/qingzhou_ws/devel/lib/qingzhou_cloud/qingzhou_cloud: qingzhou_cloud/CMakeFiles/qingzhou_cloud.dir/src/app.cpp.o
/home/learningx/qingzhou_ws/devel/lib/qingzhou_cloud/qingzhou_cloud: qingzhou_cloud/CMakeFiles/qingzhou_cloud.dir/src/sendthread.cpp.o
/home/learningx/qingzhou_ws/devel/lib/qingzhou_cloud/qingzhou_cloud: qingzhou_cloud/CMakeFiles/qingzhou_cloud.dir/src/recvthread.cpp.o
/home/learningx/qingzhou_ws/devel/lib/qingzhou_cloud/qingzhou_cloud: qingzhou_cloud/CMakeFiles/qingzhou_cloud.dir/build.make
/home/learningx/qingzhou_ws/devel/lib/qingzhou_cloud/qingzhou_cloud: /opt/ros/melodic/lib/libroscpp.so
/home/learningx/qingzhou_ws/devel/lib/qingzhou_cloud/qingzhou_cloud: /usr/lib/aarch64-linux-gnu/libboost_filesystem.so
/home/learningx/qingzhou_ws/devel/lib/qingzhou_cloud/qingzhou_cloud: /opt/ros/melodic/lib/librosconsole.so
/home/learningx/qingzhou_ws/devel/lib/qingzhou_cloud/qingzhou_cloud: /opt/ros/melodic/lib/librosconsole_log4cxx.so
/home/learningx/qingzhou_ws/devel/lib/qingzhou_cloud/qingzhou_cloud: /opt/ros/melodic/lib/librosconsole_backend_interface.so
/home/learningx/qingzhou_ws/devel/lib/qingzhou_cloud/qingzhou_cloud: /usr/lib/aarch64-linux-gnu/liblog4cxx.so
/home/learningx/qingzhou_ws/devel/lib/qingzhou_cloud/qingzhou_cloud: /usr/lib/aarch64-linux-gnu/libboost_regex.so
/home/learningx/qingzhou_ws/devel/lib/qingzhou_cloud/qingzhou_cloud: /opt/ros/melodic/lib/libxmlrpcpp.so
/home/learningx/qingzhou_ws/devel/lib/qingzhou_cloud/qingzhou_cloud: /opt/ros/melodic/lib/libroscpp_serialization.so
/home/learningx/qingzhou_ws/devel/lib/qingzhou_cloud/qingzhou_cloud: /opt/ros/melodic/lib/librostime.so
/home/learningx/qingzhou_ws/devel/lib/qingzhou_cloud/qingzhou_cloud: /opt/ros/melodic/lib/libcpp_common.so
/home/learningx/qingzhou_ws/devel/lib/qingzhou_cloud/qingzhou_cloud: /usr/lib/aarch64-linux-gnu/libboost_system.so
/home/learningx/qingzhou_ws/devel/lib/qingzhou_cloud/qingzhou_cloud: /usr/lib/aarch64-linux-gnu/libboost_thread.so
/home/learningx/qingzhou_ws/devel/lib/qingzhou_cloud/qingzhou_cloud: /usr/lib/aarch64-linux-gnu/libboost_chrono.so
/home/learningx/qingzhou_ws/devel/lib/qingzhou_cloud/qingzhou_cloud: /usr/lib/aarch64-linux-gnu/libboost_date_time.so
/home/learningx/qingzhou_ws/devel/lib/qingzhou_cloud/qingzhou_cloud: /usr/lib/aarch64-linux-gnu/libboost_atomic.so
/home/learningx/qingzhou_ws/devel/lib/qingzhou_cloud/qingzhou_cloud: /usr/lib/aarch64-linux-gnu/libpthread.so
/home/learningx/qingzhou_ws/devel/lib/qingzhou_cloud/qingzhou_cloud: /usr/lib/aarch64-linux-gnu/libconsole_bridge.so.0.4
/home/learningx/qingzhou_ws/devel/lib/qingzhou_cloud/qingzhou_cloud: qingzhou_cloud/CMakeFiles/qingzhou_cloud.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/learningx/qingzhou_ws/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_5) "Linking CXX executable /home/learningx/qingzhou_ws/devel/lib/qingzhou_cloud/qingzhou_cloud"
	cd /home/learningx/qingzhou_ws/build/qingzhou_cloud && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/qingzhou_cloud.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
qingzhou_cloud/CMakeFiles/qingzhou_cloud.dir/build: /home/learningx/qingzhou_ws/devel/lib/qingzhou_cloud/qingzhou_cloud

.PHONY : qingzhou_cloud/CMakeFiles/qingzhou_cloud.dir/build

qingzhou_cloud/CMakeFiles/qingzhou_cloud.dir/requires: qingzhou_cloud/CMakeFiles/qingzhou_cloud.dir/src/qingzhou_cloud.cpp.o.requires
qingzhou_cloud/CMakeFiles/qingzhou_cloud.dir/requires: qingzhou_cloud/CMakeFiles/qingzhou_cloud.dir/src/app.cpp.o.requires
qingzhou_cloud/CMakeFiles/qingzhou_cloud.dir/requires: qingzhou_cloud/CMakeFiles/qingzhou_cloud.dir/src/sendthread.cpp.o.requires
qingzhou_cloud/CMakeFiles/qingzhou_cloud.dir/requires: qingzhou_cloud/CMakeFiles/qingzhou_cloud.dir/src/recvthread.cpp.o.requires

.PHONY : qingzhou_cloud/CMakeFiles/qingzhou_cloud.dir/requires

qingzhou_cloud/CMakeFiles/qingzhou_cloud.dir/clean:
	cd /home/learningx/qingzhou_ws/build/qingzhou_cloud && $(CMAKE_COMMAND) -P CMakeFiles/qingzhou_cloud.dir/cmake_clean.cmake
.PHONY : qingzhou_cloud/CMakeFiles/qingzhou_cloud.dir/clean

qingzhou_cloud/CMakeFiles/qingzhou_cloud.dir/depend:
	cd /home/learningx/qingzhou_ws/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/learningx/qingzhou_ws/src /home/learningx/qingzhou_ws/src/qingzhou_cloud /home/learningx/qingzhou_ws/build /home/learningx/qingzhou_ws/build/qingzhou_cloud /home/learningx/qingzhou_ws/build/qingzhou_cloud/CMakeFiles/qingzhou_cloud.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : qingzhou_cloud/CMakeFiles/qingzhou_cloud.dir/depend

