def h_index(array):
    h_index = []
    for i in array:
        if i == len(filter(lambda x: x >= i, array)):
            h_index.append(i)

    return max(h_index)

print h_index([3, 0, 6, 1, 5])

int hIndex02(vector<int>& citations) {
    sort(citations.begin(), citations.end());
    int n = citations.size();
    for (int i=0; i<n; i++){
        if (citations[i] >= n-i){
            return n-i;
        }
    }
    return 0;
}

int hIndex(vector<int>& citations) {
    int n = citations.size();
    int low = 0, high = n-1;

    while( low <= high ) {
        int mid = low + (high-low)/2;
        if (citations[mid] == n - mid) {
            return n - mid;
        }else if (citations[mid] > n-mid){
            high = mid - 1;
        }else {
            low = mid + 1;
        }
    }
    return n-low;
}
