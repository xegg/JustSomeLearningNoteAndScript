ret = 0;
for(int i = 0; i <= N; i++) {
    j = i;
    while ( j % 5 == 0 ) {
        ret++;
        j /= 5;
    }
}

ret = 0;
while(N) {
    ret += N/5;
    N /= 5;
}

int lowestOne(int N) {
    int Ret = 0;
    while(N) {
        N >>= 1;
        Ret += N;
    }
}
