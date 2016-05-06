void straight_insertion_sort(elem_t a[], const int start, const int end) {
    elem_t tmp;
    int i, j;

    for (i = start+1; i < end; i++) {
        tmp = a[i];
        for (j=i-1; tmp < a[j] && j >= start; j--) {
            a[j+1] = a[j];
        }
        a[j+1] = tmp;
    }
}

void binary_insertion_sort(elem_t a[], const int start, const int end) {
    elem_t tmp;
    int i, j, left, right, mid;

    for (i = start + 1; i < end ; i++){
        tmp = a[i];
        left = start;
        right = i - 1;
        while (left <= right) {
            mid = (left + right) / 2;
            if (tmp < a[mid]) {
                right = mid -1;
            } else {
                left = mid + 1;
            }
        }
        for (j = i-1; j >= left; j--) {
            a[j+1] = a[j]
        }
        a[left] = tmp;
    }
}

static void shell_insert(elem_t a[], const int start, const int end, const int gap) {
    elem_t tmp;
    int i, j;
    for (i = start + gap; i < end; i++) {
        tmpp = a[i];
        for (j = i - gap; tmp < a[j] && j >= start; j -= gap) {
            a[j + gap] = a[j];
        }
        a[j+gap] = tmp;
    }
}

void shell_sort(elem_t a[], const int start, const int end) {
    int gap = end - start;
    while (gap > 1) {
        gap = gap / 3 + 1;
        shell_insert(a, start, end, gap);
    }
}
