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
