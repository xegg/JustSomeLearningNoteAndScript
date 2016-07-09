/***************************************************************************************
 *
 * Given an array of citations (each citation is a non-negative integer) of a
 * researcher, write a function to compute the researcher's h-index.
 *
 * According to the definition of h-index on Wikipedia: "A scientist has index h if h of
 * his/her N papers have at least h citations each, and the other N − h papers have no
 * more than h citations each."
 *
 * For example, given citations = [3, 0, 6, 1, 5], which means the researcher has 5
 * papers in total and each of them had received 3, 0, 6, 1, 5 citations respectively.
 * Since the researcher has 3 papers with at least 3 citations each and the remaining
 * two with no more than 3 citations each, his h-index is 3.
 *
 * Note: If there are several possible values for h, the maximum one is taken as the
 * h-index.
 *
 ***************************************************************************************/


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
