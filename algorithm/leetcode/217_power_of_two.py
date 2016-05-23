bool isPowerOfTwo02(int n) {
    return n<=0 ? false : (n & (n-1)) == 0;
}

bool isPowerOfTwo01(int n) {
    int cnt = 0; //num of bits 1
    for(; n>0; n>>=1){
        if ( n & 1 ) {
            cnt++;
            if (cnt>1) return false;
        }
    }
    return cnt==1;
}
