/**********************************************************************************
 *
 * A robot is located at the top-left corner of a m x n grid (marked 'Start' in the diagram below).
 *
 * The robot can only move either down or right at any point in time. The robot is trying to reach
 * the bottom-right corner of the grid (marked 'Finish' in the diagram below).
 *
 *
 *    start                                                  
 *    +---------+----+----+----+----+----+
 *    |----|    |    |    |    |    |    |
 *    |----|    |    |    |    |    |    |
 *    +----------------------------------+
 *    |    |    |    |    |    |    |    |
 *    |    |    |    |    |    |    |    |
 *    +----------------------------------+
 *    |    |    |    |    |    |    |----|
 *    |    |    |    |    |    |    |----|
 *    +----+----+----+----+----+---------+
 *                                   finish
 *
 *
 * How many possible unique paths are there?
 *
 * Above is a 3 x 7 grid. How many possible unique paths are there?
 *
 * Note: m and n will be at most 100.
 *
 **********************************************************************************/

#include <stdio.h>
#include <stdlib.h>

void printMatrix(int*a, int m, int n);

/*
 * Dynamic Programming
 *
 * We have a dp[i][j] represents  how many paths from [0][0] to hear. So, we have the following DP formuler:
 *
 *    dp[i][j] =  1  if i==0 || j==0        //the first row/column only have 1 uniqe path.
 *             =  dp[i-1][j] + dp[i][j-1]   //the path can be from my top cell and left cell.
 */
int uniquePaths(int m, int n) {
    int* matrix = new int[m*n];
    printMatrix(matrix, m, n);
    for (int i=0; i<m; i++){
        for (int j=0; j<n; j++){
            if(i==0 || j==0){
                matrix[i*n+j]=1;
            }else{
                matrix[i*n+j] = matrix[(i-1)*n+j] + matrix[i*n+j-1];
            }
        }
    }
    printMatrix(matrix, m, n);
    int u = matrix[m*n-1];
    delete[] matrix;
    return u;
}

/**********************************************************************************
*
* Follow up for "Unique Paths":
*
* Now consider if some obstacles are added to the grids. How many unique paths would there be?
*
* An obstacle and empty space is marked as 1 and 0 respectively in the grid.
*
* For example,
* There is one obstacle in the middle of a 3x3 grid as illustrated below.
*
* [
*   [0,0,0],
*   [0,1,0],
*   [0,0,0]
* ]
*
* The total number of unique paths is 2.
*
* Note: m and n will be at most 100.
*
**********************************************************************************/

//As same as DP solution with "Unique Path I", just need to consider the obstacles.
int uniquePathsWithObstacles(vector<vector<int> > &obstacleGrid) {
    vector< vector<int> > v = obstacleGrid;
    unsigned int max=0;
    for (int i=0; i<obstacleGrid.size(); i++){
        for (int j=0; j<obstacleGrid[i].size(); j++){
            if(obstacleGrid[i][j] == 1){
                max = v[i][j] = 0;
            } else {
                if (i>0 && j>0) {
                    max= v[i][j] = v[i-1][j] + v[i][j-1];
                }else if(i>0){
                    max = v[i][j] = v[i-1][j];
                }else if(j>0){
                    max = v[i][j] = v[i][j-1];
                }else{
                    max = v[i][j] = 1 ;
                }
            }
        }
    }
    return max;
}


