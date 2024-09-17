void foo() {
    int sum = 0;
    for (int i = 0; i < 10; ++i) {
        for (int j = 0; j < 20; ++j) {
            for (int k = 0; k < 20; ++k) {
                sum += k;
            }
        }
        for (int n = 0; n < 10; ++n) {
            sum += n;
        }
    }

    int h = 99;
    int b = h*h;
}