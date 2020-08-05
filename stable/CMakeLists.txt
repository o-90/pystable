# Copyright (c) 2020 John Martinez <gobrewers14@protonmail.com>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.
# ============================================================================

# cmake version
cmake_minimum_required(VERSION 3.12)

# project
project(stable)

# python version
set(Python_TARGET_VERSION "3.7.7")

# g++ flags
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_POSITION_INDEPENDENT_CODE ON)
set(CMAKE_CXX_FLAGS "-Wall -pthread -shared")

if (NOT BUILD_TYPE)
  set(BUILD_TYPE Debug)
endif()

if (${BUILD_TYPE} EQUAL "Debug")
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -ggdb")
endif()

if (${BUILD_TYPE} EQUAL "Testing")
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -O2")
endif()

if (${BUILD_TYPE} EQUAL "Release")
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -DNDEBUG -O3")
endif()

if(APPLE)
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -w -undefined dynamic_lookup")
  set(CMAKE_FIND_FRAMEWORK LAST)
endif()

# enable tests
enable_testing()

# core files
set(STABLE_CORE_FILES
  alpha_stable.c
  alpha_stable.h
  alpha_stable_impl.cc
  alpha_stable_impl.h
)

# lib
add_library(stable_core OBJECT ${STABLE_CORE_FILES})

# -lblas -lgsl -lm -lgslcblas -lstable
link_libraries(stable_core blas)
link_libraries(stable_core gsl)
link_libraries(stable_core m)
link_libraries(stable_core gslcblas)
link_libraries(stable_core stable)

# objects
set(STABLE_OBJECTS $<TARGET_OBJECTS:stable_core>)

# includes
include_directories(..)

# python
add_subdirectory(python)
