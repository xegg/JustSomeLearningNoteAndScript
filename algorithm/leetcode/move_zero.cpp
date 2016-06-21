void moveZeroes(vector<int>& nums) {
    int p1=0, p2=0;
    for(; nums[p1]!=0 && p1<num.size(); p1++);
    for(p2=p1; p2<nums.size(); p2++) {
        if(nums[p2] == 0) continue;
        nums[p1++] = nums[p2];
    }
    while(p1<nums.size()) nums[p1++] = 0;
}
