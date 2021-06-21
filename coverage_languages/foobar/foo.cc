#include "foo.h"

int calc_foo(int n) {
  int r = n < 0 ? -n / 2 : n * 2;
  if (r % 7 == 0) {
    r *= r;
  }
  if (r % 17 == 0) {
    r = -r;
  }
  return r;
}
