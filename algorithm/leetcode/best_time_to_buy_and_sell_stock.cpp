/**********************************************************************************
*
* Say you have an array for which the ith element is the price of a given stock on day i.
*
* If you were only permitted to complete at most one transaction (ie, buy one and sell one share of the stock),
* design an algorithm to find the maximum profit.
*
**********************************************************************************/

//
// This solution is O(1) space dynamic programming
//
// We can make sure the max profit at least be ZERO. So,
//    1) we have two pointers (begin & end )
//    2) if prices[end] - prices[begin] >  0, then move the "end" pointer to next
//    3) if prices[end] - prices[begin] <= 0, then move the "begin" pointer to current posstion.
//    4) tracking the max profit
//
// Notes:
//    Some people think find the highest-price & lowest-price, this is wrong.
//    Because the highest-price must be after lowest-price
//
int maxProfit(vector<int> &prices) {

    int max=0, begin=0, end=0, delta=0;

    for (int i=0; i<prices.size(); i++) {

        end = i;

        delta = prices[end] - prices[begin];

        if (delta <= 0){
            begin = i;
        }

        if ( delta > max ){
            max = delta;
        }

    }

    return max;
}

/**********************************************************************************
*
* Say you have an array for which the ith element is the price of a given stock on day i.
*
* Design an algorithm to find the maximum profit. You may complete as many transactions
* as you like (ie, buy one and sell one share of the stock multiple times). However,
* you may not engage in multiple transactions at the same time (ie, you must sell the
* stock before you buy again).
*
**********************************************************************************/

//
// find all of ranges: which start a valley with the nearest peak after
// add their delta together
//
int maxProfit(vector<int> &prices) {
    int max=0, begin=0, end=0;
    bool up=false, down=false;
    for (int i=1; i<prices.size(); i++) {
        if (prices[i] > prices[i-1] && up==false){ // goes up
            begin = i-1;
            up = true;
            down = false;
        }

        if (prices[i] < prices[i-1] && down==false) { // goes down
            end = i-1;
            down = true;
            up = false;
            max += (prices[end] - prices[begin]);
        }
    }
    // edge case
    if (begin < prices.size() && up==true){
        end = prices.size() - 1;
        max += (prices[end] - prices[begin]);
    }

    return max;
}

public class Solution {
    public int maxProfit(int[] prices) {
        if (prices.length < 2) return 0;

        int maxProfit = 0;
        for (int i = 1; i < prices.length; i++) {
            int diff = prices[i] - prices[i - 1];
            if (diff > 0) {
                maxProfit += diff;
            }
        }

        return maxProfit;
    }
}

/**********************************************************************************
*
* Say you have an array for which the ith element is the price of a given stock on day i.
*
* Design an algorithm to find the maximum profit. You may complete at most two transactions.
*
* Note:
* You may not engage in multiple transactions at the same time (ie, you must sell the stock before you buy again).
*
**********************************************************************************/


class Solution {
public:
    // Dynamic Programming
    //
    //     Considering prices[n], and we have a position "i", we could have
    //       1) the maxProfit1 for prices[0..i]
    //       2) the maxProfit2 for proices[i..n]
    //
    //    So,
    //      for 1) we can go through the prices[n] forwardly.
    //          forward[i] = max( forward[i-1], price[i] - lowestPrice[0..i] )
    //      for 2) we can go through the prices[n] backwoardly.
    //          backward[i] = max( backward[i+1], highestPrice[i..n] - price[i])
    //
    int maxProfit(vector<int> &prices) {
        if (prices.size()<=1) return 0;

        int n = prices.size();

        vector<int> forward(n);
        forward[0] = 0;
        int lowestBuyInPrice = prices[0];
        for(int i=1; i<n; i++){
            forward[i] = max(forward[i-1], prices[i] - lowestBuyInPrice);
            lowestBuyInPrice = min(lowestBuyInPrice, prices[i]);
        }

        vector<int> backward(n);
        backward[n-1] = 0;
        int highestSellOutPrice = prices[n-1];
        for(int i=n-2; i>=0; i--){
            backward[i] = max(backward[i+1], highestSellOutPrice - prices[i]);
            highestSellOutPrice = max(highestSellOutPrice, prices[i]);
        }

        int max_profit = 0;
        for(int i=0; i<n; i++){
            max_profit = max(max_profit, forward[i]+backward[i]);
        }

        return max_profit;
    }
};


/**********************************************************************************
*
* Say you have an array for which the ith element is the price of a given stock on day i.
*
* Design an algorithm to find the maximum profit. You may complete at most k transactions.
*
* Note:
* You may not engage in multiple transactions at the same time (ie, you must sell the stock before you buy again).
*
* Credits:Special thanks to @Freezen for adding this problem and creating all test cases.
*
**********************************************************************************/

class Solution {
public:
    /*
     *  dp[i, j]
     *    - `i` represents the number of transactions we've done so far. ( 0 <= i <= k )
     *    - `j` represents the number of days so far. ( 0 <= j <= prices.size() )
     *
     *  So, we have the initialization as below:
     *
     *  dp[0, j] = 0; // 0 <= j <= prices.size()
     *  dp[i, 0] = 0; // 0 <= i <= k
     *
     *  And the iteration logic as below:
     *
     *  dp[i, j] = max (
     *               dp[i, j-1], // same times transactions, but one days before.
     *               dp[i-1, t] + prices[j] - prices[t+1]  // for all of (0 <= t < j )
     *                                                     // this means find max profit from previous any of days
     *           )
     *
     */

    int maxProfit(int k, vector<int> &prices) {
        int ndays = prices.size();

        // error case
        if (ndays<=1) return 0;

        // Edge case
        // ---------
        // if the number of transactions is too many, it means we can make
        // as many transactions as we can, that brings us the problem back to
        // Best-Time-To-Buy-And-Sell-Stock-II which can be simply solve in O(n)
        // by using a greedy approach.
        if(k > ndays/2){
            int sum = 0;
            for (int i=1; i<ndays; i++) {
                sum += max(prices[i] - prices[i-1], 0);
            }
            return sum;
        }

        //DP solution - O(kn) complexity
        vector< vector<int> > dp (k+1, vector<int>( ndays+1, 0));

        for(int i=1; i<=k; i++) {
            int t = dp[i-1][0] - prices[0];
            for (int j=1; j <= ndays; j++) {
                dp[i][j] = max(dp[i][j-1], t + prices[j-1]);
                if ( j < ndays ) {
                    t = max(t, dp[i-1][j] - prices[j]);
                }
            }
        }

        return dp[k][ndays];

    }
};


题意：用一个数组表示股票每天的价格，数组的第i个数表示股票在第i天的价格。最多交易k次，手上最多只能持有一支股票，求最大收益。

分析：特殊动态规划法。传统的动态规划我们会这样想，到第i天时进行j次交易的最大收益，要么等于到第i-1天时进行j次交易的最大收益（第i天价格低于第i-1天的价格），要么等于到第i-1天时进行j-1次交易，然后第i天进行一次交易（第i天价格高于第i-1天价格时）。于是得到动规方程如下（其中diff = prices[i] – prices[i – 1]）：

profit[i][j] = max(profit[i – 1][j], profit[i – 1][j – 1] + diff)
看起来很有道理，但其实不对，为什么不对呢？因为diff是第i天和第i-1天的差额收益，如果第i-1天当天本身也有交易呢（也就是说第i-1天刚卖出了股票，然后又买入等到第i天再卖出），那么这两次交易就可以合为一次交易，这样profit[i – 1][j – 1] + diff实际上只进行了j-1次交易，而不是最多可以的j次，这样得到的最大收益就小了。

那么怎样计算第i天进行交易的情况的最大收益，才会避免少计算一次交易呢？我们用一个局部最优解和全局最有解表示到第i天进行j次的收益，这就是该动态规划的特殊之处。

用local[i][j]表示到达第i天时，最多进行j次交易的局部最优解；用global[i][j]表示到达第i天时，最多进行j次的全局最优解。它们二者的关系如下（其中diff = prices[i] – prices[i – 1]）：

local[i][j] = max(global[i – 1][j – 1] , local[i – 1][j] + diff)
global[i][j] = max(global[i – 1][j], local[i][j])
local[i][j]和global[i][j]的区别是：local[i][j]意味着在第i天一定有交易（卖出）发生，当第i天的价格高于第i-1天（即diff > 0）时，那么可以把这次交易（第i-1天买入第i天卖出）跟第i-1天的交易（卖出）合并为一次交易，即local[i][j]=local[i-1][j]+diff；当第i天的价格不高于第i-1天（即diff<=0）时，那么local[i][j]=global[i-1][j-1]+diff，而由于diff<=0，所以可写成local[i][j]=global[i-1][j-1]。global[i][j]就是我们所求的前i天最多进行k次交易的最大收益，可分为两种情况：如果第i天没有交易（卖出），那么global[i][j]=global[i-1][j]；如果第i天有交易（卖出），那么global[i][j]=local[i][j]。

参考：http://www.cnblogs.com/grandyang/p/4295761.html

代码：时间O(nk)，空间O(nk)。

1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
17
18
19
20
21
22
23
24
25
26
27
28
29
30
31
32
33
34
35
public class Solution {
    public int maxProfit(int k, int[] prices) {
        if (prices.length < 2) return 0;

        int days = prices.length;
        if (k >= days) return maxProfit2(prices);

        int[][] local = new int[days][k + 1];
        int[][] global = new int[days][k + 1];

        for (int i = 1; i < days ; i++) {
            int diff = prices[i] - prices[i - 1];

            for (int j = 1; j <= k; j++) {
                local[i][j] = Math.max(global[i - 1][j - 1], local[i - 1][j] + diff);
                global[i][j] = Math.max(global[i - 1][j], local[i][j]);
             }
        }

        return global[days - 1][k];
    }


    public int maxProfit2(int[] prices) {
        int maxProfit = 0;

        for (int i = 1; i < prices.length; i++) {
            if (prices[i] > prices[i - 1]) {
                maxProfit += prices[i] - prices[i - 1];
            }
        }

        return maxProfit;
    }
}
我们知道，动规所用的二维辅助数组可以降为一维的，即只用大小为k的一维数组记录到达第i天时的局部最优解和全局最优解。需要注意的是，由于第i天时交易k次的最优解依赖于第i-1天时交易k-1次的最优解，所以数组更新应当从后往前（即从k到1）更新。

