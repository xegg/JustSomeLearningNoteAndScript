
/**********************************************************************************
*
* Given a collection of numbers, return all possible permutations.
*
* For example,
* [1,2,3] have the following permutations:
* [1,2,3], [1,3,2], [2,1,3], [2,3,1], [3,1,2], and [3,2,1].
*
*
**********************************************************************************/

#include <stdio.h>
#include <stdlib.h>
#include <iostream>
#include <vector>
using namespace std;

/*
{ 1 2 3 }
{ 2 1 3 }
{ 3 2 1 }
{ 1 3 2 }
{ 2 3 1 }
{ 3 1 2 }
*/

/*
 *    The algroithm - Take each element in array to the first place.
 *
 *    For example:
 *
 *         0) initalization
 *
 *             pos = 0
 *             [1, 2, 3]
 *
 *         1) take each element into the first place,
 *
 *             pos = 1
 *             [1, 2, 3]  ==>  [2, 1, 3] , [3, 1, 2]
 *
 *             then we have total 3 answers
 *             [1, 2, 3],  [2, 1, 3] , [3, 1, 2]
 *
 *         2) take each element into the "first place" -- pos
 *
 *             pos = 2
 *             [1, 2, 3]  ==>  [1, 3, 2]
 *             [2, 1, 3]  ==>  [2, 3, 1]
 *             [3, 1, 2]  ==>  [3, 2, 1]
 *
 *             then we have total 6 answers
 *             [1, 2, 3],  [2, 1, 3] , [3, 1, 2], [1, 3, 2], [2, 3, 1], [3, 2, 1]
 *
 *          3) pos = 3 which greater than length of array, return.
 *
 */
vector<vector<int> > permute(vector<int> &num) {

    vector<vector<int> > vv;
    vv.push_back(num);

    if (num.size() <2){
        return vv;
    }

    int pos=0;
    while(pos<num.size()-1){
        int size = vv.size();
        for(int i=0; i<size; i++){
            //take each number to the first place
            for (int j=pos+1; j<vv[i].size(); j++) {
                vector<int> v = vv[i];
                int t = v[j];
                v[j] = v[pos];
                v[pos] = t;
                vv.push_back(v);
            }
        }
        pos++;
    }
    return vv;
}

/**********************************************************************************
*
* Given a collection of numbers that might contain duplicates, return all possible unique permutations.
*
* For example,
* [1,1,2] have the following unique permutations:
* [1,1,2], [1,2,1], and [2,1,1].
*
*
**********************************************************************************/


// To deal with the duplication number, we need do those modifications:
//    1) sort the array [pos..n].
//    2) skip the same number.
vector<vector<int> > permute(vector<int> &num) {

    vector<vector<int> > vv;
    vv.push_back(num);

    if (num.size() <2){
        return vv;
    }

    int pos=0;
    while(pos<num.size()-1){
        int size = vv.size();
        for(int i=0; i<size; i++){
            //sort the array, so that the same number will be together
            sort(vv[i].begin()+pos, vv[i].end());
            //take each number to the first
            for (int j=pos+1; j<vv[i].size(); j++) {
                vector<int> v = vv[i];
                //skip the same number
                if (j>0 && v[j]==v[j-1]){
                    continue;
                }
                int t = v[j];
                v[j] = v[pos];
                v[pos] = t;
                vv.push_back(v);
            }
        }
        pos++;
    }
    return vv;
}
