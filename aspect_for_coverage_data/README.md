# Reading coverage.dat output from the test runner

It's possible to attach an aspect onto test targets from the command
line that inspect the TestRunner action and grab the coverage.dat output.

This can then be acted on as any other file. The example aspect creates
an action to produce a new file and forwards this output to an output group.

This is all fine, if a bit weird, when running with `bazel coverage`.

However, if run with `bazel build`, and the test target fails, Bazel will crash.
```
FATAL: bazel crashed due to an internal error. Printing stack trace:
java.lang.RuntimeException: Unrecoverable error while evaluating node...

...

Caused by: java.lang.NullPointerException: Cannot read field "printRelativeTestLogPaths" because "this.testSummaryOptions" is null
        at com.google.devtools.build.lib.analysis.test.TestStrategy.processTestOutput(TestStrategy.java:388)
        at com.google.devtools.build.lib.exec.StandaloneTestStrategy.processTestAttempt(StandaloneTestStrategy.java:286)
        at com.google.devtools.build.lib.exec.StandaloneTestStrategy.finalizeTest(StandaloneTestStrategy.java:211)
        at com.google.devtools.build.lib.exec.StandaloneTestStrategy$StandaloneTestRunnerSpawn.finalizeTest(StandaloneTestStrategy.java:594)
        at com.google.devtools.build.lib.analysis.test.TestRunnerAction.executeAllAttempts(TestRunnerAction.java:1251)
        at com.google.devtools.build.lib.analysis.test.TestRunnerAction.execute(TestRunnerAction.java:1028)
        at com.google.devtools.build.lib.analysis.test.TestRunnerAction.execute(TestRunnerAction.java:999)
```

This is clearly bad and shouldn't happen. Even though this is very unexpeted
usage, Bazel should not crash.
