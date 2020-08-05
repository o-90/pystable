# -*- coding: utf-8 -*-

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
"""test cases for alpha stable parameter fitting."""

import numpy as np
import unittest as test_lib

from stable.python import stable_ops


class AlphaStableTest(test_lib.TestCase):
  def setUp(self):
    self._seed = np.random.seed(19820724)

  def test_alpha_fit_fn(self):
    x = list(np.random.normal(0, 1, 10000))
    y = stable_ops.alpha_stable_fit(x)
    alpha = y['alpha']
    beta = y['beta']
    sigma = y['sigma']
    mu = y['mu']
    self.assertTrue(np.abs(alpha - 2.0) < 0.1)
    self.assertTrue(np.abs(beta - 0.0) < 0.1)
    self.assertTrue(np.abs(sigma - 0.70642) < 0.1)
    self.assertTrue(np.abs(mu - 0.009652) < 0.1)

  def test_alpha_sim_fn(self):
    sz = 100
    actual = stable_ops.alpha_stable_sim(
        sz, 1.5674398, 0.8863497, 0.6758493, 0.0012467)
    self.assertEqual(len(actual), sz)


if __name__ == "__main__":
  test_lib.main()
