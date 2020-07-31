#include <chrono>
#include <thread>

#include "bar/basename.h"
#include "gtest/gtest.h"

TEST(basename, get_number) {
    EXPECT_EQ(get_basename_number(), THE_MAGIC_NUMBER);
    std::this_thread::sleep_for(std::chrono::seconds(3));
}
