#include "foo.h"
#include <cstdio>

int main() {
  int v = calc_foo(12);
  std::printf("%d\n", v);
  return 0;
}
