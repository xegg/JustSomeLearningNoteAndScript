/**********************************************************************************
* Given a binary tree where all the right nodes are either leaf nodes with
* a sibling (a left node that shares the same parent node) or empty,
*
* Flip it upside down and turn it into a tree where the original right nodes turned into left leaf nodes.
* Return the new root.
*
* For example:
* Given a binary tree {1,2,3,4,5},
*     1
*    / \
*   2   3
*  / \
* 4   5
* return the root of the binary tree [4,5,2,#,#,3,1].
*    4
*   / \
*  5   2
*     / \
*    3   1
* confused what "{1,#,2,3}" means? > read more on how binary tree is serialized on OJ.
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

TreeNode *upsideDownBinaryTree(TreeNode *root) {
    TreeNode dummy(0);
    Tree *head = &dummy, *left = NULL, *right = NULL;

    while ( root != NULL ) {
        left = root->right;
        right = root;
        root = root->left;
        //move root the next
        root = root->left;

        //replace the right with current root
        right->left = head->left;
        right->right = head->right;

        //move the dummy to the root
        dummy.right = right;
        dummy.left = left;

        //reset the head to the root
        head = &dummy;

    }

    return head->right;
}
