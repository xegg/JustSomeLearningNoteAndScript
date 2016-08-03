void print_subset(int *S, int n, int *P, int cur, int ed) {
    int i, j;
    for (i = ed; i < n; i++) {
        P[cur] = S[i];
        for (j = 0; j <= cur; j++) printf("%d", P[j]);
        printf("\n");
        print_subset1(S, n, P, cur+1, i+1);
    }
}

void print_subset2(int *S, int n, char *B, int cur) {
    int i;
    if (cur == n) {
        for (i = 0; i < n; i++) if (B[i]) printf("%d", S[i]);
        printf("\n");
        return;
    }
    B[cur] = 1;
    print_subset2(S, n, B, cur+1);
    B[cur] = 0;
    print_subset2(S, n, B, cur+1);
}

void print_subset3(int *S, int n) {
    int i, j;
    for (i = 1; i < (1 << n); i++) {
        for (j = 0, j < n; j++)
            if (i & (i << j)) printf("%d", S[j])
    }
}
