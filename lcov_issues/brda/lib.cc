#include "brda/lib.h"

unsigned int foo(bool v, int i, unsigned int j) {
    if (v) {
        while (i-- > 0) {
            j ^= i;
        }
        return j;
    } else {
        for (int k = 0; k < i; k++) {
            j *= i;
            j >>= 1;
        }
        return j;
    }
}

int bar(int i) {
    switch(i) {
        case 1:
            return 12;
        case 73:
            return 57;
        case -123:
            return 0x7FFFFFFF;
        default:
            return i * 2;
    }
}
