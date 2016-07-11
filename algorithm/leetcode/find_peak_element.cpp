/**********************************************************************************
*
* A peak element is an element that is greater than its neighbors.
*
* Given an input array where num[i] ≠ num[i+1], find a peak element and return its index.
*
* You may imagine that num[-1] = num[n] = -∞.
*
* For example, in array [1, 2, 3, 1], 3 is a peak element and your function should return the index number 2.
*
* click to show spoilers.
*
* Note:
* Your solution should be in logarithmic complexity.
*
* Credits:Special thanks to @ts for adding this problem and creating all test cases.
*
**********************************************************************************/

#include <iostream>
#include <vector>
using namespace std;

int findPeakElement(const vector<int> &num) {

    int n = num.size();
    int low = 0;
    int high = n - 1;

    int mid = 0, v1, v2;

    while ( low < high ) {

        // Find the index of middle element
        mid = low + ( high - low ) / 2;

        // Compare middle element with its neighbours (if neighbours exist)
        if ( ( mid == 0 || num[mid] > num[mid-1] ) &&
                ( mid == n-1 ||  num[mid] > num[mid+1] )  ){
            return mid;
        }

        // If middle element is not peak and its left neighbor is greater than it
        // then left half must have a peak element
        if (mid >0 && num[mid-1] > num[mid]){
            high = mid - 1;
        // If middle element is not peak and its right neighbor is greater than it
        // then right half must have a peak element
        }else{
            low = mid + 1;
        }

    }

    return low;
}

