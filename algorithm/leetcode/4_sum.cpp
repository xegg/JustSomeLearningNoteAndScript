vector<vector<int> > fourSum(vector<int> &num, int target) {
    vector< vector<int> > result;
    if (num.size()<4) return result;
    sort(num.begin(), num.end());
    for(int i=0; i<num.size()-3; i++) {
        //skip the duplication
        if (i>0 && num[i-1]==num[i]) continue;
        vector<int> n(num.begin()+i+1, num.end());
        vector<vector<int> > ret = threeSum(n, target-num[i]);
        for(int j=0; j<ret.size(); j++){
            ret[j].insert(ret[j].begin(), num[i]);
            result.push_back(ret[j]);
        }
    }
    return result;
}
