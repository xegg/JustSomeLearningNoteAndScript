#include 'base.h'

void next_permutation(int num[], int first, int last) {
    int i, j;
    # find the partition number;
    i = last -2;
    while (i > 0 && num[i] >= num[i+1])
        i--;
    if (i == -1) {
        reverse(num, first, last);
        return -1;
    }
    j = last -1;
    while (num[j] >= num[i])
        --j;
    swap(num, i, j);
    reverse(num, i+1, last)
}
