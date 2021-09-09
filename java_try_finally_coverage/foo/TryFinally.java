public final class TryFinally {

    public static int secret = 0;

    public static int runFinally(int x) {
      try {
        if (x == 1 || x == -1) {
          throw new IllegalStateException();
        }
        if (x % 2 == 0) {
          return x * 2;
        } else {
          return x * 2 - 1;
        }
      } finally {
        if (x >= 0) {
          secret++;
        } else {
          secret--;
        }
      }
    }
}
