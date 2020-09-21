# Branch merge problem

## Setup
Enable C++ coverage information in bazel by adding "-b" to the gcov line in bazel's collect_cc_coverage.sh script
and build a fresh bazel binary. Use this binary for the following.

## Repro
```
bazel coverage --instrumentation_filter="lib" --combined_report=lcov //branch_merge:foo_test //branch_merge:bar_test //branch_merge:baz_test
```
This should fail on the coverage merging step with "IncompatibleMergeException".

## Explanation
The `coverage.dat` files produced by "foo_test", "bar_test" and "baz_test" all report different branch information
for the file "/branch_coverage/lib.h" due to the way templates are expanded.

* `lib` defines one templated function that contains a single branch.
* `foo` instantiates the function with `int`, so produces a coverage.dat file with only two "BRDA" lines.
* `bar` instantiates the function with a struct, producing multiple branches for constructor calls and exception handling.
* `baz` instantiates the function twice, once with `int` and the same struct; the coverage.dat file has the branch information from `foo` followed by the information from `bar` (including duplicated block and branch numbers).

The coverage merge tool cannot handle differing branch information for a single line and assumes something has gone wrong.
