
/**********************************************************************************
*
* Given a binary tree, determine if it is a valid binary search tree (BST).
*
* Assume a BST is defined as follows:
*
* The left subtree of a node contains only nodes with keys less than the node's key.
* The right subtree of a node contains only nodes with keys greater than the node's key.
* Both the left and right subtrees must also be binary search trees.
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

#include <iostream>
#include <vector>
using namespace std;


struct TreeNode {
    int val;
    TreeNode *left;
    TreeNode *right;
    TreeNode(int x) : val(x), left(NULL), right(NULL) {}
};

bool isValidBST(TreeNode *root) {

    //travel the tree by inner-order
    vector<TreeNode*> stack;
    TreeNode* node = root;
    vector<int> v;
    while (stack.size()>0 || node!=NULL) {
        if (node!=NULL){
            stack.push_back(node);
            node = node->left;
        }else{
            node = stack.back();
            stack.pop_back();
            v.push_back(node->val);
            node = node->right;
        }
    }

    //check the vector wehther sorted or not
    for(int i=0; v.size()>0 && i<v.size()-1; i++){
        if (v[i] >= v[i+1]) {
            return false;
        }
    }

    return true;
}

