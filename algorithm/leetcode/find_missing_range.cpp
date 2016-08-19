/**********************************************************************************
 *
 * Given a sorted integer array where the range of elements are [lower, upper] inclusive,
 * return its missing ranges.
 *
 * For example, given [0, 1, 3, 50, 75], lower = 0 and upper = 99,
 * return ["2", "4->49", "51->74", "76->99"].
 *
 **********************************************************************************/

#include <stdlib.h>
#include <iostream>
#include <sstream>
#include <string>
#include <vector>
#include <algorithm>
#include <iterator>
using namespace std;


string& makeRange(int lo, int hi){
    static string result;
    result="";
    stringstream ss;
    if (lo != hi){
        ss << lo << "->" << hi;
    }else{
        ss << lo;
    }
    ss >> result;
    return result;
}


vector<string> findMissingRanges(int A[], int n, int lower, int upper) {

    vector<string> result;

    if ( n<=0 ) {
        result.push_back(makeRange(lower, upper));
        return result;
    }

    if (lower < A[0]){
        result.push_back(makeRange(lower, A[0]-1 < upper ? A[0]-1 : upper));
    }

    for(int i=0; i<n-1; i++){
        if ( A[i] + 1 == A[i+1] ) {
            continue;
        }
        result.push_back(makeRange(A[i]+1, A[i+1]-1));
    }

    if (upper > A[n-1]){
        result.push_back(makeRange(A[n-1]+1, upper));
    }

    return result;
}


