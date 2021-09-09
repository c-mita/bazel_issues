# Java try-finally coverage issues

The contents of finally blocks are duplicated for the different ways they can
be entered. This causes issues with Bazel's branch analysis which, at the time
of writing, does not handle this well.

In particular, due to the way branch propogation happens, this can cause
branches to be evaluated as having been "taken" when they haven't.
