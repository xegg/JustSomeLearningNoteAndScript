
vector< vector<string> > groupAnagrams01(vector<string> &strs) {
    vector< vector<string> > result;
    map<string, multiset<string>> m;
    for(int i=0; i<strs.size(); i++){
        string word = strs[i];
        sort(word.begin(), word.end());
        m[word].insert(strs[i]);
    }

    for(auto item : m){
        vector<string> v(item.second.begin(), item.second.end());
        result.push_back(v);
    }
    return result;
}
vector< vector<string> > groupAnagrams(vector<string> &strs) {
    vector< vector<string> > result;
    map<string, int> m;
    for(int i=0; i<strs.size(); i++){
        string word = strs[i];
        sort(word.begin(), word.end());
        if (m.find(word)==m.end()){
            vector<string> v;
            v.push_back(strs[i]);
            result.push_back(v);
            m[word] = result.size()-1;

        }else{
            result[m[word]].push_back(strs[i]);
        }
    }

    for(int i=0; i<result.size(); i++){
        sort(result[i].begin(), result[i].end());
    }
    return result;
}
