vector<int> getNext(vector<int>& v) {
    int cnt=0;
    int val=0;
    vector<int> ret;
    for(int i=0; i<v.size(); i++){
        if (i==0){
            val = v[i];
            cnt = 1;
            continue;
        }
        if (v[i] == val){
            cnt++;
        }else{
            ret.push_back(cnt);
            ret.push_back(val);
            val = v[i];
            cnt = 1;
        }
    }
    if (cnt>0 && val>0){
        ret.push_back(cnt);
        ret.push_back(val);
    }
    return ret;
}


string countAndSay(int n) {
    if (n<=0) return "";
    if (n==1) return "1";

    string s;
    vector<int> v;
    v.push_back(1);
    for(int i=2; i<=n; i++){
       v = getNext(v);
       //s = s + ", " +vecToStr(v);
    }
    s = vecToStr(v);
    return s;
}
