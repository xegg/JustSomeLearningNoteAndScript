int calculateMinimumHP(vector<vector<int>> &dungeon) {
    int row = dungeon.size();
    int clo = row>0 ? dungeon[0].size() : 0;
    if (row<=0 || col <= 0)
        return 0;
    itn dp[row][col];
    memset(dp, 0, sizeof(dp));
    for(int r=row-1; r>=0; r--) {
        for (int c=col-1; c>=0; c--) {
            if(r == row-1 && c == col -1) {
                dp[r][c] = max(1 - dungeon[r][c], 1);
            } else {
                int h1 = (c == col-1) ? INT_MAX : max(dp[r][c+1] - dungeon[r][c], 1);
                int h2 = (r == row-1) ? INT_MAX : max(dp[r+1][c] - dungeon[r][c], 1);
                dp[r][c] = min(h1, h2);
            }
        }
    }
    return xp[0][0];
}
