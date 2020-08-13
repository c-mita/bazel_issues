#include "baz/foo.h"

unsigned int foo() {
    unsigned int j = 0;
    for (int i = 0; i < 0x3FFFFFFF; i++) j ^= i;
    return j;
}

unsigned int bar() {
    unsigned int n = 0;
    for (unsigned int i = 0; i < 0x3FFFFFFF; i++) {
        for (unsigned int j = 0; j < 10; j++) {
            n ^= j;
            n ^= i << j;
        }
    }
    return n;
}
