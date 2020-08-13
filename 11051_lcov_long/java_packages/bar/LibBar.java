package bar;

import foo.LibFoo;

public class LibBar {

  private LibBar() {
  }

  public static int doBar(int x, int y) {
    return LibFoo.doFoo(x) ^ LibFoo.doFoo(y);
  }

}
