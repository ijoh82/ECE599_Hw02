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
CMAKE_SOURCE_DIR = /home/ijoh82/ECE599/Hw02/joh_ws/src

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/ijoh82/ECE599/Hw02/joh_ws/build

# Include any dependencies generated for this target.
include f110-skeletons-spring2020/system/serial/CMakeFiles/serial_example.dir/depend.make

# Include the progress variables for this target.
include f110-skeletons-spring2020/system/serial/CMakeFiles/serial_example.dir/progress.make

# Include the compile flags for this target's objects.
include f110-skeletons-spring2020/system/serial/CMakeFiles/serial_example.dir/flags.make

f110-skeletons-spring2020/system/serial/CMakeFiles/serial_example.dir/examples/serial_example.cc.o: f110-skeletons-spring2020/system/serial/CMakeFiles/serial_example.dir/flags.make
f110-skeletons-spring2020/system/serial/CMakeFiles/serial_example.dir/examples/serial_example.cc.o: /home/ijoh82/ECE599/Hw02/joh_ws/src/f110-skeletons-spring2020/system/serial/examples/serial_example.cc
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/ijoh82/ECE599/Hw02/joh_ws/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object f110-skeletons-spring2020/system/serial/CMakeFiles/serial_example.dir/examples/serial_example.cc.o"
	cd /home/ijoh82/ECE599/Hw02/joh_ws/build/f110-skeletons-spring2020/system/serial && /usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/serial_example.dir/examples/serial_example.cc.o -c /home/ijoh82/ECE599/Hw02/joh_ws/src/f110-skeletons-spring2020/system/serial/examples/serial_example.cc

f110-skeletons-spring2020/system/serial/CMakeFiles/serial_example.dir/examples/serial_example.cc.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/serial_example.dir/examples/serial_example.cc.i"
	cd /home/ijoh82/ECE599/Hw02/joh_ws/build/f110-skeletons-spring2020/system/serial && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/ijoh82/ECE599/Hw02/joh_ws/src/f110-skeletons-spring2020/system/serial/examples/serial_example.cc > CMakeFiles/serial_example.dir/examples/serial_example.cc.i

f110-skeletons-spring2020/system/serial/CMakeFiles/serial_example.dir/examples/serial_example.cc.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/serial_example.dir/examples/serial_example.cc.s"
	cd /home/ijoh82/ECE599/Hw02/joh_ws/build/f110-skeletons-spring2020/system/serial && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/ijoh82/ECE599/Hw02/joh_ws/src/f110-skeletons-spring2020/system/serial/examples/serial_example.cc -o CMakeFiles/serial_example.dir/examples/serial_example.cc.s

f110-skeletons-spring2020/system/serial/CMakeFiles/serial_example.dir/examples/serial_example.cc.o.requires:

.PHONY : f110-skeletons-spring2020/system/serial/CMakeFiles/serial_example.dir/examples/serial_example.cc.o.requires

f110-skeletons-spring2020/system/serial/CMakeFiles/serial_example.dir/examples/serial_example.cc.o.provides: f110-skeletons-spring2020/system/serial/CMakeFiles/serial_example.dir/examples/serial_example.cc.o.requires
	$(MAKE) -f f110-skeletons-spring2020/system/serial/CMakeFiles/serial_example.dir/build.make f110-skeletons-spring2020/system/serial/CMakeFiles/serial_example.dir/examples/serial_example.cc.o.provides.build
.PHONY : f110-skeletons-spring2020/system/serial/CMakeFiles/serial_example.dir/examples/serial_example.cc.o.provides

f110-skeletons-spring2020/system/serial/CMakeFiles/serial_example.dir/examples/serial_example.cc.o.provides.build: f110-skeletons-spring2020/system/serial/CMakeFiles/serial_example.dir/examples/serial_example.cc.o


# Object files for target serial_example
serial_example_OBJECTS = \
"CMakeFiles/serial_example.dir/examples/serial_example.cc.o"

# External object files for target serial_example
serial_example_EXTERNAL_OBJECTS =

/home/ijoh82/ECE599/Hw02/joh_ws/devel/lib/serial/serial_example: f110-skeletons-spring2020/system/serial/CMakeFiles/serial_example.dir/examples/serial_example.cc.o
/home/ijoh82/ECE599/Hw02/joh_ws/devel/lib/serial/serial_example: f110-skeletons-spring2020/system/serial/CMakeFiles/serial_example.dir/build.make
/home/ijoh82/ECE599/Hw02/joh_ws/devel/lib/serial/serial_example: /home/ijoh82/ECE599/Hw02/joh_ws/devel/lib/libserial.so
/home/ijoh82/ECE599/Hw02/joh_ws/devel/lib/serial/serial_example: f110-skeletons-spring2020/system/serial/CMakeFiles/serial_example.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/ijoh82/ECE599/Hw02/joh_ws/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable /home/ijoh82/ECE599/Hw02/joh_ws/devel/lib/serial/serial_example"
	cd /home/ijoh82/ECE599/Hw02/joh_ws/build/f110-skeletons-spring2020/system/serial && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/serial_example.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
f110-skeletons-spring2020/system/serial/CMakeFiles/serial_example.dir/build: /home/ijoh82/ECE599/Hw02/joh_ws/devel/lib/serial/serial_example

.PHONY : f110-skeletons-spring2020/system/serial/CMakeFiles/serial_example.dir/build

f110-skeletons-spring2020/system/serial/CMakeFiles/serial_example.dir/requires: f110-skeletons-spring2020/system/serial/CMakeFiles/serial_example.dir/examples/serial_example.cc.o.requires

.PHONY : f110-skeletons-spring2020/system/serial/CMakeFiles/serial_example.dir/requires

f110-skeletons-spring2020/system/serial/CMakeFiles/serial_example.dir/clean:
	cd /home/ijoh82/ECE599/Hw02/joh_ws/build/f110-skeletons-spring2020/system/serial && $(CMAKE_COMMAND) -P CMakeFiles/serial_example.dir/cmake_clean.cmake
.PHONY : f110-skeletons-spring2020/system/serial/CMakeFiles/serial_example.dir/clean

f110-skeletons-spring2020/system/serial/CMakeFiles/serial_example.dir/depend:
	cd /home/ijoh82/ECE599/Hw02/joh_ws/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/ijoh82/ECE599/Hw02/joh_ws/src /home/ijoh82/ECE599/Hw02/joh_ws/src/f110-skeletons-spring2020/system/serial /home/ijoh82/ECE599/Hw02/joh_ws/build /home/ijoh82/ECE599/Hw02/joh_ws/build/f110-skeletons-spring2020/system/serial /home/ijoh82/ECE599/Hw02/joh_ws/build/f110-skeletons-spring2020/system/serial/CMakeFiles/serial_example.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : f110-skeletons-spring2020/system/serial/CMakeFiles/serial_example.dir/depend

