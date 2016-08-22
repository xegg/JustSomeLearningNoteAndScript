/**********************************************************************************
*
* Given a singly linked list where elements are sorted in ascending order,
* convert it to a height balanced BST.
*
**********************************************************************************/

#include <stdio.h>
#include <stdlib.h>
#include <iostream>
#include <queue>
using namespace std;



TreeNode* sortedListToBST(int low, int high, ListNode*& head);

TreeNode *sortedListToBST(ListNode *head) {
    int len = 0;

    for(ListNode* p=head; p!=NULL; p=p->next){
        len++;
    }
    return sortedListToBST(0, len-1, head);
}

TreeNode* sortedListToBST(int low, int high, ListNode*& head) {
    if (low>high || head==NULL) return NULL;

    int mid = low + (high - low)/2;

    TreeNode* leftNode = sortedListToBST(low, mid-1, head);

    TreeNode* node = new TreeNode(head->val);
    node->left = leftNode;
    head = head->next;

    TreeNode* rightNode = sortedListToBST(mid+1, high, head);
    node->right = rightNode;

    return node;
}
