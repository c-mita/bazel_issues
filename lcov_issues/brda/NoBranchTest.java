import static org.junit.Assert.*;
import org.junit.Test;

public class NoBranchTest {
    @Test
    public void testOnlyTrue() throws Exception {
        int v = Lib.foo(true, 0, 0);
        assertEquals(0, v);
    }
}
