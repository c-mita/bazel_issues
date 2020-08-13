package(default_visibility = ["//visibility:public"])

java_library(
    name = "libfoo",
    srcs = ["LibFoo.java"],
)

java_test(
    name = "foo_test",
    size = "small",
    srcs = ["LibFooTest.java"],
    test_class = "LibFooTest",
    deps = [":libfoo"],
)
