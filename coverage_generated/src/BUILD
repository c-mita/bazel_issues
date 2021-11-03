genrule(
    name = "foo_impl",
    srcs = [],
    outs = ["foo.cc"],
    cmd = "echo 'int foo() {return 42;}' > $@",
)


cc_library(
    name = "lib",
    hdrs = ["lib.h"],
    srcs = [
        "lib.cc",
        "foo_impl"
    ],
)

cc_test(
    name = "lib_test",
    srcs = ["lib_test.cc"],
    copts = ["-Iexternal/gtest/include"],
    deps = [
        "@gtest//:main",
        ":lib"
    ],
)
