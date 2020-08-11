int main() {
    int v = 10;
    unsigned int i = 12;
    unsigned int j = 15;
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
    return 0;
}
