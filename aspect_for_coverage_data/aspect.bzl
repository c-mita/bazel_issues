def _coverage_aspect_impl(target, ctx):
    print(ctx)
    coverage_files = [
        f
        for a in target.actions if a.mnemonic == "TestRunner"
        for f in a.outputs.to_list() if f.basename == "coverage.dat"
    ]
    processed = []
    for file in coverage_files:
        out = ctx.actions.declare_file("%s_%s.proc" % (target.label.name, file.basename))
        args = ctx.actions.args()
        args.add(out)
        args.add(file)
        ctx.actions.run(
            outputs = [out],
            inputs = [file],
            executable = ctx.executable._tool,
            arguments = [args],
        )
        processed.append(out)
    return [OutputGroupInfo(
        coverage_files = depset(coverage_files),
        processed_files = depset(processed),
    )]

coverage_aspect = aspect(
    implementation = _coverage_aspect_impl,
    attrs = {
        "_tool": attr.label(
            default = "//:tool",
            cfg = "exec",
            executable = True,
        ),
    },
)
