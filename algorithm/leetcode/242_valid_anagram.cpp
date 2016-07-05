
bool isAnagram(string s, string t) {
    int len1 = s.length();
    int len2 = t.length();
    if(len1!=len2){
        return false;
    }
    vector<int> count(26, 0);
    for(int i=0; i<len1; i++){
        count[s[i]-'a']++;
    }
    for(int i=0; i<len2; i++){
        if(--count[t[i]-'a']<0){
            return false;
        }
    }
    for (int i=0; i<sizeof(map)/sizeof(map[0]); i++) {
        if (map[i]!=0) return false;
    }
    return true;
}
