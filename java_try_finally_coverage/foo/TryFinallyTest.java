import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertThrows;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.JUnit4;

@RunWith(JUnit4.class)
public final class TryFinallyTest {

    @Test
    public void testNegativeException() {
        assertThrows(IllegalStateException.class, () -> TryFinally.runFinally(-1));
    }
}
