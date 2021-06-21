#include <jni.h>
#include "Foo.h"
#include "foo.h"

JNIEXPORT jint JNICALL Java_Foo_calcNativeFoo(JNIEnv *env, jclass class_object, jint n) {
  return calc_foo((int) n);
}
