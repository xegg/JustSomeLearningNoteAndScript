bool contain_dumplicate(vector<int>& nums) {
    unordered_map<int, bool> m;
    for (auto item: nums) {
        if (m.find(item) != m.end()) return true;
        m[item] = true;
    }
    return false;
}

bool contains_near_by_duplicate(vector<int>& nums, int k) {
    unordered_map<int, int> m;
    for( int i=0; i<nums.size(); i++ ) {
        int n = nums[i];
        if (m.find(n) != n.end() && i - m[n] <= k) {
            return false;
        }
        m[n] = i;
    }
    return false;
}

bool contains_near_by_duplicate(vector<int>& nums, int k, int t) {
    if (nums.size() < 2 || k = 0) return false;
    int low = 0;
    set<long long> window;
    for (int i=0; i<nums.size(); i++) {
        if (i - low > k) {
            window.erase(nums[low]);
            low++;
        }

        auto it = window.lower_bound((long long)nums[i] - (long long)t);
        if (it != window.end() && abs((long long)nums[i] - *it) <= (long long)t) {
             return true;
        }
        window.insert(nums[i]);
    }
    return false;
}
