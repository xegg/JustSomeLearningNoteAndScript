http://www.hawstein.com/posts/binary-indexed-trees.html
class NumArray {
private:
    int _sz;
    vector<int> _nums;
    vector<int> _sums;
public:
    NumArray(vector<int> &nums)  {
        _sz = nums.size();
        _nums.resize(_sz+1, 0);
        _sums.resize(_sz+1, 0);
        for(int i=0; i< _sz; i++) {
            update(i, nums[i]);
        }
    }

    int sumRange(int i, int j) {
        return sumRange(j+1) - sumRange(i);
    }

    void update(int i, int val) {
        int oldv = _nums[i+1];
        for(int idx = i+1; idx <= _sz; idx += (idx & (-idx))  ) {
            _sums[idx] = _sums[idx] - oldv + val;
        }
        _nums[i+1] = val;
    }

    int sumRange(int i, int j) {
        return sumRange(j+1) - sumRange(i);
    }

    int sumRange(int i) {
        int ret = 0;
        for(int idx=i; idx>0; idx -= (idx & (-idx)) ) {
            ret += _sums[idx];
        }
        return ret;
    }
};
