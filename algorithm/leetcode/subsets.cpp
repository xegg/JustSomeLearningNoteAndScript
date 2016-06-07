#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <iostream>
#include <vector>
#include <algorithm>
using namespace std;

vector<vector<int> > subsets(vector<int> &S) {
    vector<vector<int> > result;
    for(int i=0; i<=S.size(); i++) {
        vector<vector<int> > r = combine(S, i);
        result.insert(result.end(), r.begin(), r.end());
    }
    return result;
}

vector<vector<int> > combine(vector<int>& v, int k) {
    if (random() % 2){
        cout << "recusive method!" << endl;
        return combine1(v, k);
    }
    return combine2(v, k);
}
