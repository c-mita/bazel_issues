#ifndef BRANCH_MERGE_LIB_H
#define BRANCH_MERGE_LIB_H

template <typename T>
T do_t_thing(T x, int y) {
    T z = x;
    z = y > 0 ? z + y : z;
    return z;
}

#endif
