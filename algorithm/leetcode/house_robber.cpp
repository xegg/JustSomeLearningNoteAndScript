int rob1(vector<int> &money) {
    int n = money.size();
    if (n==0) return 0;
    vector<int> dp(n, 0);
    if (n>=1) dp[0] = money[0];
    for(int i = 2; i<n; i++){
        dp[i] = max(dp[i-1], dp[i-2]+money[i]);
    }
    return dp[n-1];
}
int rob2(vector<int> &money) {
    int n1 = 0;
    int n2 = 0;

    for(int i = 0; i < money.size(); i++) {
        current = max(n1+money[i], n2);
        n1 = n2;
        n2 = current;
    }
    return n2;
}

/**********************************************************************************
 *
 * Note: This is an extension of House Robber.
 *
 * After robbing those houses on that street, the thief has found himself a new place
 * for his thievery so that he will not get too much attention. This time, all houses
 * at this place are arranged in a circle. That means the first house is the neighbor
 * of the last one. Meanwhile, the security system for these houses remain the same as
 * for those in the previous street.
 *
 * Given a list of non-negative integers representing the amount of money of each house,
 * determine the maximum amount of money you can rob tonight without alerting the police.
 *
 * Credits:Special thanks to @Freezen for adding this problem and creating all test cases.
 *
 **********************************************************************************/
int orginal_rob(vector<int> &money, int start, int end) {
    int n2=0;
    int n1=0;

    for (int i=start; i<end; i++){
        int current = max(n1, n2 + money[i]);
        n2 = n1;
        n1 = current;
    }
    return n1;
}

int rob(vector<int> &nums) {
     int n = nums.size();
     switch (n) {
         case 0:
             return 0;
         case 1:
             return num[0];
         case 2:
             return max(num[0], num[1]);
         default:
             int m1 = orginal_rob(nums, 0, n-1);
             int m2 = orginal_rob(nums, 1, n);
             return max(m1, m2);
     }

}
