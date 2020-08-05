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