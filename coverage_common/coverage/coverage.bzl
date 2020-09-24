def find_cpp_toolchain(ctx):
    if hasattr(cc_common, "is_cc_toolchain_resolution_enabled_do_not_use") and cc_common.is_cc_toolchain_resolution_enabled_do_not_use(ctx = ctx):
        if "@bazel_tools//tools/cpp:toolchain_type" in ctx.toolchains:
            return ctx.toolchains["@bazel_tools//tools/cpp:toolchain_type"]
        fail("In order to use find_cpp_toolchain, you must include the '@bazel_tools//tools/cpp:toolchain_type' in the toolchains argument to your rule.")

    if hasattr(ctx.attr, "_cc_toolchain"):
        return ctx.attr._cc_toolchain[cc_common.CcToolchainInfo]
    fail("In order to use find_cpp_toolchain, you must define the '_cc_toolchain' attribute on your rule or aspect.")


def _gcov_coverage_impl(ctx):
    cc_toolchain = find_cpp_toolchain(ctx)
    script = ctx.files.script_file[0]
    lcov_exec = ctx.executable._converter_tool
    executable_script = ctx.actions.declare_file(ctx.label.name)

    # gcov_coverage's runfiles are not available when the coverage tool is run, so the normal trick doesn't work
    # lcov_path = "%s/%s/%s" % (executable_script.path + ".runfiles", ctx.workspace_name, lcov_exec.short_path)
    # the original exec path is available though, if it is default output
    lcov_path = lcov_exec.path

    # inject the path to the required tools into our source script
    sed_gcov = "s:%%GCOV_PATH_STRING%%:%s:" % cc_toolchain.gcov_executable
    sed_lcov = "s:%%LCOV_PATH_STRING%%:%s:" % lcov_path
    sed_command = "sed '%s; %s' %s > %s" % (sed_gcov, sed_lcov, script.path, executable_script.path)
    ctx.actions.run_shell(
        outputs = [executable_script],
        inputs = [script],
        command = sed_command,
    )

    runfiles = ctx.runfiles(
            files = [lcov_exec],
            transitive_files = ctx.attr._converter_tool[DefaultInfo].files,
        )
    runfiles = runfiles.merge(ctx.attr._converter_tool[DefaultInfo].default_runfiles)

    return [
        DefaultInfo(
            #files=ctx.attr._converter_tool[DefaultInfo].files,
            files = depset([lcov_exec]),
            runfiles=runfiles,
            executable=executable_script),
    ]


gcov_coverage = rule(
    implementation = _gcov_coverage_impl,
    executable = True,
    attrs = {
        "_cc_toolchain": attr.label(default = "@bazel_tools//tools/cpp:current_cc_toolchain"),
        "script_file": attr.label(allow_single_file = True),
        "_converter_tool": attr.label(default = "@bazel_tools//tools/test:lcov_merger", executable=True, cfg="host"),
    }
)
