py_binary(
    name = "covgen",
    srcs = ["covgen.py"],
)

filegroup(
    name = "cov",
    srcs = ["covgen.sh"],
    data = [":covgen"],
)
