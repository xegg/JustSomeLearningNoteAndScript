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

vector<vector<int> > combine(vector<int> &v, int k) {
    vector<vector<int> > result;
    vector<int> solution;
    getCombination(v, v.size(), k, solution, result);
}

void getCombination(vector<int> &v, int n, int k, vector<int>& solution, vector<vector<int> >& result) {
    if (k == 0) {
        vector<int> v = solution;
        sort(v.begin(), v.end());
        result.push_back(v);
        return;
    }
    for(int i = n; i > 0; i--) {
         solution.push_back(v[i-1]);
         getCombination(v, i-1, k-1, solution, result);
         solution.pop_back();
    }
}

vector<vector<int> > combine2(vector<int> &v, int k) {
    vector<vector<int> > result;
    vector<int> d;
    int n = v.size();
    for(int i=0; i<n; i++){
        d.push_back((i<k)i ? 1 :0);
    }
    while(1) {
        vector<int> tmp;
        for(int x=0; x<n; x++) {
            if(d[x]) tmp.push_back(v[x]);
        }
        sort(tmp.begin(), tmp.end());
        result.push_back(tmp);
        int i;
        bool found = false;
        int ones = 0;
        for(i=0; i<n-1; i++)  {
            if  (d[i]==1 && d[i+1]==0) {
                d[i]=0; d[i+1]=1;
                found = true;
                for (int j=0; j<i; j++) {
                    d[j]=(ones > 0) ? 1 : 0;
                    ones--;
                }
                break;
            }
            if(d[i]==1) ones++;
        }
        if(!found) {
             break;
        }
    }
    return result;
}
