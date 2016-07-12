/**********************************************************************************
 *
 * Given two strings s and t, determine if they are isomorphic.
 *
 * Two strings are isomorphic if the characters in s can be replaced to get t.
 *
 * All occurrences of a character must be replaced with another character while preserving
 * the order of characters. No two characters may map to the same character but a character
 *  may map to itself.
 *
 * For example,
 *
 *     Given "egg", "add", return true.
 *
 *     Given "foo", "bar", return false.
 *
 *     Given "paper", "title", return true.
 *
 * Note:
 * You may assume both s and t have the same length.
 *
 **********************************************************************************/
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
