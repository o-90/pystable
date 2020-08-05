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

#include <string>
#include <vector>
#include <unordered_map>

#include "stable/alpha_stable.h"

#include <stable.h>  // make sure this is always imported last

// implementations
std::unordered_map<std::string, double> AlphaStableFit(std::vector<double>& v) {
  std::unordered_map<std::string, double> out_m;
  const int vsz = v.size();
  double x[vsz];

  for (int i = 0; i < vsz; ++i) {
    x[i] = v[i];
  }

  StableDist* out = AlphaFit(x, vsz);
  out_m["alpha"] = out->alpha;
  out_m["beta"] = out->beta;
  out_m["sigma"] = out->sigma;
  out_m["mu"] = out->mu_0;

  return out_m;
}

std::vector<double> AlphaStableSimulator(int size,
                                         double alpha,
                                         double beta,
                                         double mu,
                                         double sigma) {
  double* out = AlphaSimulator(size, alpha, beta, mu, sigma);
  std::vector<double> output;

  for (int i = 0; i < size; ++i) {
    output.push_back(out[i]);
  }

  return output;
}
