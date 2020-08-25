#include <iostream>
#include "lib.h"
#include "bin.h"

int main() {
    std::cout << calculate_foo() << std::endl;
    return 0;
}

int calculate_foo() {
    return (lib_foo(1024) + lib_foo(643)) ^ lib_foo(0x7FFA4532);
}
