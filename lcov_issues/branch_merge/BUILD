cc_library(
    name = "lib",
    hdrs = ["lib.h"],
)

cc_library(
    name = "foo",
    hdrs = ["foo.h"],
    srcs = ["foo.cc"],
    deps = [":lib"],
)

cc_library(
    name = "bar",
    hdrs = ["bar.h"],
    srcs = ["bar.cc"],
    deps = [":lib"],
)

cc_library(
    name = "baz",
    hdrs = ["baz.h"],
    srcs = ["baz.cc", "bar.h"],
    deps = [":lib"],
)

cc_test(
    name = "foo_test",
    srcs = ["foo_test.cc"],
    copts = ["-Iexternal/gtest/include"],
    deps = [
        ":foo",
        "@gtest//:main",
    ]
)

cc_test(
    name = "bar_test",
    srcs = ["bar_test.cc"],
    copts = ["-Iexternal/gtest/include"],
    deps = [
        ":bar",
        "@gtest//:main",
    ]
)

cc_test(
    name = "baz_test",
    srcs = ["baz_test.cc"],
    copts = ["-Iexternal/gtest/include"],
    deps = [
        ":baz",
        "@gtest//:main",
    ]
)
