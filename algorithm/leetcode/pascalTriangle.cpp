/**********************************************************************************
*
* Given numRows, generate the first numRows of Pascal's triangle.
*
* For example, given numRows = 5,
* Return
*
* [
*      [1],
*     [1,1],
*    [1,2,1],
*   [1,3,3,1],
*  [1,4,6,4,1]
* ]
*
*
**********************************************************************************/

#include <stdlib.h>
#include <vector>
#include <iostream>
using namespace std;

vector<vector<int> > generate(int numRows)
{
    vector<vector<int> > pascalTriangle;
    for (int i=0; i<numRows; i++){
        vector<int> v;
        if (i==0){
            v.push_back(1);
        } else {
            v.push_back(1);
            for(int j=0; j<pascalTriangle[i-1].size()-1; j++){
                v.push_back(pascalTriangle[i-1][j] + pascalTriangle[i-1][j+1]);
            }
            v.push_back(1);
        }
        pascalTriangle.push_back(v);
    }
    return pascalTriangle;
}
