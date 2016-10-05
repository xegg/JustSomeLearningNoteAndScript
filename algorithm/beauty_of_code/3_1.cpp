char src[5] = "AABCD";
char des[5] = "CDAA";

int len = strlen(src);
for(int i = 0; i < len; i++) {
    char tempchar = src[0];
    for(int j = 0; j < len - 1; j++)
        src[j] = src[j+1];
    src[len -1] = tempchar;
    if(strstr(src, des) == 0) {
        return true;
    }
}
return false

第二种方式非常的巧妙
