string longestCommonPrefix(vector<string> &strs) {
    string word;
    if (strs.size() <= 0) return word;
    for (int i = 1; i <=strs[0].size(); i++) {
        string w = strs[0].substr(0, i);
        bool match = true;
        for (int j = 1; j < strs.size(); j++) {
            if (j>strs[j].size() || w != strs[j].substr(0, i)) {
                match = false;
                break;
            }
        }
        if (!match) {
            return word;
        }
        word = w;
    }
    return word;
}
