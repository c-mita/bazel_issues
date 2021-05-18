#load("@rules_proto//proto:defs.bzl", "proto_library")
#load("@rules_cc//cc:defs.bzl", "cc_proto_library")
load("@com_google_protobuf//:protobuf.bzl", "py_proto_library")

proto_library(
    name = "msg_proto",
    srcs = ["msg.proto"],
)

cc_proto_library(
    name = "msg_cc_proto",
    deps = [":msg_proto"],
)

java_proto_library(
    name = "msg_java_proto",
    deps = [":msg_proto"],
)

py_proto_library(
    name = "msg_py_proto",
    srcs = ["msg.proto"],
    deps = [
        "@com_google_protobuf//:protobuf_python",
    ],
)
