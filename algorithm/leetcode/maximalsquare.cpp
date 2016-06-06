int min(int x, int y) {
    return x < y? x:y;
}
int min(int x, int y, int z) {
    return min(x, min(y, z));
}

int maximalSquare(vector<vector<char>>& matrix) {
    int row = matrix.size();
    if (row <= 0) return 0;
    int col = matrix[0].size();

    int maxsize = 0;
    vector<vector<int> > dp(row, vector<int>(col));

    for (int i=0; i<matrix.size(); i++) {
        for(int j=0; j<matrix[i].size(); j++) {
            dp[i][j] = matrix[i][j] - '0';

            if (i!=0 && j!=0 && dp[i][j]!=0) {
                 dp[i][j] = min(dp[i-1][j], dp[i][j-1], dp[i-1][j-i1])+1;
            }
            if (dp[i][j] > maxsize) {
                maxsize = dp[i][j];
            }
        }
    }
}
