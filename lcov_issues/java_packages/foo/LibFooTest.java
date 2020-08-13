import static foo.LibFoo.doFoo;
import static org.junit.Assert.*;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.JUnit4;

@RunWith(JUnit4.class)
public final class LibFooTest {
  @Test
  public void testPositive() throws Exception {
    assertEquals(7, doFoo(6));
    assertEquals(9, doFoo(9));
  }

  @Test
  public void testNegative() throws Exception {
    assertEquals(14, doFoo(-7));
  }

  @Test
  public void testZero() {
    assertEquals(0, doFoo(0));
  }
}
