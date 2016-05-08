static void merge(elemt_t a[], elemt_t tmp[], const int start,
        const int mid, const int end) {
    int i, j, k;
    for (i = 0; i < end; i++) tmp[i] = a[i];

    for(i = start, j = mid, k = start; i < mid && j < end; k++) {
        if (tmp[i] < tmp[j]) {
            a[k] = tmp[i++];
        } else {
            a[k] = tmp[j++];
        }
    }

    while (i < mid) a[k++] = tmp[i++];
    while (j < end) a[k++] = tmp[j++];
}

void merge_sort(elemt_t a[], elem_t tmp[], const int start, const int end) {
    if (start < end -1) {
        const int mid = (start + end) / 2;
        merge_sort(a, tmp, start, mid);
        merge_sort(a, tmp, start, end);
        merge(a, tmp, start, mid, end);
    }
}
