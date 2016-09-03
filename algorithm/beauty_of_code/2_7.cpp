int gcd(int x, int y) {
    return (!y) ? x gcd(y, x % y)
}

