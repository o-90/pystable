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

#include <stdio.h>
#include <time.h>
#include <stable.h>


StableDist* AlphaFit(double* x, const int length) {
  // initial parameter values
  double init_alpha = 1.0;
  double init_beta = 0.5;
  double init_sigma= 1.0;
  double init_mu = 1.0;
  int param = 0;

  StableDist* dist = stable_create(
    init_alpha,
    init_beta,
    init_sigma,
    init_mu,
    param);

  stable_fit_init(dist, x, length, NULL, NULL);
  stable_fit_koutrouvelis(dist, x, length);

  return dist;
}

double* AlphaSimulator(int size,
                       double alpha,
                       double beta,
                       double sigma,
                       double mu) {
  // initialize dist
  int param = 0;
  StableDist* dist = stable_create(alpha, beta, sigma, mu, param);

  // initialize random vector
  double* rnd;
  rnd = malloc(sizeof(double) * size);

  stable_rnd_seed(dist, time(NULL));
  stable_rnd(dist, rnd, size);

  return rnd;
}
