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

if(Python_TARGET_VERSION STREQUAL "")
  find_package(Python COMPONENTS Development)
  include_directories(SYSTEM ${Python_INCLUDE_DIRS})
elseif(Python_TARGET_VERSION VERSION_LESS "3.6.0")
  message(FATAL_ERROR
    "Only Python 3 is supported, not ${Python_TARGET_VERSION}")
elseif(Python_TARGET_VERSION VERSION_GREATER_EQUAL "3.6.0")
  find_package(Python3 COMPONENTS Interpreter Development)
  include_directories(SYSTEM ${Python3_INCLUDE_DIRS})
  if(Python3_VERSION VERSION_LESS Python_TARGET_VERSION)
    message(FATAL_ERROR
      "Python found ${Python3_VERSION} < ${Python_TARGET_VERSION}")
  endif()
endif()

set(PYTHON_BINDINGS ${PYTHON_BINDINGS} pybind/pystable.cc)
add_library(pystable MODULE ${PYTHON_BINDINGS} ${STABLE_OBJECTS})
set_target_properties(pystable PROPERTIES PREFIX "")

# TODO(gobrewers14): add python tests
# python tests
# set(PYTHON_TESTS ${PYTHON_TESTS}
#   tests/adder_test.py
# )
# 
# foreach(py_test_file IN LISTS PYTHON_TESTS)
#   get_filename_component(py_test ${py_test_file} NAME_WE)
#   add_test(NAME python_${py_test}
#       COMMAND python3 ${CMAKE_CURRENT_SOURCE_DIR}/${py_test_file})
#   set_property(TEST python_${py_test}
#       PROPERTY ENVIRONMENT
#       PYTHONPATH=${CMAKE_CURRENT_BINARY_DIR}:${CMAKE_CURRENT_SOURCE_DIR}/../..;
#       TEST_SRCDIR=${CMAKE_CURRENT_SOURCE_DIR}/../..)
# endforeach(py_test_file)