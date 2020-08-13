java_library(
    name = "jlib",
    srcs = ["Lib.java"],
)

java_test(
    name = "jbranch",
    size = "small",
    srcs = ["BranchTest.java"],
    test_class = "BranchTest",
    deps = [":jlib", "//junit:junit4"],
)

java_test(
    name = "jnobranch",
    size = "small",
    srcs = ["NoBranchTest.java"],
    test_class = "NoBranchTest",
    deps = [":jlib", "//junit:junit4"],
)

java_test(
    name = "jswitch",
    size = "small",
    srcs = ["SwitchTest.java"],
    test_class = "SwitchTest",
    deps = [":jlib", "//junit:junit4"],
)

cc_library(
    name = "lib",
    hdrs = ["lib.h"],
    srcs = ["lib.cc"],
)

cc_test(
    name = "branch",
    srcs = ["branch.cc"],
    copts = ["-Iexternal/gtest/include"],
    deps = [
        "@gtest//:main",
        ":lib",
    ],
)

cc_test(
    name = "nobranch",
    srcs = ["nobranch.cc"],
    copts = ["-Iexternal/gtest/include"],
    deps = [
        "@gtest//:main",
        ":lib",
    ],
)

cc_test(
    name = "switch",
    srcs = ["switch.cc"],
    copts = ["-Iexternal/gtest/include"],
    deps = [
        "@gtest//:main",
        ":lib",
    ],
)
