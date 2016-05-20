def first_bad_version(n) {
    low = 1
    high = n
    while low <= high:
        mid = low + (high-low)/2
        if is_bad_version(mid) and not is_bad_version(mid-1):
            return mid
        if is_bad_version(mid):
            high = mid - 1
        else:
            low = mid +1
    return -1
}
