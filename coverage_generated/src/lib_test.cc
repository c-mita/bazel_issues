#include "gtest/gtest.h"
#include "lib.h"

TEST(bar, test_lib) {
  ASSERT_EQ(84, bar(2));
  ASSERT_EQ(4074, bar(97));
  ASSERT_EQ(0, bar(0));
}
