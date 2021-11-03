int foo();

int bar(int x) {
  if (x >= 0) {
    return x * foo();
  } else {
    return (x / 2) * foo();
  }
}
