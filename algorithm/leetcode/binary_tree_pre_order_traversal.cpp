/**********************************************************************************
*
* Given a binary tree, return the preorder traversal of its nodes' values.
*
* For example:
* Given binary tree {1,#,2,3},
*
*    1
*     \
*      2
*     /
*    3
*
* return [1,2,3].
*
* Note: Recursive solution is trivial, could you do it iteratively?
*
**********************************************************************************/

#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <iostream>
#include <vector>
using namespace std;

struct TreeNode {
    int val;
    TreeNode *left;
    TreeNode *right;
    TreeNode(int x) : val(x), left(NULL), right(NULL) {}
};


vector<int> preorderTraversal1(TreeNode *root) {
    vector<int> v;
    vector<TreeNode*> stack;
    if (root) {
        stack.push_back(root);
    }
    while (stack.size()>0){
        TreeNode* n = stack.back();
        v.push_back(n->val);
        stack.pop_back();
        if (n->right){
            stack.push_back(n->right);
        }
        if (n->left){
            stack.push_back(n->left);
        }
    }
    return v;
}

vector<int> preorderTraversal2(TreeNode *root) {
    vector<int> v;
    vector<TreeNode*> stack;
    stack.push_back((TreeNode*)NULL);
    TreeNode *top = root;
    while(top!=NULL){
        v.push_back(top->val);
        if (top->right !=NULL){
            stack.push_back(top->right);
        }

        if (top->left != NULL){
            stack.push_back(top->left);
        }

        top = stack.back();
        stack.pop_back();
    }
    return v;
}
