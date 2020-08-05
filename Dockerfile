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

ARG PY_VERSION
FROM python:${PY_VERSION} as base

ENV DEBIAN_FRONTEND=noninteractive
ENV LANG C.UTF-8

RUN apt-get update \
  && apt-get -y install \
    gcc \
    g++ \
    git \
    cmake \
    libgsl-dev \
    libblas-dev \
    build-essential \
    gdb \
  && rm -rf /var/lib/lists/*

RUN set -ex \
  && git clone \
    https://gobrewers14@github.com/gobrewers14/libstable.git \
    /libstable \
  && cd /libstable/stable \
  && mkdir libs \
  && cd .. \
  && make \
  && cp -r stable/src/*.h /usr/include \
  && cp -r stable/libs/*.a /usr/lib \
  && cd ../../ \
  && rm -rf libstable

RUN set -ex \
 && pip install --upgrade --no-cache-dir pip \
 && pip install --upgrade --no-cache-dir pytest numpy flake8

ARG PYBIND11_VERSION
RUN set -ex \
  && git clone -b "v${PYBIND11_VERSION}" \
    --single-branch \
    --depth 1 https://github.com/pybind/pybind11.git \
  && cd pybind11 \
  && mkdir build \
  && cd build \
  && cmake .. \
  && make check -j "$(nproc)" \
  && make install \
  && cd ../ \
  && python setup.py sdist \
  && pip install -U --user --no-cache-dir ./dist/* \
  && cd ../ \
  && rm -rf pybind11

CMD ["/bin/bash"]
