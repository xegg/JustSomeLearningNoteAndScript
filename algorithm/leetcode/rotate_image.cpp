/**********************************************************************************
*
* You are given an n x n 2D matrix representing an image.
* Rotate the image by 90 degrees (clockwise).
* Follow up:
* Could you do this in-place?
*
**********************************************************************************/

void rotate(vector<vector<int> > &matrix) {

    int n = matrix.size();

    for( int i=0; i<n/2; i++ ){
        int low=i, high=n-i-1;
        for (int j=low; j<high; j++){
            int tmp;
            tmp = matrix[i][j];
            // left to top
            matrix[i][j] = matrix[n-j-1][i];
            // bottom to left
            matrix[n-j-1][i] = matrix[n-i-1][n-j-1];
            // right to bottom
            matrix[n-i-1][n-j-1] = matrix[j][n-i-1];
            // top to right
            matrix[j][n-i-1] = tmp;
        }
    }
}
