word = list('hello')
word = list('leetcode')

indexs = []
vowels = ['a','e','i','o','u']
for i, j in enumerate(word):
    if j in vowels:
        indexs.append(i)
print indexs

for i in range(len(indexs)/2):
    print indexs[i], indexs[-(i+1)]
    word[indexs[i]], word[indexs[-(i+1)]] = word[indexs[-(i+1)]], word[indexs[i]]

print ''.join(word)
# string vowel = "aoeiuAOEIU";

# bool isVowel(char c) {
    # for (int i = 0; i < vowel.length(); i++) {
        # if (c == vowel[i])
            # return true;
    # }
    # return false;
# }

# string reverseVowels(string s) {
    # string result;
    # stack<char> vowels;
    # for (int i = 0; i < s.length(); i++) {
        # if (isVowel(s[i])) {
            # vowels.push(s[i]);
        # }
    # }
    # for (int i = 0; i < s.length(); i++) {
        # if (isVowel(s[i])) {
            # result += vowels.top();
            # vowels.pop();
        # } else {
            # result += s[i];
        # }
    # }
    # return result;
# }
