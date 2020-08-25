#include "gtest/gtest.h"
#include "bin.h"

TEST(calculate_foo, test_foo) {
    ASSERT_GT(0, calculate_foo());
}
