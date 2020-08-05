#ifndef ALPHA_STABLE_H_ 
#define ALPHA_STABLE_H_ 

#include <stable.h>

StableDist* AlphaFit(double* x, const int length);
double* AlphaSimulator(int size,
                        double alpha,
                        double beta,
                        double mu,
                        double sigma);

#endif  // ALPHA_STABLE_H_ 
