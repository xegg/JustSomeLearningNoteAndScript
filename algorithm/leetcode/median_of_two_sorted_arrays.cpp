/**********************************************************************************
*
* There are two sorted arrays A and B of size m and n respectively.
* Find the median of the two sorted arrays. The overall run time complexity should be O(log (m+n)).
*
**********************************************************************************/

#include <stdio.h>

// Classical binary search algorithm, but slightly different
// if cannot find the key, return the position where can insert the key
int binarySearch(int A[], int low, int high, int key){
    while(low<=high){
        int mid = low + (high - low)/2;
        if (key == A[mid]) return mid;
        if (key > A[mid]){
            low = mid + 1;
        }else {
            high = mid -1;
        }
    }
    return low;
}

//Notes:
// I feel the following methods is quite complicated, it should have a better high clear and readable solution
double findMedianSortedArrayHelper(int A[], int m, int B[], int n, int lowA, int highA, int lowB, int highB) {

    // Take the A[middle], search its position in B array
    int mid = lowA + (highA - lowA)/2;
    int pos = binarySearch(B, lowB, highB, A[mid]);
    int num = mid + pos;
    // If the A[middle] in B is B's middle place, then we can have the result
    if (num == (m+n)/2){
        // If two arrays total length is odd, just simply return the A[mid]
        // Why not return the B[pos] instead ?
        //   suppose A={ 1,3,5 } B={ 2,4 }, then mid=1, pos=1
        //   suppose A={ 3,5 }   B={1,2,4}, then mid=0, pos=2
        //   suppose A={ 1,3,4,5 }   B={2}, then mid=1, pos=1
        // You can see, the `pos` is the place A[mid] can be inserted, so return A[mid]
        if ((m+n)%2==1){
            return A[mid];
        }

        // If tow arrys total length is even, then we have to find the next one.
        int next;

        // If both `mid` and `pos` are not the first postion.
        // Then, find max(A[mid-1], B[pos-1]).
        // Because the `mid` is the second middle number, we need to find the first middle number
        // Be careful about the edge case
        if (mid>0 && pos>0){
            next = A[mid-1]>B[pos-1] ? A[mid-1] : B[pos-1];
        }else if(pos>0){
            next = B[pos-1];
        }else if(mid>0){
            next = A[mid-1];
        }

        return (A[mid] + next)/2.0;
    }
    // if A[mid] is in the left middle place of the whole two arrays
    //
    //         A(len=16)        B(len=10)
    //     [................] [...........]
    //            ^             ^
    //           mid=7         pos=1
    //
    //  move the `low` pointer to the "middle" position, do next iteration.
    if (num < (m+n)/2){
        lowA = mid + 1;
        lowB = pos;
        if ( highA - lowA > highB - lowB ) {
            return findMedianSortedArrayHelper(A, m, B, n, lowA, highA, lowB, highB);
        }
        return findMedianSortedArrayHelper(B, n, A, m, lowB, highB, lowA, highA);
    }
    // if A[mid] is in the right middle place of the whole two arrays
    if (num > (m+n)/2) {
        highA = mid - 1;
        highB = pos-1;
        if ( highA - lowA > highB - lowB ) {
            return findMedianSortedArrayHelper(A, m, B, n, lowA, highA, lowB, highB);
        }
        return findMedianSortedArrayHelper(B, n, A, m, lowB, highB, lowA, highA);
    }

}

double findMedianSortedArrays(int A[], int m, int B[], int n) {

    //checking the edge cases
    if ( m==0 && n==0 ) return 0.0;

    //if the length of array is odd, return the middle one
    //if the length of array is even, return the average of the middle two numbers
    if ( m==0 ) return n%2==1 ? B[n/2] : (B[n/2-1] + B[n/2])/2.0;
    if ( n==0 ) return m%2==1 ? A[m/2] : (A[m/2-1] + A[m/2])/2.0;


    //let the longer array be A, and the shoter array be B
    if ( m > n ){
        return findMedianSortedArrayHelper(A, m, B, n, 0, m-1, 0, n-1);
    }

    return findMedianSortedArrayHelper(B, n, A, m, 0, n-1, 0, m-1);
}

