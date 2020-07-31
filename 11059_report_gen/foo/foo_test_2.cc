#include <chrono>
#include <thread>

#include "gtest/gtest.h"
#include "foo/foo.h"

TEST(NoIdea, Foo2) {
    std::this_thread::sleep_for(std::chrono::seconds(3));
    EXPECT_EQ(foo(), "THIS IS FOO");
}
