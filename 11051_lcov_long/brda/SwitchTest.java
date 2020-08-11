import static org.junit.Assert.*;
import org.junit.Test;

public class SwitchTest {
    @Test
    public void testValue73() throws Exception {
        int v = Lib.bar(73);
        assertEquals(57, v);
    }

    @Test
    public void testValue22() throws Exception {
        int v = Lib.bar(22);
        assertEquals(44, v);
    }

    @Test
    public void testValue19() throws Exception {
        int v = Lib.bar(19);
        assertEquals(38, v);
    }


}
