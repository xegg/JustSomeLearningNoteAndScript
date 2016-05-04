#include <stdio.h>
#include "base.h"

/*void ror1(int array[], int n, int k) {*/
    /*int i;*/
    /*int *B = (int*) malloc(n * sizeof(int));*/
    /*k %= n;*/
    /*if (k == 0)*/
        /*return;*/
    /*for(i = 0; i < n; i++) {*/
        /*B[i+k] % n] = array[i];*/
    /*}*/
    /*for (i=0; i < n; i++) {*/
        /*array[i] = B[i];*/
    /*}*/
/*}*/

/*void ror2(int array[], int n, int k) {*/
    /*int i, tmp;*/
    /*k %= n;*/
    /*if (k == 0)*/
        /*return;*/
    /*while(k--) {*/
        /*tmp = array[n-1];*/
        /*for (i = n -1; i > 0; i--) {*/
            /*array[i] = array[i - 1];*/
        /*}*/
        /*array[0] = tmp;*/
    /*}*/
/*}*/

/*void ror3(int *array, int n, int k) {*/
    /*k %= n;*/
    /*if (k == 0)*/
        /*return;*/

    /*reverse(array, 0, n);*/
    /*reverse(array, 0, k);*/
    /*reverse(array, k, n-k);*/
/*}*/
/*# WARNING*/
void ror4(int *array, int n, int k) {
     int i;
     const int g = gcd(n, k);
     k %= n;

     if (k == 0) return;
     for (i = 0; i < g; ++i) {
          int j = i;
          int cur = array[j], tmp;
          do {
               tmp = array[(j + k) % n];
               array[(j + k) % n] = cur;
               cur = tmp;
               j = (j + k) % n;
          } while ( j != i );
     }
}

int main(void) {
     int i;
     int a[] = {1,2,3,4,5};
     ror4(a, 5, 3);
     for (i = 0; i < 5; i ++) {
          printf("%d", a[i]);
     }
     return 0;
}
