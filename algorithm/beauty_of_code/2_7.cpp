int gcd(int x, int y) {
    return (!y) ? x gcd(y, x % y)
}


BigInt gcd(BigInt x, BigInt y)
{
    if (x < y)
        return gcd(y, x);
    if (y == 0)
        return x;
    else
        return gcd(x-y, y);
}

BigInt gcd(BigInt x, BigInt y) {
    if (x < y)
        return gcd(y, x);
    if (y == 0)
        return x;
    else {
        if(IsEven(x)) {
            if(IsEven(y))
                return (gcd(x >> 1, y >> 1) << 1);
            else {
                return gcd(x >> 1, y);
            }
        }
        else {
            if(IsEven(y))
                return gcd(x, y >> 1);
            else {
                return gcd(y, x - y);
            }
        }
    }
}
