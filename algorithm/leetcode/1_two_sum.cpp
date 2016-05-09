vector<int> twoSum(vector<int> &number, int target) {
    unodered_map<int, int> m;
    vector<int> result;
    for(int i=0; i<numbers.size(); i++) {
        if (m.find(numbers[i]==m.end())) {
                m[target-numbers[i]] = i;
        } else {
            result.push_back(m[number[i]]+1);
            result.push_back(i+1);
            break
        }
    }
    return result;
}


vector<int> twoSum(vector<int> &numbers, int target) {
    vector<int> result;
    int low=0, high = numbers.size()-1;
    while (low < high){
        if (numbers[low] + numbers[high] == target){
            result.push_back(low+1);
            result.push_back(high+1);
            return result;
        }else{
            numbers[low] + numbers[high] > target ? high-- : low++;
        }
    }

    return result;
}

class TwoSum {
    private:
        unordered_map<int, int> nums;
    public:

        //O(1) add
        void add(int number) {
            nums[number]++;
        }

        //O(n) find
        bool find(int value) {
            int one, two;
            for(auto it = nums.begin(); it != nums.end(); it++){
                one = it->first;
                two = value - one;
                if ( (one == two && it->second > 1) ||
                        (one != two && nums.find(two) != nums.end() ) ){
                    return true;
                }
            }
            return false;
        }
};
