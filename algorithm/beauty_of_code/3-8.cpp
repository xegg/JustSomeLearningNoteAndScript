int target_len = n + 1;
int begin = 0;
int end = 0;
int len = n;
int abstract_begin = 0;
int abctract_end = 0;

while(true) {
    while(!isAllExisted() && end < len) {
        end++;
    }

    while(isAllExisted())
    {
        if(end - begin < target_len) {
            target_len = end - begin;
            abstract_begin = begin;
            abstract_end = end - 1;
        }
        begin++;
    }
    if(end >= N)
        break
}
