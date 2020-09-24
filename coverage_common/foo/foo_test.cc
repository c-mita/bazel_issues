#include "foo_lib.h"

bool test_foo_1() {
    std::string actual = foo_1();
    if (actual != "Hello World! :)") {
        return false;
    }
    return true;
}

int main() {
    if (!test_foo_1()) {
        return 1;
    }
    return 0;
}
