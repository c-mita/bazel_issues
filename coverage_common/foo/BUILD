load("//cc:cc.bzl", "cc_bin", "cc_lib", "test_cc_test")

cc_bin(
    name = "foo",
    srcs = ["foo.cc"],
    deps = ["foo_lib"],
)

cc_lib(
    name = "foo_lib",
    srcs = ["foo_lib.cc"],
    hdrs = ["foo_lib.h"],
)

cc_library(
    name = "foo_native_lib",
    srcs = ["foo_lib.cc"],
    hdrs = ["foo_lib.h"],
)

cc_test(
    name = "foo_native_test",
    srcs = ["foo_test.cc"],
    deps = ["foo_native_lib"],
)

test_cc_test(
    name = "foo_test",
    srcs = ["foo_test.cc"],
    deps = ["foo_lib"],
)

test_cc_test(
    name = "foo_mixed_test",
    srcs = ["foo_test.cc"],
    deps = ["foo_native_lib"],
)
