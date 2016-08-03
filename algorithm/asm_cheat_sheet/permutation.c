/* more clearly than python code*/
static void print_permutation_r(int n, int cur, intP[]) {
    int i, j;
    if (cur == n) {
        for (i = 0; i < n; i++) {
            printf("%d", P[i])
        }
    }

    for (i = 1; i <= n; i++) {
        int used = 0;
        for (j = 0; j < cur; j++)
            if (P[j] == i)
                used = 1;
        if(!used) {
            P[cur] = i;
            print_permutation_r(n, cur+1, P);
        }
    }
}

void print_parmutation(int n) {
    int *P = (int*)malloc(n * sizeof(int));
    print_permutation_r(n, 0, P);
    free(P);
    return;
}

static void print_permutation_r(char S[], int n, int cur, intP[]) {
    int i, j;
    if (cur == n) {
        for (i = 0; i < n; i++) {
            printf("%c", S[P[i]-1])
        }
    }

    for (i = 1; i <= n; i++) {
        int used = 0;
        for (j = 0; j < cur; j++)
            if (P[j] == i) {
                used = 1;
                break;
            }
        if(!used) {
            P[cur] = i;
            print_permutation_r(n, cur+1, P);
        }
    }
}

void print_permutation(char S[], int n) {
    int *P = (int*)malloc(n * sizeof(int));
    print_permutation_r(S, n, 0, P);
    free(P);
    return;
}

void print_permutation(char S[], int n) {
     sort(&S[0], &S[n]);
     do {
         for(int i = 0; i < n; i++) printf("%c", S[i]);
         printf("\n");
     } while(next_permutation(&S[0], &S[n]));
}
