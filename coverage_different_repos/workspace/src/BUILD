cc_binary(
    name = "bin",
    srcs = ["bin.cc"],
    deps = ["@foo//:foo_lib"],
)

cc_library(
    name = "lib",
    srcs = ["bin.cc"],
    hdrs = ["bin.h"],
    deps = ["@foo//:foo_lib"],
)

cc_test(
    name = "lib_test",
    srcs = ["test.cc"],
    copts = ["-Iexternal/gtest/include"],
    deps = [
        "@gtest//:main",
        ":lib",
    ],
)
