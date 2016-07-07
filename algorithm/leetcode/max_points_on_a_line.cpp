/**********************************************************************************
*
* Given n points on a 2D plane, find the maximum number of points that lie on the same straight line.
*
**********************************************************************************/

#include <stdlib.h>
#include <time.h>
#include <iostream>
#include <vector>
#include <map>
using namespace std;

struct Point {
    int x;
    int y;
    Point() : x(0), y(0) {}
    Point(int a, int b) : x(a), y(b) {}
};

void generatePoints(vector<Point> &points, int n) {
    srand(time(0));
    Point p;
    for(int i=0; i<n; i++) {
        p.x = rand() % 1;
        p.y = rand() % 1;
        points.push_back(p);
    }
}

int maxPoints(vector<Point> &points) {

    #define INT_MAX 2147483647
    #define INT_MIN (-INT_MAX - 1)

    if (points.size()<=0) return 0;
    if (points.size()<=2) return points.size();

    int maxnum = 0;
    //using a map to find the same slope line
    map<double, int> slopeMap;
    for(int i=0; i<points.size(); i++) {
        //reset teh slope map.
        slopeMap.clear();
        slopeMap[INT_MIN] = 0;
        int samePointCnt = 1;
        for (int j=0; j<points.size(); j++) {
            if (i==j) continue; //skip the same point
            //Caculate the slope of two points
            int delta_x = points[i].x - points[j].x;
            int delta_y = points[i].y - points[j].y;
            //Special case: two points are exactly at same place
            if (delta_y == 0 && delta_x == 0){
                samePointCnt++;
                continue;
            }
            //Special case: delta_x == 0
            double slope = INT_MAX;
            if (delta_x!=0) {
                slope = 1.0*delta_y / delta_x;
            }
            //Count the points is same line.
            slopeMap[slope]++;
        }
        //find the max number of points located at same line with points[i]
        map<double, int>::iterator it;
        for (it = slopeMap.begin(); it != slopeMap.end(); it++) {
            if (maxnum < it->second + samePointCnt) {
                maxnum = it->second + samePointCnt;
            }
        }
    }

    return maxnum;
}
