#include "lib.h"

unsigned int lib_foo(unsigned int n) {
    return (n << 8) ^ (n >> 3) ^ n;
}
