/**********************************************************************************
*
* Given two sorted integer arrays A and B, merge B into A as one sorted array.
*
* Note:
*   You may assume that A has enough space (size that is greater or equal to m + n)
*   to hold additional elements from B. The number of elements initialized in A and B
*   are m and n respectively.
*
**********************************************************************************/

#include <stdio.h>

void merge(int A[], int m, int B[], int n) {
    int ia = m-1 ;
    int ib = n-1 ;
    int i = m + n - 1;
    for (int i=m+n-1; i>=0; i--){

        if (ia>=0 && ib<0){
            break;
        }
        if (ia<0 && ib>=0){
            A[i] = B[ib--];
            continue;
        }
        if (ia>=0 && ib>=0){
            if (A[ia] > B[ib]){
                A[i] = A[ia--];
            }else{
                A[i] = B[ib--];
            }
        }

    }
}

