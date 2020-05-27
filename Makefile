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
SHELL := /bin/bash

# docker ---------------------------------------------------------------------
PREFIX := demiurge
IMAGE := stable
TAG := latest

# python ---------------------------------------------------------------------
PY_VERSION := 3.7.3

# pybind11
PYBIND11_VERSION := 2.4.3

# c/c++ ----------------------------------------------------------------------
GCC := gcc
GXX := g++
FLAGS := -Wall -O3 -pthread -shared -fPIC
GCCFLAGS := $(FLAGS) -std=c99
GXXFLAGS := $(FLAGS) -std=c++11
LDFLAGS := -lblas -lgsl -lm -lgslcblas -lstable
PROJECT_DIR := stable
BUILD_DIR := build
LIB_DIR := lib
SUFFIX := .cpython-37m-x86_64-linux-gnu.so
SO_NAME := alpha_stable
SRC_DIR := $(PROJECT_DIR)/src
C_SRCS := $(shell find $(SRC_DIR) -name '*.c')
OBJS := $(C_SRCS:$(SRC_DIR)/%.c=$(BUILD_DIR)/%.o)
CC_SRCS := $(shell find $(SRC_DIR) -name '*.cc')
OBJS := $(OBJS) $(CC_SRCS:$(SRC_DIR)/%.cc=$(BUILD_DIR)/%.o)
DEPS := $(OBJS:.o=.d)
INCLUDES := -I/usr/local/include/python3.7m -I/root/.local/include/python3.7m

echo:
	@echo "objects: $(OBJS)"
	@echo "dependencies: $(DEPS)"

.PHONY: build-image
build-image:
	docker build \
		--build-arg PY_VERSION=$(PY_VERSION) \
		--build-arg PYBIND11_VERSION=$(PYBIND11_VERSION) \
		--build-arg PROJECT_DIR=$(PROJECT_DIR) \
		-t $(PREFIX)/$(IMAGE):$(TAG) \
		-f Dockerfile .

.PHONY: build
build:
	docker run --rm \
		-v `pwd`:/app \
		-w /app \
		$(PREFIX)/$(IMAGE):$(TAG) \
		make build-local

build-local: dirs $(PROJECT_DIR)/$(LIB_DIR)/$(SO_NAME)$(SUFFIX)

dirs:
	@echo "creating build/ directory"
	@mkdir -p $(BUILD_DIR)/$(LIB_DIR)
	@mkdir -p $(PROJECT_DIR)/$(LIB_DIR)

$(PROJECT_DIR)/$(LIB_DIR)/$(SO_NAME)$(SUFFIX): $(OBJS)
	@echo "linking: $@"
	$(GXX) $(GXXFLAGS) $(INCLUDES) $(OBJS) -o $@ $(LDFLAGS)

$(BUILD_DIR)/%.o: $(SRC_DIR)/%.c
	@echo "compiling: $< -> $@"
	$(GCC) $(GCCFLAGS) -MP -MMD -c $< -o $@

$(BUILD_DIR)/%.o: $(SRC_DIR)/%.cc
	@echo "compiling: $< -> $@"
	$(GXX) $(GXXFLAGS) $(INCLUDES) -MP -MMD -c $< -o $@ $(LDFLAGS)

.PHONY: test
test:
	docker run --rm \
		-v `pwd`:/app \
		-w /app \
		$(PREFIX)/$(IMAGE):$(TAG) \
		/bin/bash -c """make build-local && pip install -e . && make test-local"""

test-local: test-local-lint
	pytest -W ignore . -vv

test-local-lint:
	flake8 stable --filename="*.py" --ignore E111

.PHONY: clean
clean:
	docker run --rm \
		-v `pwd`:/app \
		-w /app \
		$(PREFIX)/$(IMAGE):$(TAG) \
		make clean-local

clean-local:
	$(RM) -rf dist
	$(RM) -rf $(BUILD_DIR)
	$(RM) -rf $(PROJECT_DIR)/$(LIB_DIR)/*.so
	$(RM) *.o
	$(RM) *.so
	$(RM) -rf .pytest_cache
