void bubble_sort(elem_t a[], const int start, const int end) {
    int exchange;
    elem_t tmp;
    int i, j;

    for (i = start; i < end -1; i++) {
        exchange = 0;
        for (j = end-1; j > 1; j--) {
            if (a[j-1] > a[j]) {
                tmp = a[j-1];
                a[j-1] = a[j];
                a[j] = tmp;
                exchange = 1;
            }
        }
        if (exchange == 0) return ;
    }
}

int partition(elem_t a[], const int start, const int end) {
    int i = start;
    int j = end;
    const elem_t pivot = a[i];
    while (i < j) {
        while (i < j && a[j] >= pivot) j--;
        a[i] = a[j];
        while (i < j && a[i] <= pivot) i++;
        a[j] = a[i];
    }
    a[i] = pivot;
    return i;
}

void quick_sort(elem_t a[], const int start, const int end) {
    if (start <  end -1) {
        const int pivot_pos = partition(a, start, end);
        quick_sort(a, start, end);
        quick_sort(a, pivot_pos+1, end);
    }
}
