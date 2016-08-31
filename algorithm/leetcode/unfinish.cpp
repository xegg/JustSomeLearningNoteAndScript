/**********************************************************************************
*
* Given a binary tree, return the zigzag level order traversal of its nodes' values.
* (ie, from left to right, then right to left for the next level and alternate between).
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
* return its zigzag level order traversal as:
*
* [
*   [3],
*   [20,9],
*   [15,7]
* ]
*
* confused what "{1,#,2,3}" means? > read more on how binary tree is serialized on OJ.
*
* OJ's Binary Tree Serialization:
*
* The serialization of a binary tree follows a level order traversal,
* where '#' signifies a path terminator where no node exists below.
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

vector<TreeNode*> TreeToArray_level_order(TreeNode* root);

vector<vector<int> > zigzagLevelOrder(TreeNode *root) {
    if (random()%2){
        return zigzagLevelOrder1(root);
    }
    return zigzagLevelOrder2(root);
}

vector<vector<int> > zigzagLevelOrder1(TreeNode *root) {
    vector<vector<int> > result;
    vector<TreeNode*> tree = TreeToArray_level_order(root);

    int curLevelCnt = 1;
    int nextLevelCnt = 1;
    int level=0;

    for (int i=0; i<tree.size(); i+=curLevelCnt ){
        int cnt=0;
        level++;
        vector<int> v;
        if (level%2==0){
            for(int j=i+nextLevelCnt-1; j>=i; j--){
                if (tree[j]){
                    cnt += 2;
                    v.push_back(tree[j]->val);
                }
            }
        }else{
            for(int j=i; j<i+nextLevelCnt; j++){
                if (tree[j]){
                    cnt += 2;
                    v.push_back(tree[j]->val);
                }
            }
        }
        curLevelCnt = nextLevelCnt;
        nextLevelCnt = cnt;
        if (v.size()>0){
            result.push_back(v);
        }
    }
    return result;
}

vector<TreeNode*> TreeToArray_level_order(TreeNode* root){
    vector <TreeNode*> result;

    queue<TreeNode*> q;
    q.push(root);
    while (q.size()>0) {
        TreeNode* n = q.front();
        q.pop();
        result.push_back(n);
        if (n==NULL){
            //cout << "# ";
            continue;
        }
        //cout << n->val << " ";
        q.push(n->left);
        q.push(n->right);
    }
    //cout << endl;
    return result;
}

vector<vector<int> > zigzagLevelOrder2(TreeNode *root) {
    vector<vector<int> > vv;
    if(root == NULL) return vv;

    int level = 0;
    TreeNode *last = root;
    queue<TreeNode*> q;

    q.push(root);
    vv.push_back(vector<int>());
    while(!q.empty()) {
        TreeNode *p = q.front();
        q.pop();

        vv[level].insert(level%2 ? vv[level].begin() : vv[level].end(), p->val);
        if(p->left) q.push(p->left);
        if(p->right) q.push(p->right);

        if(p == last) {
            level++;
            last = q.back();
            vv.push_back(vector<int>());
        }
    }
    vv.pop_back();

    return vv;
}

void printTree_level_order(TreeNode *root)
{
    queue<TreeNode*> q;
    q.push(root);
    while (q.size()>0){
        TreeNode* n = q.front();
        q.pop();
        if (n==NULL){
            cout << "# ";
            continue;
        }
        cout << n->val << " ";
        q.push(n->left);
        q.push(n->right);
    }
    cout << endl;
}


/***************************************************************************************
 *
 * Serialization is the process of converting a data structure or object into a
 * sequence of bits so that it can be stored in a file or memory buffer, or transmitted
 * across a network connection link to be reconstructed later in the same or another
 * computer environment.
 *
 * Design an algorithm to serialize and deserialize a binary tree. There is no
 * restriction on how your serialization/deserialization algorithm should work. You
 * just need to ensure that a binary tree can be serialized to a string and this string
 * can be deserialized to the original tree structure.
 *
 * For example, you may serialize the following tree
 *
 *     1
 *    / \
 *   2   3
 *      / \
 *     4   5
 *
 * as "[1,2,3,null,null,4,5]", just the same as how LeetCode OJ serializes a binary
 * tree. You do not necessarily need to follow this format, so please be creative and
 * come up with different approaches yourself.
 *
 * Note: Do not use class member/global/static variables to store states. Your
 * serialize and deserialize algorithms should be stateless.
 *
 * Credits:Special thanks to @Louis1992 for adding this problem and creating all test
 * cases.
 *
 ***************************************************************************************/

#include <iostream>
#include <sstream>
#include <vector>
#include <string>
using namespace std;

/**
 * Definition for a binary tree node.
 */

struct TreeNode {
    int val;
    TreeNode *left;
    TreeNode *right;
    TreeNode(int x) : val(x), left(NULL), right(NULL) {}
};


class Codec {

public:
    // Encodes a tree to a single string.
    string serialize(TreeNode* root) {
        return serialize02(root);
        return serialize01(root);
    }

    // Decodes your encoded data to tree.
    TreeNode* deserialize(string data) {
        return deserialize02(data);
        return deserialize01(data);
    }


/*
 * ===============================================================================
 *  Using pre-order to serialize and deserialize the tree.
 * ===============================================================================
 */
public:
    // Encodes a tree to a single string.
    string serialize01(TreeNode* root) {
         string result;
         vector<TreeNode*> v;
         serializeHelper(root, v);
         for(int i=0; i<v.size(); i++){
             result = result + (v[i]==NULL ? "#" : to_string(v[i]->val)) + " ";
         }
         return result;
    }

    // Decodes your encoded data to tree.
    TreeNode* deserialize01(string data) {
        vector<TreeNode*> v;
        split(data, ' ', v);

        int index = 0;
        return deserializeHelper(v, index);

    }

private:

    void serializeHelper(TreeNode* root, vector<TreeNode*>& v) {
        if (root==NULL) {
            v.push_back(NULL);
        }else{
            v.push_back(root);
            serializeHelper(root->left, v);
            serializeHelper(root->right, v);
        }
    }


    TreeNode* deserializeHelper(vector<TreeNode*> &v, int& index) {

        if (index >= v.size() ) return NULL;

        TreeNode* root = v[index++];
        if (root) {
            root->left = deserializeHelper(v, index);
            root->right = deserializeHelper(v, index);
        }
        return root;
    }


   void split(const string &s, char delim, vector<TreeNode*> &elems) {
        stringstream ss(s);
        string item;
        while (getline(ss, item, delim)) {
            TreeNode* node =  (item=="#" ? NULL : new TreeNode( stoi(item)) );
            elems.push_back(node);
        }

    }


/*
 * ===============================================================================
 *  Using sstream instead of vector to improve the performance
 * ===============================================================================
 */

public:
    // Encodes a tree to a single string.
    string serialize02(TreeNode* root) {
        ostringstream out;
        serialize(root, out);
        return out.str();
    }

    // Decodes your encoded data to tree.
    TreeNode* deserialize02(string data) {
        istringstream in(data);
        return deserialize(in);
    }

private:
   void serialize(TreeNode* root, ostringstream& out) {
        if (root==NULL) {
            out << "# ";
            return;
        }
        out << root->val << " ";
        serialize(root->left, out);
        serialize(root->right, out);
    }

    TreeNode* deserialize(istringstream& in) {
        string val;
        in >> val;
        if (val == "#" || val.empty() ) return NULL;

        TreeNode* node = new TreeNode(stoi(val));
        node->left = deserialize(in);
        node->right = deserialize(in);
        return node;
    }
};


