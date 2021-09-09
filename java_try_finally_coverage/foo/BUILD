java_library(
    name = "tryfinally",
    srcs = ["TryFinally.java"],
)

java_test(
    name = "tryfinally_test",
    size = "small",
    srcs = ["TryFinallyTest.java"],
    test_class = "TryFinallyTest",
    deps = [
        ":tryfinally",
        "@junit//:junit4"
    ],
)
