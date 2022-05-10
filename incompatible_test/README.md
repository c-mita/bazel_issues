# Incompatible tests with coverage report

Reproduction for https://github.com/bazelbuild/bazel/issues/15385.

## Repro
```
bazel coverage --combined_report=lcov //:all
```
`good_test` should run, `bad_test` should be skipped, and a combined coverage
report generated.

Instead, the coverage run fails.

## Explanation
Incompatible targets do not have their rule logic run. This means they do not
setup an `InstrumentedFilesInfo` provider.
However, after
https://github.com/bazelbuild/bazel/commit/21179b2a82154b870ad8c5a7ad22b4662067cb29
added logic to add an `InstrumentedFilesInfo` if none was specified by the rule,
this was no longer true.

This confuses the coverage report builder logic a little, which leads to the
error.
