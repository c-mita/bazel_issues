package foo;

public class LibFoo {

  private LibFoo() {
  }

  public static int doFoo(int x) {
    if (x == 0) return 0;
    else if (x > 0) return 2 * (x / 2) + 1;
    else return x * -2;
  }

}
