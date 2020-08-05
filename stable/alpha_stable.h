#ifndef ALPHA_STABLE_H_ 
#define ALPHA_STABLE_H_ 

#include <stable.h>

extern "C" {
  StableDist* AlphaFit(double* x, const int length);
  double* AlphaSimulator(int size,
                         double alpha,
                         double beta,
                         double mu,
                         double sigma);
} // end extern "C"
#endif  // ALPHA_STABLE_H_ 