cc_library(
    name = "foo_cc",
    srcs = ["foo.cc"],
    hdrs = ["foo.h"],
)

cc_library(
    name = "foo_cc_jni",
    srcs = ["Foo.cc", "Foo.h"],
    hdrs = ["Foo.h"],
    deps = [":foo_cc", "//jni:copy_jni_hdr_lib"],
    alwayslink=True,
)

cc_binary(
    name = "foo_main",
    srcs = ["foo_main.cc"],
    deps = [":foo_cc"],
)

cc_binary(
    name = "foo-jni",
    deps = [":foo_cc_jni"],
    linkshared = True,
)

java_library(
    name = "foo",
    srcs = ["Foo.java"],
    #data = [":foo-jni"],
    runtime_deps = [":foo-jni"],
)

java_library(
    name = "bar",
    srcs = ["Bar.java"],
    deps = [":foo"],
)

java_test(
    name = "bar_test",
    srcs = ["BarTest.java"],
    test_class = "BarTest",
    deps = [":bar", "@junit//:junit4"],
)
