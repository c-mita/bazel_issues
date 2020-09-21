#include "gtest/gtest.h"
#include "bar.h"

TEST(bar_test, t_struct) {
    EXPECT_EQ(do_struct_things(12, 23), 35);
}
