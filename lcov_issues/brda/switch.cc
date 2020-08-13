#include "gtest/gtest.h"
#include "brda/lib.h"

TEST(switch_test, test_73) {
    EXPECT_EQ(bar(73), 57);
}

TEST(switch_test, test_0) {
    EXPECT_EQ(bar(0), 0);
}
