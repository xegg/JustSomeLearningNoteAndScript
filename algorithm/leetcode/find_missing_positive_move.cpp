/**********************************************************************************
*
* Given an unsorted integer array, find the first missing positive integer.
*
* For example,
* Given [1,2,0] return 3,
* and [3,4,-1,1] return 2.
*
* Your algorithm should run in O(n) time and uses constant space.
*
*
**********************************************************************************/
#include <stdlib.h>
#include <time.h>
#include <iostream>
#include <map>
using namespace std;

#define INT_MAX      2147483647

/*
 *  Idea:
 *
 *    We can move the num to the place whcih the index is the num.
 *
 *    for example,  (considering the array is zero-based.
 *       1 => A[0], 2 => A[1], 3=>A[2]
 *
 *    Then, we can go through the array check the i+1 == A[i], if not ,just return i+1;
 *
 *    This solution comes from StackOverflow.com
 *    http://stackoverflow.com/questions/1586858/find-the-smallest-integer-not-in-a-list
*/
int firstMissingPositive_move(int A[], int n) {
    if (n<=0) return 1;
    int num;
    for(int i=0; i<n; i++) {
        num = A[i];
        while (num>0 && num<n && A[num-1]!=num) {
            swap(A[i], A[num-1]);
            num = A[i];
        }
    }
    for (int i=0; i<n; i++){
        if (i+1 != A[i]){
            return i+1;
        }
    }
    return n+1;
}

