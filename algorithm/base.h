void swap(int array[], int i, int j) {
    const int tmp = array[i];
    array[i] = array[j];
    array[j] = tmp;
}

void reverse(int array[], int first, int last) {
    last --;
    while (first < last) {
        swap(array, first++, last--);
    }
}

int gcd(int a, int b) {
    //assert(a >= b);
    if (b == 0) {
        return a;
    }

    while (b > 0) {
         int tmp = a % b;
         a = b;
         b = tmp;
    }
    return a;
}
