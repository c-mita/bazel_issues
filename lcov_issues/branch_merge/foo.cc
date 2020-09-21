#include "foo.h"
#include "lib.h"

int do_t_int(int x, int y) {
    return do_t_thing<int>(x, y);
}

