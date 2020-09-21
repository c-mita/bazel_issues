#include "gtest/gtest.h"
#include "foo.h"

TEST(foo_test, t_int) {
    EXPECT_EQ(do_t_int(12, 23), 35);
}
