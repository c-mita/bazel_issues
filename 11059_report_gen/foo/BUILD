cc_library(
    name = "foo",
    hdrs = ["foo.h"],
    srcs = ["foo.cc"],
)

cc_test(
    name = "foo_test2",
    srcs = ["foo_test_2.cc"],
    copts = ["-Iexternal/gtest/include"],
    deps = [
        "@gtest//:main",
        ":foo",
    ],
)

cc_test(
    name = "foo_test",
    srcs = ["foo_test.cc"],
    copts = ["-Iexternal/gtest/include"],
    deps = [
        "@gtest//:main",
        ":foo",
    ],
)
