void simple_selection_sort(elem_t a[], const int start, const int end){
    elem_t tmp;
    int i, j, k;
    for (i = start; i < end; i++) {
        k = i;
        for (j = i+1; j < end; j++) {
            if (a[j] < a[k]) k = j;
        }
        if (k != i) {
            tmp = a[i];
            a[i] = a[k];
            a[k] = tmp;
        }
    }
}

void heap_sort(heap_elem_t *a, const int n,
        int (*cmp)(const heap_elem_t*, const heap_elem_t*)) {
    int i;
    heap *h;
    heap_elem_t tmp;
    h = heap_create(n, cmp);
    h->elems = a;

    i = (h->size -2)/2;
    while ( i >= 0 ) {
        heap_sift_down(h, i);
        i--;
    }

    for (i = h->size -1; i > 0; i--) {
        tmp = h->elems[i];
        h->elems[i] = h->elems[0];
        h->elems[0] = tmp;
        heap_sift_down(h, 0);
    }
    heap_destroy(h);
}

