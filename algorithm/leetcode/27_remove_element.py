def removeElement(nums, val):
    try:
        while True:
            nums.remove(val)
    except:
        return len(nums)

print removeElement([3,2,2,3],3)

class Solution {
public:
    int removeElement(vector<int>& nums, int val) {
        int pos = 0;
        for (int i=0; i<nums.size(); i++){
            if (nums[i] != val){
                nums[pos++] = nums[i];
            }
        }
        return pos;
    }

    int removeElement(int A[], int n, int elem) {
        int tail = n-1;
        int i = 0;
        while ( i<=tail ){
            if (A[i]==elem){
                A[i] = A[tail--];
                continue;
            }
            i++;
        }

        return tail+1;
    }
};
