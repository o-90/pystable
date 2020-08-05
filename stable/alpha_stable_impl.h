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

#ifndef ALPHA_STABLE_IMPL_H_
#define ALPHA_STABLE_IMPL_H_

#include "stable/alpha_stable.h"

#include <string>
#include <vector>
#include <unordered_map>

std::unordered_map<std::string, double> AlphaStableFit(std::vector<double>& v);
std::vector<double> AlphaStableSimulator(int size,
                                         double alpha,
                                         double beta,
                                         double mu,
                                         double sigma);
#endif  // ALPHA_STABLE_IMPL_H_
