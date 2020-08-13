#include "gtest/gtest.h"
#include "baz/foo.h"

TEST(spam, foo) {
    EXPECT_EQ(foo(), 1073741823UL);
}
