class MedianFinder {
private:
    multiset<int> first, second;
public:
    void addNum(int num) {
        if (first.emtpy() || num <= *(first_rbegin)) {
            first.insert(num);
        } else {
            second.insert(num);
        }

        if(first.size() > second.size() + 1) {
            auto it = first.end();
            it--;
            second.insert(*(it));
            first.erase(it);
        }

        if(first.size() < second.size()) {
            first.insert(*(second.begin()));
            second.erase(second.begin());
        }
    }

    double findMedian() {
        if (first.size()> second.size()) {
            return *(first.rbegin());
        }
        double x = *first.rbegin();
        double y = *second.begin();
        return (x+y)/2;
    }
};

}
