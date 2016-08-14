/**********************************************************************************
*
* Given a binary tree, return the level order traversal of its nodes' values.
* (ie, from left to right, level by level).
*
* For example:
* Given binary tree {3,9,20,#,#,15,7},
*
*     3
*    / \
*   9  20
*     /  \
*    15   7
*
* return its level order traversal as:
*
* [
*   [3],
*   [9,20],
*   [15,7]
* ]
*
* confused what "{1,#,2,3}" means? > read more on how binary tree is serialized on OJ.
*
* OJ's Binary Tree Serialization:
*
* The serialization of a binary tree follows a level order traversal, where '#' signifies
* a path terminator where no node exists below.
*
* Here's an example:
*
*    1
*   / \
*  2   3
*     /
*    4
*     \
*      5
*
* The above binary tree is serialized as "{1,2,3,#,#,4,#,#,5}".
*
*
**********************************************************************************/

#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#include <iostream>
#include <vector>
#include <queue>
using namespace std;


struct TreeNode {
    int val;
    TreeNode *left;
    TreeNode *right;
    TreeNode(int x) : val(x), left(NULL), right(NULL) {}
};


vector<vector<int> > levelOrder1(TreeNode *root) {
    queue<TreeNode*> q;
    vector< vector<int> > vv;
    vector<int> v;
    if (root){
        v.push_back(root->val);
        vv.push_back(v);
    }
    q.push(root);
    int i=0;
    vector<TreeNode*> vt;
    while(q.size()>0){
        TreeNode *p = q.front();
        q.pop();
        vt.push_back(p);
        if ( p==NULL ) {
            continue;
        }
        q.push(p->left);
        q.push(p->right);
    }


    int step = 2;
    int j;
    for (int i=1; i<vt.size(); i=j ){
        v.clear();

        int cnt=0;
        for (j=i; j<i+step && j<vt.size(); j++){
            if (vt[j]) {
                v.push_back(vt[j]->val);
                cnt += 2;
            }
        }
        step = cnt;
        if (v.size()>0) {
            vv.push_back(v);
        }
    }

    return vv;
}

vector<vector<int> > levelOrder2(TreeNode *root) {
    vector< vector<int> > vv;
    vector<int> v;
    if (root){
        v.push_back(root->val);
        vv.push_back(v);
    }

    vector< vector<int> > vv_left, vv_right;
    if(root && root->left) {
        vv_left = levelOrder2(root->left);
    }
    if(root && root->right) {
        vv_right = levelOrder2(root->right);
    }

    //merge
    for(int i=0; i<vv_left.size() || i < vv_right.size(); i++){
        if (i<vv_left.size() && i<vv_right.size()){
            vv_left[i].insert(vv_left[i].end(), vv_right[i].begin(), vv_right[i].end());
            vv.push_back(vv_left[i]);
        }else if (i<vv_left.size()) {
            vv.push_back(vv_left[i]);
        }else {
            vv.push_back(vv_right[i]);
        }
    }

    return vv;
}

vector<vector<int> > levelOrder3(TreeNode *root) {
    vector< vector<int> > vv;
    if(root == NULL) return vv;

    int level = 0; // current level.
    TreeNode *last = root; // last node of currrent level.
    queue<TreeNode*> q;

    q.push(root);
    vv.push_back(vector<int>());
    while(!q.empty()) {
        TreeNode *p = q.front();
        q.pop();

        vv[level].push_back(p->val);
        if(p->left ) q.push(p->left);
        if(p->right) q.push(p->right);

        if(p == last) {
            level++;
            last = q.back();
            vv.push_back(vector<int>()); // new buffer for next row.
        }
    }
    vv.pop_back();

    return vv;
}

