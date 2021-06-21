final class Foo {

  static {
    System.loadLibrary("foo-jni");
  }

  private Foo() {};

  public static int calculateFoo(int n) {
    if (n == 0) {
      return 0;
    }
    return calcNativeFoo(n);
  }

  private static native int calcNativeFoo(int n);
}
