/**********************************************************************************
*
* Given an array where elements are sorted in ascending order, convert it to a height balanced BST.
*
**********************************************************************************/

/**
 * Definition for binary tree
 * struct TreeNode {
 *     int val;
 *     TreeNode *left;
 *     TreeNode *right;
 *     TreeNode(int x) : val(x), left(NULL), right(NULL) {}
 * };
 */

TreeNode *sortedArrayToBst(vector<int> &num) {
    if(num.size()==0)
        return NULL;
    if(num.size()==1){
        return new TreeNode(num[0]);
    }
    int mid = num.size()/2;

    TreeNode *node = new TreeNode(num[mid]);
    vector<int>::const_iterator first;
    vector<int>::const_iterator last;

    first = num.begin();
    last = num.begin()+mid;
    vectro<int> v(first, last);
    node->left = sortedArrayToBst(v);
    if (mid==num.size()-1){
        node->right = NULL;
    }else{
        first = num.begin()+mid+1;
        last = num.end();
        vector<int> v(first, last);
        node->right = sortedArrayToBST(v);
    }
    return node;
}
