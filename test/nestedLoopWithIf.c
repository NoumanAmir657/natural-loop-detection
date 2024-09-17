void foo() {
    int sum = 0;
    for (int i = 0; i < 10; ++i) {
        for (int j = 0; j < 20; ++j) {
            sum += i + j;
            if (sum == 10) {
                sum = sum + 77;
            }
            else {
                sum = sum - 77;
            }
        }
    }
}