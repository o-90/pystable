# -*- coding: utf-8 -*-

#
# Copyright (c) John Martinez, 2020.
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
"""setup script for stable package."""

from setuptools import setup
from setuptools import find_packages


if __name__ == "__main__":
  setup(
    name="stable",
    version="0.0.1",
    author="John Martinez",
    url="https://github.com/gobrewers14/stable",
    package_dir={"": "build/lib", },
    package_data={"": ["*.so", ]},)
