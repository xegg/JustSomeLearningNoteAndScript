void moveZeroes(vector<int>& nums) {
    int p1=0, p2=0;
    for(; nums[p1]!=0 && p1<num.size(); p1++);
    for(p2=p1; p2<nums.size(); p2++) {
        if(nums[p2] == 0) continue;
        nums[p1++] = nums[p2];
    }
    while(p1<nums.size()) nums[p1++] = 0;
}

void moveZeors2(vector<int>& nums) {
    int i = 0; poz = 0;
    for(i = 0; i< nums.size() && poz < nums.size(); i++) {
        while(nums[poz] == 0)
            poz++;
        if(poz < nums.size())
            nums[i] = nums[poz];
        else {
            i--;
        }
        poz++;
        for(; i < nums.size(); i++)
            nums[i] = 0;
    }
}
