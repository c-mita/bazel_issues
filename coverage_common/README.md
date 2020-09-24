# C++ Coverage in Starlark
An experiment to write C++ rules that allow coverage collection in Starlark with GCC and gcov.

## Goal
The idea is to replicate C++ code coverage in Starlark using only the "official" mechanisms,
as external rules would (if they were willing).

Success is _limited_.

For the purposes of this experiment, we consider the following as API:
 * The content of `coverage_common` (this is incomplete).
 * The `_lcov_merger` attribute on test rules, and the command line arguments passed
(this is completely undocumented).
 * `CcToolchain::gcov_executable` (this doesn't exist).

## Requirements
A version of bazel modified to expose gcov from the C++ toolchain
so the following works in the rule implementation:
```
cc_toolchain = find_cpp_toolchain(ctx)
gcov_path = cc_toolchain.gcov_executable
```

## Example
The following executes the test in `//foo/foo_test.cc`, producing a coverage report for `//foo/foo_lib.cc`
```
bazel coverage //foo:foo_mixed_test --combined_report=lcov
```

## Rules and Targets
Three C++ rules are implemented:
 * `cc_bin` (corresponding to `cc_binary`)
 * `cc_lib` (corresponding to `cc_library`)
 * `test_cc_test` (corresponding to `cc_test` - it's hard to abbreviate "cc_test" any further)

All three can be used together, and `cc_bin` can depened on a native `cc_library`, etc.

The three test target dependency chains are:
```
test_cc_test(//foo:foo_test) -> cc_lib(//foo:foo_lib)
test_cc_test(//foo:foo_mixed_test) -> cc_library(//foo:foo_native_lib)
cc_test(//foo:foo_native_test) -> cc_library(//foo:foo_native_lib)
```
Of these three, only `//foo:foo_mixed_test` will produce a coverage report.
This is due a deficiency in the InstrumentedFilesInfo API in Starlark,
whereby it is not possible to report built artifacts (e.g. `gcno` files)
in `InstrumentedFilesInfo::metadata_files`. We do not have any mechanism
to add to an `InstrumentedFilesInfo` provider, nor are the `gcno` files
exposed by anything in `cc_common`. We can, however, faithfully pass an
`InstrumentedFilesInfo` object from a dependency.

## Coverage generation
Test rules in Starlark must include an `_lcov_merger` attribute.
This points to a binary target that is called by bazel during a coverage run
after the test has executed. It is an "unofficial" requirement that this output
a "coverage.dat" file in the LCOV format.

Bazel includes an "lcov_merger" tool (`@bazel_tools//tools/test:lcov_merger`)
that is used by the native `cc_test` rule. This tool can convert gcov output
into an "lcov" file. Whilst the same tool is used later to merge all coverage
reports into a final coverage output, that is a distinct step and not relevant
here.

`cc_test` also includes a "special" `_collect_cc_coverage` attribute that points
to a special script (`collect_cc_coverage.sh` in bazel) that is invoked before
"lcov_merger" and is responsible for calling gcov. The `test_cc_test` rule attempts
to merge this step with the `lcov_merger` step.

`test_cc_test` therefore specifies the target `//coverage:gcov_coverage` in its
`_lcov_merger` attribute. This is target is the sole implementation of a custom
rule that does "stuff" to produce a shell script to call gcov followed by the
original `@bazel_tools//tools/test:lcov_merger`.

Complications arise due to the environment these tools are called in during test execution,
having a binary depend on another binary does not work exactly the same way as normal.
