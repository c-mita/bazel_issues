#include "gtest/gtest.h"
#include "brda/lib.h"

TEST(branch, test_true) {
    EXPECT_EQ(foo(true, 10, 10), (unsigned int) 11);
}

TEST(branch, test_false) {
    EXPECT_EQ(foo(false, 10, 10), (unsigned int) 97656250);
}
