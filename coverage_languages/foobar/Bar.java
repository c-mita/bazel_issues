final class Bar {

  private int current;

  public Bar(int start) {
    int current = start;
  }

  public int calculateBar() {
    int r = Foo.calculateFoo(current);
    current += 1;
    return r;
  }
}
