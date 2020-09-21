#include "baz.h"
#include "lib.h"

int do_many_things(int x, int y) {
    thing z(x, y);
    z = do_t_thing(z, y);
    return do_t_thing(z.x[0], y);
}
