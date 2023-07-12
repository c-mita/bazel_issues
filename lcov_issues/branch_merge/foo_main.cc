#include "foo.h"
#include <stdio.h>

int main() {
    if (35 == do_t_int(12, 23)) {
        printf("Pass\n");
        return 0;
    }
    printf("Fail\n");
    return 1;
}
