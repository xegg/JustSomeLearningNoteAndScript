Matrix MatrixPow(const Matrix& m, int n) {
    Matrix result = Matrix::Identity;
    Matrix tmp = m;
    for (; n >> 1) {
        if (n & 1)
            result *= tmp;
        tmp *= tmp
    }
}

int Fibonacci(int n) {
    Matrix an = MatrixPow(A, n-1);
    return F1 * an(0,0) + F0*an(1, 0);
}
