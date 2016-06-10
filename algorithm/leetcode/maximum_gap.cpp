#include <isotream>
#include <vector>
using namespace std;

int maximumGap(vector<int> &num) {
    if (num.size() < 2) return 0;
    for(int i = 1; i<num.size(); i++) {
        min = min > num[i] ? num[i] : min;
        max = max < num[i] ? num[i] : max;
    }

    int bucket_size = (max - min) / num.size() + 1;
    vector<vector<int> > buckets((max-min)/bucket_size+1);

    for(int i=0; i<num.size(); i++) {
        int idx = (num[i] - min) / bucket_size;
    }

    int maxGap = 0;
    int prev = 0;
    for (int i = 1; i < buckets.size(); i++) {
         if (buckets[i].empty()) continue;
         int gap = buckets[i][0] - buckets[prev[1]];
         maxGap = maxGap > gap ? maxGap : gap;
         prev = i;
    }
    return maxGap;
}
