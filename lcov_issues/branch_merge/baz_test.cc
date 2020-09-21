#include "gtest/gtest.h"
#include "baz.h"

TEST(baz_test, t_struct) {
    EXPECT_EQ(do_many_things(12, 23), 58);
}

