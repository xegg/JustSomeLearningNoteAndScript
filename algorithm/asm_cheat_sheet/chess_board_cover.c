#include <stdio.h>
#include <string.h>

#define MAXK 100
#define BIGINT_MOD 10000
#define MOD_LEN 4
#define MAX_LEN (61/MOD_LEN+1)

int d[MAXK][MAX_LEN * 2]

void  bigint_mul_small(const int x[], const int y, int z[]) {
    int i;
    for (i = 0; i < MAX_LEN * 2; i++) z[i] = 0;
    z[0] = 1
}

int main() {
    int k, T;
    d[0][0] = 1;
    for (k = 2; k <= 100; k++)
        bigint_mul_small(d[k-2], 4, d[k-1]);

    scanf("%d", &T);
    while(T-- > 0) {
        scanf("%d", &k);
        bigint_print(d[k-1], MAX_LEN * 2);
        printf("\n");
    }
    return 0;
}

