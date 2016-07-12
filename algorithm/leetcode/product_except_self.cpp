
/**********************************************************************************
 *
 * Given an array of n integers where n > 1, nums, return an array output such that
 * output[i] is equal to the product of all the elements of nums except nums[i].
 *
 * Solve it without division and in O(n).
 *
 * For example, given [1,2,3,4], return [24,12,8,6].
 *
 * Follow up:
 * Could you solve it with constant space complexity? (Note: The output array does not
 * count as extra space for the purpose of space complexity analysis.)
 *

Given numbers [2, 3, 4, 5], regarding the third number 4, the product of array except 4 is 2*3*5 which consists of two parts: left 2*3 and right 5. The product is left*right. We can get lefts and rights:


Numbers:     2    3    4     5
Lefts:            2  2*3 2*3*4
Rights:  3*4*5  4*5    5
Let’s fill the empty with 1:

Numbers:     2    3    4     5
Lefts:       1    2  2*3 2*3*4
Rights:  3*4*5  4*5    5     1
 *
 **********************************************************************************/
vector<int> productExceptSelf(vector<int>& nums) {

    int len = nums.size();
    vector<int> result(len, 1);

    //from the left to right
    for (int i=1; i<len; i++) {
        result[i] = result[i-1]*nums[i-1];
    }
    //from the right to left
    int factorial = 1;
    for (int i=len-2; i>=0; i--){
        factorial *= nums[i+1];
        result[i] *= factorial;
    }
    return result;
}
private int multiply(int[] a, int fwdProduct, int indx, int N) {
    int revProduct = 1;
    if (indx < N) {
        revProduct = multiply(a, fwdProduct * a[indx], indx + 1, N);
        int cur = a[indx];
        a[indx] = fwdProduct * revProduct;
        revProduct *= cur;
    }
    return revProduct;
}
