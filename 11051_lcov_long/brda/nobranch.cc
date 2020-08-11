#include "gtest/gtest.h"
#include "brda/lib.h"

TEST(nobranch, test_only_true) {
    for (int i = 1; i <= 101; i++) {
        EXPECT_EQ(foo(i, 0, 0), 0);
    }
}

