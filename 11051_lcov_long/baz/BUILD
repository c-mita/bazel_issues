# https://github.com/bazelbuild/bazel/issues/11051
# to break lcov merging (invocations spread over several tests):
# bazel coverage baz:test01 baz:test02 baz:test03 baz:test04 baz:test05 --combined_report=lcov

# to break gcov parsing (one test exceeds INT32_MAX counts):
# bazel coverage baz:bar_test --combined_report=lcov

cc_library(
    name = "lib",
    hdrs = ["foo.h"],
    srcs = ["foo.cc"],
)

cc_test(
    name = "bar_test",
    srcs = ["bar_test.cc"],
    copts = ["-Iexternal/gtest/include"],
    deps = [
        "@gtest//:main",
        ":lib",
    ],
)

cc_test(
    name = "test01",
    srcs = ["foo_test.cc"],
    copts = ["-Iexternal/gtest/include"],
    deps = [
        "@gtest//:main",
        ":lib",
    ],
)

cc_test(
    name = "test02",
    srcs = ["foo_test.cc"],
    copts = ["-Iexternal/gtest/include"],
    deps = [
        "@gtest//:main",
        ":lib",
    ],
)

cc_test(
    name = "test03",
    srcs = ["foo_test.cc"],
    copts = ["-Iexternal/gtest/include"],
    deps = [
        "@gtest//:main",
        ":lib",
    ],
)

cc_test(
    name = "test04",
    srcs = ["foo_test.cc"],
    copts = ["-Iexternal/gtest/include"],
    deps = [
        "@gtest//:main",
        ":lib",
    ],
)

cc_test(
    name = "test05",
    srcs = ["foo_test.cc"],
    copts = ["-Iexternal/gtest/include"],
    deps = [
        "@gtest//:main",
        ":lib",
    ],
)
