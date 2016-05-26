Moore Voting Algorithm

int majorityElement(vector<int> &num) {
    int majority;
    int cnt = 0;
    for(int i=0; i<num.size(); i++){
        if ( cnt ==0 ){
            majority = num[i];
            cnt++;
        }else{
            majority == num[i] ? cnt++ : cnt --;
            if (cnt >= num.size()/2) return majority;
        }
    }
    return majority;

}

vector<int> majorityElement01(vector<int>& nums) {
    vector<int> result;
    unordered_map<int, int> counts;
    int n = nums.size();
    for(auto item : nums){
        counts[item]++;
        if (counts[item] > n/3 ){
           result.push_back(item);
           counts[item] = -n; // Tricky: make sure the item only can be put into result once.
        }
    }
    return result;
}
//We know, there could be at most two numbers can be more than 1/3
//so, same as Majority Element I problem, we can have two counters.
vector<int> majorityElement02(vector<int>& nums) {
    if(nums.size()<=1) return nums;

    //the same algorithm as Majority Element I problem
    int majority1=0, majority2=0, cnt1=0, cnt2=0;
    for(auto item: nums) {
        if (cnt1 == 0 && majority2 != item ) {
            majority1 = item;
            cnt1 = 1;
        } else if (majority1 == item) {
            cnt1++;
        } else if (cnt2 == 0) {
            majority2 = item;
            cnt2 = 1;
        } else if (majority2 == item) {
            cnt2++;
        } else {
            cnt1--;
            cnt2--;
        }
    }
    //re-check it again, in case there has less than two numbers of majority
    cnt1 = cnt2 = 0;
    for (auto item : nums) {
        if (majority1 == item) cnt1++;
        else if (majority2 == item) cnt2++;
    }
    vector<int> result;
    if (cnt1 > nums.size()/3) result.push_back(majority1);
    if (cnt2 > nums.size()/3) result.push_back(majority2);
    return result;

}
