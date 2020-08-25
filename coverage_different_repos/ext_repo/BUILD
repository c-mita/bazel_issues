cc_library(
    name = "foo_lib",
    srcs = ["lib.cc"],
    hdrs = ["lib.h"],
    visibility = ["//visibility:public"],
)

cc_test(
    name = "foo_test",
    srcs = ["test.cc"],
    copts = ["-Iexternal/gtest/include"],
    deps = [
        "@gtest//:main",
        ":foo_lib",
    ],
)
