/**********************************************************************************
*
* Given a binary tree, return the postorder traversal of its nodes' values.
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
* return [3,2,1].
*
* Note: Recursive solution is trivial, could you do it iteratively?
*
**********************************************************************************/

#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <iostream>
#include <vector>
#include <algorithm>
using namespace std;

struct TreeNode {
    int val;
    TreeNode *left;
    TreeNode *right;
    TreeNode(int x) : val(x), left(NULL), right(NULL) {}
};



vector<int> postorderTraversal1(TreeNode *root) {
    vector<int> v;
    vector<TreeNode*> stack;
    if (root) {
        stack.push_back(root);
    }
    while (stack.size()>0){
        TreeNode *n = stack.back();
        stack.pop_back();
        v.push_back(n->val);
        if (n->left){
            stack.push_back(n->left);
        }
        if (n->right) {
            stack.push_back(n->right);
        }
    }
    std::reverse(v.begin(), v.end());  // the trick
    return v;
}

// traditional and standard way.
// using the stack to simulate the recursive function stack.
vector<int> postorderTraversal2(TreeNode *root) {
    vector<int> v;
    vector<TreeNode*> stack;
    TreeNode *node = root;
    TreeNode *lastVisitNode = NULL;
    while(stack.size()>0 || node!=NULL){

        if (node != NULL){
            // keep going the left
            stack.push_back(node);
            node = node->left;
        }else{
            TreeNode *n = stack.back();
            // left way is finsised, keep going to the right way
            if (n->right != NULL && lastVisitNode != n->right){
                node = n->right;
            }else{
                // both left and right has been accessed.
                stack.pop_back();
                v.push_back(n->val);
                lastVisitNode = n;
            }
        }
    }
    return v;
}
