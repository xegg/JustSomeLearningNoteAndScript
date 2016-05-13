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
