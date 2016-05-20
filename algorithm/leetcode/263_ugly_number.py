def is_ugly(num):
    if num == 0:
        return false
    if num == 1:
        return false

    while num % 2 == 0:
        num /= 2
    while num % 3 == 0:
        num /= 3
    while num % 5 == 0:
        num /= 5

    return num == 1


int nthUglyNumber01(int n) {

    int i=0, j=0, k=0;
    vector<int> v(1,1);

    while(v.size() < n){
        int next = min(v[i]*2, v[j]*3, v[k]*5);
        if (next == v[i]*2) i++;
        if (next == v[j]*3) j++;
        if (next == v[k]*5) k++;
        v.push_back(next);
    }
    return v.back();
}

int nthUglyNumber01(int n) {

    int i=0, j=0, k=0;
    vector<int> v(1,1);

    while(v.size() < n){
        int next = min(v[i]*2, v[j]*3, v[k]*5);
        if (next == v[i]*2) i++;
        if (next == v[j]*3) j++;
        if (next == v[k]*5) k++;
        v.push_back(next);
    }
    return v.back();
}

// This version just uses the static variable to cache
// the 3 indics and the ugly number list
int nthUglyNumber02(int n) {

    static int i=0, j=0, k=0;
    static vector<int> v(1,1);

    if (v.size()>=n) return v[n-1];

    while(v.size() < n){
        int next = min(v[i]*2, v[j]*3, v[k]*5);
        if (next == v[i]*2) i++;
        if (next == v[j]*3) j++;
        if (next == v[k]*5) k++;
        v.push_back(next);
    }
    return v.back();
}

int nthUglyNumber(int n) {
    return nthUglyNumber02(n); // 4ms-8ms
    return nthUglyNumber01(n); // 28ms
}
};
