genrule(
    name = "generate_foo",
    outs = ["foo.cc"],
    cmd = "echo 'int foo() { return 42; }' > $(OUTS)",
)

genrule(
    name = "generate_foo_h",
    outs = ["foo.h"],
    cmd = "echo 'int foo();' > $(OUTS)",
)

cc_library(
    name = "foo",
    srcs = ["foo.cc"],
    hdrs = ["foo.h"],
)

genrule(
    name = "generate_test",
    outs = ["test.cc"],
    cmd = "echo '#include \"foo.h\"' >> $(OUTS) ; echo 'int main() { foo(); return 0; }' >> $(OUTS)",
)

cc_test(
    name = "bad_test",
    deps = [":foo"],
    srcs = [
        "test.cc",
    ],
    target_compatible_with = ["@platforms//:incompatible"],
)

cc_test(
    name = "good_test",
    deps = [":foo"],
    srcs = ["test.cc"],
)
