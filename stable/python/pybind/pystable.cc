/*
 * Copyright (c) 2020 John Martinez <gobrewers14@protonmail.com>
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <https://www.gnu.org/licenses/>.
 * =========================================================================*/

#include <pybind11/pybind11.h>
#include <pybind11/stl.h>

#include "stable/alpha_stable_impl.h"

namespace py = pybind11;

PYBIND11_MODULE(pystable, m) {
  m.doc() = "alpha-stable distribution fitting wrapper";
  m.def("_alpha_stable_fit", &AlphaStableFit);
  m.doc() = "simulate n number of alpha-stable random variables";
  m.def("_alpha_stable_sim", &AlphaStableSimulator);
}