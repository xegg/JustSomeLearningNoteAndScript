/**********************************************************************************
*
* Given a matrix of m x n elements (m rows, n columns), return all elements of the matrix in spiral order.
*
* For example,
* Given the following matrix:
*
* [
*  [ 1, 2, 3 ],
*  [ 4, 5, 6 ],
*  [ 7, 8, 9 ]
* ]
*
* You should return [1,2,3,6,9,8,7,4,5].
*
*
**********************************************************************************/

#include <stdio.h>
#include <stdlib.h>
#include <iostream>
#include <vector>
using namespace std;

vector<int> spiralOrder(vector<vector<int> > &matrix) {
    vector <int> v;
    int row = matrix.size();
    if (row<=0) return v;
    int col = matrix[0].size();
    if (col<=0) return v;
    int r, c;
    for (r=0, c=0; r<(row+1)/2 && c<(col+1)/2; r++, c++){
        //top
        for(int i=c; i<col-c; i++){
            v.push_back(matrix[r][i]);
        }
        //right
        for(int i=r+1; i<row-r; i++){
            v.push_back(matrix[i][col-c-1]);
        }
        //bottom
        for(int i=col-c-2; row-r-1>r && i>=c; i--){
            v.push_back(matrix[row-r-1][i]);
        }
        //left
        for(int i=row-r-2; col-c-1>c && i>r; i--){
            v.push_back(matrix[i][c]);
        }

    }
    return v;
}

/**********************************************************************************
*
* Given an integer n, generate a square matrix filled with elements from 1 to n2 in spiral order.
*
* For example,
* Given n = 3,
*
* You should return the following matrix:
*
* [
*  [ 1, 2, 3 ],
*  [ 8, 9, 4 ],
*  [ 7, 6, 5 ]
* ]
*
*
**********************************************************************************/

#include <stdio.h>
#include <stdlib.h>
#include <iostream>
#include <vector>
using namespace std;

vector<vector<int> > generateMatrix(int n, int m);

vector<vector<int> > generateMatrix(int n) {
    return generateMatrix(n, n);
}

vector<vector<int> > generateMatrix(int n, int m) {
    vector< vector <int> > matrix(n);
    if (n<=0) return matrix;
    for(int i=0; i<n; i++){
        vector<int> v(m);
        matrix[i] = v;
    }

    int row=n, col=m;
    int r, c;
    int cnt=1;
    for (r=0, c=0; r<(row+1)/2 && c<(col+1)/2; r++, c++){
        //top
        for(int i=c; i<col-c; i++){
            matrix[r][i] = cnt++;
        }
        //right
        for(int i=r+1; i<row-r; i++){
            matrix[i][col-c-1] = cnt++;
        }
        //bottom
        for(int i=col-c-2; row-r-1>r && i>=c; i--){
            matrix[row-r-1][i] = cnt++;
        }
        //left
        for(int i=row-r-2; col-c-1>c && i>r; i--){
            matrix[i][c] = cnt++;
        }

    }
    return matrix;
}
