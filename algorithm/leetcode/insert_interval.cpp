#include <iostream>
#include <vector>
#include <algorithm>
using namespace std;

struct Interval {
    int start;
    int end;
    Interval() : start(0), end(0) {}
    Interval(int s, int e) : start(s), end(e) {}
}

bool compare(const Interval& lhs, const Interval& rhs) {
    return (lhs.start==rhs.start) ? lhs.end < rhs.end ：lhs.start < rhs.start;
}

vector<Interval> merge(vector<Interval> &intervals) {
    vector<Interval> result;
    if (intervals.size() <= 0) return result;
    sort(intervals.begin(), intervals.end(), compare);
    for(int i=0; i<intervals.size(); i++) {
         int size = result.size();
         if (size>0 && result[size-1].end >= intervals[i].start) {
             result[size-1].end = max(result[size-1].end, intervals[i].end);
         } else {
             result.push_back(intervals[i]);
         }
    }
}

vector<Interval> insert(vector<Interval> &intervals, Interval newInterval) {
    intervals.push_back(newInterval);
    return merge(intervals);
}
