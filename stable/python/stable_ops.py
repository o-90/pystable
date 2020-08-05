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
"""collection of alpha-stable distribution ops."""

import pystable


def alpha_stable_fit(time_series):
  """
  Args:
    time_series: list(float), a vector of random variables

  Returns:
    dic: dict(str), a dictionary of the fitted alpha stable distribution
      parameters

  Example:
    >>> x = np.random.normal(0, 1, 100)
    >>> alpha_stable_fit(x)
    ... {
          'sigma': 0.7261882362117942,
          'mu': 0.007743242784164271,
          'beta': 0.0,
          'alpha': 1.9857327983276232
        }
  """
  dic = pystable._alpha_stable_fit(time_series)
  return dic


def alpha_stable_sim(num_samples, alpha, beta, mu, sigma):
  """
  Args:
    num_samples: int, the number of samples you want to generate
    alpha: float, parameter of alpha-stable distribution
    beta: float, parameter of alpha-stable distribution
    mu: float, parameter of alpha-stable distribution
    sigma: float, parameter of alpha-stable distribution

  Returns:
    vec: list(float), a vector of random samples from the specified
      distribution, of size `num_samples`

  Examples:
    >>> alpha_stable_sim(1000, 1.111, -0.654739, 0.321, 0.678)
    ... [0.3134000018397731,
         0.8627955825167786,
         -1.5608502233572918,
         ...
         0.06804660324189649]
  """
  vec = pystable._alpha_stable_sim(num_samples, alpha, beta, mu, sigma)
  return vec
