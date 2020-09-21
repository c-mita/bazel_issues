#include "bar.h"
#include "lib.h"

int do_struct_things(int x, int y) {
    thing z(x, y);
    z = do_t_thing<thing>(z, y);
    return z.x[0];
}
