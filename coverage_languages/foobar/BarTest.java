import static org.junit.Assert.*;
import org.junit.Test;

public class BarTest {
  @Test
  public void testZero() throws Exception {
    Bar bar = new Bar(0);
    assertEquals(0, bar.calculateBar());
    assertEquals(2, bar.calculateBar());
    assertEquals(4, bar.calculateBar());
  }
}
