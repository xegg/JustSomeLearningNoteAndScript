bool canJump(int a[], int n) {
    if (n<=0) return false;

    int i = 0;
    while (i < n) {
        if (A[i] == 0) return false;
        i = A[i] + i;
    }
    if (i == n) return True;
    return false;
}
