#!/bin/bash

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

set -ex

PORT=4747
PREFIX=demiurge
IMAGE=stable
TAG=latest

echo -e "\033[32m[+] running notebook on port $PORT\e[0m" \
&& docker run --rm \
     -p ${PORT}:${PORT} \
     -v `pwd`:/app \
     -w /app \
     ${PREFIX}/${IMAGE}:${TAG} \
     jupyter notebook --no-browser --allow-root --ip 0.0.0.0 --port ${PORT} \
|| echo -e "\033[31m[-] notebook failed to load\e[0m"
