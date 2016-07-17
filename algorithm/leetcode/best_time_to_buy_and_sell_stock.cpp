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
