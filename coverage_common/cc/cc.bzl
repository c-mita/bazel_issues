def find_cpp_toolchain(ctx):
    if hasattr(cc_common, "is_cc_toolchain_resolution_enabled_do_not_use") and cc_common.is_cc_toolchain_resolution_enabled_do_not_use(ctx = ctx):
        if "@bazel_tools//tools/cpp:toolchain_type" in ctx.toolchains:
            return ctx.toolchains["@bazel_tools//tools/cpp:toolchain_type"]
        fail("In order to use find_cpp_toolchain, you must include the '@bazel_tools//tools/cpp:toolchain_type' in the toolchains argument to your rule.")

    if hasattr(ctx.attr, "_cc_toolchain"):
        return ctx.attr._cc_toolchain[cc_common.CcToolchainInfo]
    fail("In order to use find_cpp_toolchain, you must define the '_cc_toolchain' attribute on your rule or aspect.")


def _cc_lib_impl(ctx):
    cc_toolchain = find_cpp_toolchain(ctx)
    feature_configuration = cc_common.configure_features(
        ctx = ctx,
        cc_toolchain = cc_toolchain,
        requested_features = ctx.features,
        unsupported_features = ctx.disabled_features,
    )

    c_contexts = []
    l_contexts = []
    for dep in ctx.attr.deps:
        if CcInfo in dep:
            c_contexts.append(dep[CcInfo].compilation_context)
            l_contexts.append(dep[CcInfo].linking_context)

    c_context, c_outputs = cc_common.compile(
        name = ctx.label.name,
        actions = ctx.actions,
        feature_configuration = feature_configuration,
        cc_toolchain = cc_toolchain,
        srcs = ctx.files.srcs,
        public_hdrs = ctx.files.hdrs,
        compilation_contexts = c_contexts,
    )

    l_context, l_outputs = cc_common.create_linking_context_from_compilation_outputs(
        name = ctx.label.name,
        actions = ctx.actions,
        feature_configuration = feature_configuration,
        cc_toolchain = cc_toolchain,
        language = "c++",
        compilation_outputs = c_outputs,
        linking_contexts = l_contexts,
    )

    instrumented = coverage_common.instrumented_files_info(
        ctx,
        source_attributes = ["srcs", "hdrs"],
        dependency_attributes = ["deps"],
    )

    library = l_outputs.library_to_link
    files = []
    files.extend(c_outputs.objects)
    files.extend(c_outputs.pic_objects)
    files.append(library.pic_static_library)
    files.append(library.static_library)
    files.append(library.dynamic_library)
    files = [f for f in files if f != None]

    return [DefaultInfo(files = depset(files)),
        CcInfo(compilation_context = c_context, linking_context = l_context),
        instrumented]


def _cc_bin_impl(ctx):
    cc_toolchain = find_cpp_toolchain(ctx)
    feature_configuration = cc_common.configure_features(
        ctx = ctx,
        cc_toolchain = cc_toolchain,
        requested_features = ctx.features,
        unsupported_features = ctx.disabled_features,
    )

    c_contexts = []
    l_contexts = []
    for dep in ctx.attr.deps:
        if CcInfo in dep:
            c_contexts.append(dep[CcInfo].compilation_context)
            l_contexts.append(dep[CcInfo].linking_context)

    c_context, c_outputs = cc_common.compile(
        name = ctx.label.name,
        actions = ctx.actions,
        feature_configuration = feature_configuration,
        cc_toolchain = cc_toolchain,
        srcs = ctx.files.srcs,
        compilation_contexts = c_contexts,
    )

    malloc = ctx.attr.malloc
    l_contexts.append(malloc[CcInfo].linking_context)

    l_outputs = cc_common.link(
        name = ctx.label.name,
        actions = ctx.actions,
        feature_configuration = feature_configuration,
        cc_toolchain = cc_toolchain,
        language = "c++",
        compilation_outputs = c_outputs,
        linking_contexts = l_contexts,
        output_type = "executable",
    )

    files = []
    files.append(l_outputs.executable)
    return [
        DefaultInfo(
            files = depset(files),
            executable = l_outputs.executable,
            runfiles = ctx.runfiles(files = ctx.files.data),
        ),
    ]


def _cc_test_impl(ctx):
    cc_toolchain = find_cpp_toolchain(ctx)
    feature_configuration = cc_common.configure_features(
        ctx = ctx,
        cc_toolchain = cc_toolchain,
        requested_features = ctx.features,
        unsupported_features = ctx.disabled_features,
    )

    c_contexts = []
    l_contexts = []
    for dep in ctx.attr.deps:
        if CcInfo in dep:
            c_contexts.append(dep[CcInfo].compilation_context)
            l_contexts.append(dep[CcInfo].linking_context)

    c_context, c_outputs = cc_common.compile(
        name = ctx.label.name,
        actions = ctx.actions,
        feature_configuration = feature_configuration,
        cc_toolchain = cc_toolchain,
        srcs = ctx.files.srcs,
        compilation_contexts = c_contexts,
    )

    malloc = ctx.attr.malloc
    l_contexts.append(malloc[CcInfo].linking_context)

    l_outputs = cc_common.link(
        name = ctx.label.name,
        actions = ctx.actions,
        feature_configuration = feature_configuration,
        cc_toolchain = cc_toolchain,
        language = "c++",
        compilation_outputs = c_outputs,
        linking_contexts = l_contexts,
        output_type = "executable",
    )

    instrumented = coverage_common.instrumented_files_info(
        ctx,
        source_attributes = ["srcs", "hdrs"],
        dependency_attributes = ["deps", "data"],
        extensions = None,
    )

    files = []
    files.append(l_outputs.executable)
    return [
        DefaultInfo(
            files = depset(files),
            executable = l_outputs.executable,
            runfiles = ctx.runfiles(files = ctx.files.data),
        ),
        instrumented,
    ]


cc_lib = rule(
    implementation = _cc_lib_impl,
    attrs = {
        "hdrs": attr.label_list(allow_files = [".h"]),
        "srcs": attr.label_list(allow_files = [".cc"]),
        "deps": attr.label_list(
            allow_empty=True,
            providers = [CcInfo]
        ),
        "_cc_toolchain": attr.label(default = "@bazel_tools//tools/cpp:current_cc_toolchain"),
    },
    fragments = ["cpp"],
)


cc_bin = rule(
    implementation = _cc_bin_impl,
    executable = True,
    attrs = {
        "srcs": attr.label_list(
            allow_files=[".cc", ".h"]
        ),
        "deps": attr.label_list(
            allow_empty=True,
            providers = [CcInfo]
        ),
        "data": attr.label_list(
            allow_files = True,
            default = []
        ),
        "_cc_toolchain": attr.label(default = "@bazel_tools//tools/cpp:current_cc_toolchain"),
        "malloc": attr.label(default = "@bazel_tools//tools/cpp:malloc", providers = [CcInfo]),
        },
    fragments = ["cpp"],
)


test_cc_test = rule(
    implementation = _cc_test_impl,
    test = True,
    attrs = {
        "srcs": attr.label_list(
            allow_files=[".cc", ".h"]
        ),
        "deps": attr.label_list(
            allow_empty=True,
            providers = [CcInfo]
        ),
        "data": attr.label_list(
            allow_files = True,
            default = []
        ),
        "_cc_toolchain": attr.label(default = "@bazel_tools//tools/cpp:current_cc_toolchain"),
        "malloc": attr.label(default = "@bazel_tools//tools/cpp:malloc", providers = [CcInfo]),
        #"_lcov_merger": attr.label(default = "@bazel_tools//tools/test:lcov_merger", executable = True, cfg = "host"),
        #"_collect_cc_coverage": attr.label(default = "@bazel_tools//tools/test:collect_cc_coverage", executable = True, cfg = "host"),
        "_lcov_merger": attr.label(default = "//coverage:gcov_coverage", executable = True, cfg = "host"),
        },
    fragments = ["cpp"],
)
