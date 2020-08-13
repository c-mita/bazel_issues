import static org.junit.Assert.*;
import static bar.LibBar.doBar;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.JUnit4;


@RunWith(JUnit4.class)
public final class LibBarTest {

  @Test
  public void testPositives() {
    assertEquals(14, doBar(5, 10));
    assertEquals(4, doBar(6, 3));
  }

}
