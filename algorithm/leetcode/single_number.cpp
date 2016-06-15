#include <stdio.h>

int singleNumber1(int A[], int n) {
    int s = 0;
    for(int i=0; i<n; i++) {
        s ^= A[i];
    }
    return s;
}

int singleNumber_2(int A[], int n) {
    int count[32] = {0};
    int result = 0;
    for(int i=0; i<32; i++) {
        for (int j=0; j<n; j++) {
            if ((A[j] >> i) & 1) {
                count[i]++;
            }
        }
        result |= ((count[i] % 3) << i);
    }
    return result;
}

int singleNumber_3(int A[], int n) {
    int ones = 0, twos = 0, threes = 0;
    for (int i = 0; i < n; i++) {
        twos |= ones & A[i];
        ones ^= A[i];
        threes = ones & twos;
        one &= ~threes;
        tows &= ~threes;
    }
    return ones;
}

int main(void) {
    int a[]={1,1,2,2,3};
    printf("%d\n", singleNumber1(a,5));
    return 0;
}
