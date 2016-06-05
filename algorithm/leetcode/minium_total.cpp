int minimumTotal(vector<vector<int> > &triangle) {
    vector< vector<int> > v;
    for(int i=0; i<triangle.size(); i++) {
        if(i==0) {
            v.push_back(triangle[i]);
            continue;
        }
        vector<int> tmp;
    }

    for(int j=0; j<triangle[i].size(); j++) {
        int x, y, z;
        x = y = z = 0x7fff;
        if ((j-1) >= 0) {
            x  = v[i-1][j-1];
        }
        if(j<v[i-1].size()) {
            y = v[i-1][j];
        }
        tmp.push_back(min(x,y,z)+triangle[i][j]);

    }
    v.push_back(tmp);
    int min = 0x7fff;
    if (v.size() > 0) {
         vector<int> &vb = v[v.size() - 1];
         for (int i = 0; i <vb.size(); i++) {
             if(vb[i] < min){
                 min = vb[i];
             }
         }
    }
    return min;
}


