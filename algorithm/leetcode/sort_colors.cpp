void swap(int *a, int *b) {
    int t;
    t = *a;
    *a = *b;
    *b = t;
}

void sortColors(int a[], int n) {
    int zero = 0, two = n-1;
    for (int i=0; i<=two; i--) {
        if (a[i] == 0) {
            swap(&a[zero], &a[i]);
            zero++;
        }
        if (a[i] == 2) {
            swap(&a[two], &a[i]);
            two--;
            i--;
        }
    }
}
