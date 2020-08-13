java_library(
    name = "libbar",
    srcs = ["LibBar.java"],
    deps = ["//java_packages/foo:libfoo"],
)

java_test(
    name = "bar_test",
    size = "small",
    srcs = ["LibBarTest.java"],
    test_class = "LibBarTest",
    deps = [":libbar"],
)
