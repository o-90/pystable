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
SHELL := /bin/bash

PREFIX := demiurge
IMAGE := stable
TAG := latest

PY_VERSION := 3.7.3
PYBIND11_VERSION := 2.4.3
PROJECT_DIR := stable

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

build-local:
	mkdir -p $(PROJECT_DIR)/build \
		&& cd $(PROJECT_DIR)/build \
		&& cmake -DPython_TARGET_VERSION="3.7.7" -DBUILD_TYPE=debug ../ \
		&& make \
		&& cd ../ \
		&& rm -rf build

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

clean-py:
	$(shell find stable -name "*.py[co]" -o -name __pycache__ -exec rm -rf {} +)

clean-local: clean-py
	$(RM) -rf $(PROJECT_DIR)/build
	$(RM) -rf dist/
	$(RM) -rf build/
	$(RM) -rf .pytest_cache/
	$(RM) *.o
	$(RM) *.so
