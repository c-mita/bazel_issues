class Lib {

    private Lib() {};

    static public int foo(boolean v, int i, int j) {
        if (v) {
            while (i-- > 0) {
                j ^= i;
            }
            return j;
        } else {
            for (int k = 0; k < i; k++) {
                j *= i;
                j >>= 1;
            }
            return j;
        }
    }

    static public int bar(int i) {
        switch(i) {
            case 1:
                return 12;
            case 73:
                return 57;
            case -123:
                return 0x7FFFFFFF;
            default:
                return i * 2;
        }
    }

}
