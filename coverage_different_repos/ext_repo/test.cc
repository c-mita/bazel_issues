#include "gtest/gtest.h"
#include "lib.h"

TEST(lib_foo, test_foo) {
    ASSERT_LT(0, (int) lib_foo(256));
}
