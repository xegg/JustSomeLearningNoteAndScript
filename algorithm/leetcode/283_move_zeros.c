int size = 5
int num[5] = {0, 1, 0, 3, 12}

for(int i = 0; i < 4; i++) {
    for(int j = i+1; j < 5 ){
        if (num[i] == 0)
    }

}



void moveZeroes(vector<int>& nums) {
    int i = 0, poz = 0;
    for(i = 0; i < nums.size() && poz < nums.size(); i++)
    {
            while(nums[poz] == 0)
                poz++;
            if(poz < nums.size())
                nums[i] = nums[poz];
            else
                i--; // we need 0 on position i, but i is increasing one last time
            poz++;
    }
    for(; i < nums.size(); i++)
        nums[i] = 0;
}

void moveZeroes(vector<int>& nums) {
    int p1=0, p2=0;

    // Find the first ZERO, where is the tail of the array.
    // (Notes: we can simply remove this!)
    for (; nums[p1]!=0 && p1<nums.size(); p1++);

    // copy the item from p2 to p1, and skip the ZERO
    for (p2=p1; p2<nums.size(); p2++) {
        if ( nums[p2] == 0 ) continue;
        nums[p1++] = nums[p2];
    }

    //set ZERO for rest items
    while ( p1<nums.size() ) nums[p1++] = 0;
}
