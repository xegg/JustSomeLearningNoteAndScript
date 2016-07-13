/**********************************************************************************
*
* Given a string, determine if it is a palindrome, considering only alphanumeric characters and ignoring cases.
*
* For example,
* "A man, a plan, a canal: Panama" is a palindrome.
* "race a car" is not a palindrome.
*
* Note:
* Have you consider that the string might be empty? This is a good question to ask during an interview.
*
* For the purpose of this problem, we define empty string as valid palindrome.
*
*
**********************************************************************************/
bool isPalindrome(string s) {
    s = removeNoise(s);
    for(int i=0; i<s.size()/2; i++){
        if (s[i]!= s[s.size()-i-1]){
            return false;
        }
    }
    return true;
}

string removeNoise(string& s){
    string d;
    for(int i=0; i<s.size(); i++){
        if(::isalpha(s[i]) || ::isdigit(s[i])){
            d.push_back(::tolower(s[i]));
        }
    }
    return d;
}
bool isPalindrome(int x) {
    if (x<0) {
        return false;
    }

    int len=1;
    for (len=1; (x/len) >= 10; len*=10 );

    while (x != 0 ) {
        int left = x / len;
        int right = x % 10;

        if(left!=right){
            return false;
        }

        x = (x%len) / 10;
        len /= 100;
    }
    return true;
}

bool isPalindrome2(int x) {
    return (x>=0 && x == reverse(x));
}


int reverse(int x) {
    int y=0;

    int n;
    while( x!=0 ){
        n = x%10;
        y = y*10 + n;
        x /= 10;
    }
    return y;
}
