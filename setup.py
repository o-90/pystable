# -*- coding: utf-8 -*-

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
"""installation script for pystable."""

import os
import sys
import subprocess
import setuptools

from setuptools.command.build_ext import build_ext


class CMakeExtension(setuptools.Extension):
  def __init__(self, name, sourcedir=""):
    super().__init__(name, sources=[])
    self.sourcedir = os.path.abspath(sourcedir)


class BuildExt(build_ext):
  def run(self):
    try:
      subprocess.check_call(["cmake", "--version"])
    except OSError as e:
      ext_names = ", ".join(e.name for e in self.extensions)
      msg = "CMake must be installed to build the project."
      raise RuntimeError(msg)

    for ext in self.extensions:
      self.build_extension(ext)

  def build_extension(self, ext):
    extension_dir = os.path.abspath(
        os.path.dirname(self.get_ext_fullpath(ext.name)))
    cmake_args = [
        "-DPython_TARGET_VERSION=3.7",
        "-DCMAKE_CXX_COMPILER=g++",
        f"-DCMAKE_LIBRARY_OUTPUT_DIRECTORY={extension_dir}",
    ]
    if not os.path.exists(self.build_temp):
      os.makedirs(self.build_temp)
    subprocess.check_call(
        ["cmake", ext.sourcedir] + cmake_args,
        cwd=self.build_temp)
    env = os.environ.copy()
    subprocess.check_call(
        ["make", "-j2"],
        cwd=self.build_temp,
        env=env)


if __name__ == "__main__":
  setuptools.setup(
      name="pystable",
      version="0.0.1rc0",
      author="John Martinez",
      ext_modules=[CMakeExtension("pystable", sourcedir="stable")],
      cmdclass={"build_ext": BuildExt},
      zip_safe=False)