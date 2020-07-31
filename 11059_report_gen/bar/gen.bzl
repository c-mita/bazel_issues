def _src_gen_impl(ctx):
    src_files = ctx.files.srcs
    n = ctx.attr.number
    lower_name = ctx.attr.root_name.lower()
    upper_name = ctx.attr.root_name.upper()

    output_files = []
    for f in src_files:
        f_name = f.basename.replace("base", "%s_%d" % (lower_name, n))
        out_file = ctx.actions.declare_file(f_name)

        substitutions = {
            "BASENAME": "%s_%d" % (upper_name, n),
            "897643293": str(n),
            "THE_MAGIC_NUMBER": str(n),
            "basename": "%s_%d" % (lower_name, n),
        }
        sed_commands = []
        for target, replacement in substitutions.items():
            sed_commands.append("sed s=%s=%s=g" % (target, replacement))

        sed_string = " | ".join(sed_commands)

        command = "cat %s | %s > %s" % (f.path, sed_string, out_file.path)

        ctx.actions.run_shell(
            outputs = [out_file],
            inputs = [f],
            command = command,
            progress_message = "Generating %s_%d" % (lower_name, n),
        )
        output_files.append(out_file)

    return DefaultInfo(files=depset(output_files))


def generator(name, start_idx, end_idx):
    for i in range(start_idx, end_idx):
        src_gen(
            name = "%s_%d_src" % (name, i),
            srcs = ["base.cc"],
            number = i,
        )

        src_gen(
            name = "%s_%d_h" % (name, i),
            srcs = ["base.h"],
            number = i,
        )

        src_gen(
            name = "%s_%d_test_src" % (name, i),
            srcs = ["base_test.cc"],
            number = i,
        )

        native.cc_library(
            name = "%s_%d" % (name, i),
            srcs = [":%s_%d_src" % (name, i)],
            hdrs = [":%s_%d_h" % (name, i)],
        )

        native.cc_test(
            name = "%s_%d_test" % (name, i),
            srcs = [":%s_%d_test_src" % (name, i)],
            copts = ["-Iexternal/gtest/include"],
            deps = [":%s_%d" % (name, i), "@gtest//:main"],
        )


src_gen = rule(
    implementation = _src_gen_impl,
    attrs = {
        "root_name": attr.string(),
        "srcs": attr.label_list(allow_files=True),
        "number": attr.int(),
    }
)
