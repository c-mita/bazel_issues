# Protobuf compiler
There are complaints the protobuf compiler needs to be compiled too frequently
under Bazel. (e.g. https://github.com/bazelbuild/bazel/issues/7095)


## Multiple protoc's built (18.05.21)

One reproducible issue is that multiple protobuf compilers are needed for some
language rules.
```
$ bazel build //proto:msg_cc_proto
# protocol buffer compiler is built

$ bazel build //proto:msg_py_proto
# protocol buffer compiler is built again
```

In particular, `java_proto_library` appears to need two copies of the protobuf
compiler:
```
$ bazel aquery 'outputs(".*protoc", deps(//proto:msg_java_proto))' --include_aspects
# Two CppLinkActions for protoc
```

One of these matches the protoc used for `msc_cc_proto`, the other is being
built for the host configuration.

Looks to be caused by use of `cfg = "host"` in internal rules in protobuf
itself: https://github.com/protocolbuffers/protobuf/blob/bc45f92262a8e0e6e1ab7302c72a380eb0346f8e/protobuf.bzl#L381
