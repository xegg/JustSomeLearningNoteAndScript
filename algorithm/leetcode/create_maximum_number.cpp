vector<int> maxNumber(vector<int>& nums1, vector<int>& nums2, int k) {
    vector<int> result;
    int len1 = nums1.size();
    int len2 = nums2.size();
    for(int i = 0; i<=k, i++) {
        if(len1 < i || len2 < k-1) continue;
        vector<int> sub1 = findMaxSubArray(nums1, i);
        vector<int> sub2 = findMaxSubArray(nums2, i);
        if (compareTwoArray(merge, 0, result, 0)) {
            result = merge;
        }
    }
    return result;
}

bool compareTwoArray(vector<int>& nums1, int start1, vector<int>& nums2, int start2) {
    int n1 = nums1.size();
    int n2 = nums2.size();
    for(; start1 < n1 && start2<n2; start1++, start2++) {
        if (nums1[start1] > nums2[start2]) return true;
        if (nums1[start1] < nums2[start2]) return false;
    }
    return start1 < nums1.size();
}

vector<int> mergeTwoArrays(vector<int>& nums1, vector<int>& nums2) {
    vector<int> result;
    int len1 = nums1.size();
    int len2 = nums2.size();
    int pos1=0, pos2=0;
    while ( pos1 < len1 && pos2 < len2 ){
        if (nums1[pos1] == nums2[pos2]){
            result.push_back( compareTwoArray(nums1, pos1+1, nums2, pos2+1) ?
                                nums1[pos1++] : nums2[pos2++]);
        }else {
            result.push_back(nums1[pos1] > nums2[pos2] ?
                                nums1[pos1++] : nums2[pos2++]);
        }
    }

    if (pos1 < len1){
        result.insert(result.end(), nums1.begin()+pos1, nums1.end());
    }
    if (pos2 < len2) {
        result.insert(result.end(), nums2.begin()+pos2, nums2.end());
    }
    return result;
}

vector<int> findMaxSubArray(vector<int>& nums, int k) {
    int len = nums.size();
    if (k >= len) return nums;
    vector<int> result(k, 0);
    int idx = 0;
    for (int i=0; i<len; i++) {
        while (idx>0 && k - idx < len-i && result[idx-1] < nums[i]) {
            idx--;
        }
        if (idx < k) {
            result[idx++] = nums[i];
        }
    }
    return result;
}
