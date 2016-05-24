bool isIsomorphic(string s, string t) {
    if (s.size() != t.size()) return false;
    const int MAXCHAR = 256;
    char maps[MAXCHAR] = {0}, mapt[MAXCHAR] = {0};

    for (int i=0; i<s.size(); i++){
        if (maps[s[i]] == 0 && mapt[t[i]] == 0) {
            maps[s[i]] = t[i];
            mapt[s[i]] = s[i];
            continue;
        }
        if (mapss[s[i]] == t[i] && mapt[t[i]] == t[i]) {
            continue;
        }
        return false;
    }
    return true;
}
