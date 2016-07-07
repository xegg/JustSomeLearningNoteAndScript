void reverseArray(int nums[],int start, int end){
    int temp;
    while(start < end){
        int temp = nums[start];
        nums[start++] = nums[end];
        nums[end--] = temp;
    }
}

void rotate1(int nums[], int n, int k) {
    if (k<=0) return;
    k %= n;
    reverseArray(nums, n-k, n-1);
    reverseArray(nums, 0, n-k-1);
    reverseArray(nums, 0, n-1);
}

void rotate2(int nums[], int n, int k) {
    if (k<=0) return;
    k %= n;
    int currIdx=0, newIdx=k;
    int tmp1 = nums[currIdx], tmp2;
    int origin = 0;
    for(int i=0; i<n; i++){

        tmp2 = nums[newIdx];
        nums[newIdx] = tmp1;
        tmp1 = tmp2;

        currIdx = newIdx;

        //if we meet a circle, move the next one
        if (origin == currIdx) {
            origin = ++currIdx;
            tmp1 = nums[currIdx];
        }
        newIdx = (currIdx + k) % n;

    }
}
