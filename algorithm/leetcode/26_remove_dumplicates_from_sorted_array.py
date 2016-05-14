
class Solution {
public:
    int removeDuplicates(int A[], int n) {

        if (n<=1) return n;

        int pos=0;
        for(int i=0; i<n-1; i++){
            if (A[i]!=A[i+1]){
                A[++pos] = A[i+1];
            }
        }
        return pos+1;

int removeDuplicates(int A[], int n) {
    if (n<=2) return n;
    int pos=0;
    int cnt=1;
    for (int i=1; i<n; i++){
        if (A[i] == A[pos]){
            cnt++;
            if (cnt==2){
                A[++pos] = A[i];
            }
        }else{
            cnt=1;
            A[++pos] = A[i];

        }
    }
    return pos+1;
}
