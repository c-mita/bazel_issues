import static org.junit.Assert.*;
import org.junit.Test;

public class BranchTest {
    @Test
    public void testTrue() throws Exception {
        assertEquals(11, Lib.foo(true, 10, 10));
    }

    @Test
    public void testFalse() throws Exception {
        assertEquals(97656250, Lib.foo(false, 10, 10));
    }

}
