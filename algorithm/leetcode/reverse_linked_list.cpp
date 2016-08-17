/**********************************************************************************
 *
 * Reverse a singly linked list.
 *
 * click to show more hints.
 *
 * Hint:
 * A linked list can be reversed either iteratively or recursively. Could you implement both?
 *
 *
 **********************************************************************************/


/**
 * Definition for singly-linked list.
 * struct ListNode {
 *     int val;
 *     ListNode *next;
 *     ListNode(int x) : val(x), next(NULL) {}
 * };
 */
class Solution {
public:
    ListNode* reverseList_iteratively(ListNode* head) {
        ListNode *h=NULL, *p=NULL;
        while (head){
            p = head->next;
            head->next = h;
            h = head;
            head = p;
        }
        return h;
    }
    ListNode* reverseList_recursively(ListNode* head) {
        if (head==NULL || head->next==NULL) return head;
        ListNode *h = reverseList_recursively(head->next);
        head->next->next = head;
        head->next = NULL;
        return h;

    }
};



/**********************************************************************************
*
* Reverse a linked list from position m to n. Do it in-place and in one-pass.
*
* For example:
* Given 1->2->3->4->5->NULL, m = 2 and n = 4,
*
* return 1->4->3->2->5->NULL.
*
* Note:
* Given m, n satisfy the following condition:
* 1 ≤ m ≤ n ≤ length of list.
*
*
**********************************************************************************/

#include <stdio.h>
#include <stdlib.h>
#include <time.h>

struct ListNode {
    int val;
    ListNode *next;
    ListNode(int x) : val(x), next(NULL) {}
};


ListNode *reverseBetween(ListNode *head, int m, int n) {

    if (head==NULL || m>=n) return head;

    ListNode fake(0);
    fake.next = head;
    ListNode *pBegin=&fake, *pEnd=&fake;

    int distance = n - m ;
    while(pEnd && distance>0){
        pEnd = pEnd->next;
        distance--;
    }
    while(pBegin && pEnd && m-1>0) {
        pBegin = pBegin->next;
        pEnd = pEnd->next;
        m--;
    }
    if (pBegin==NULL || pEnd==NULL || pEnd->next == NULL){
        return head;
    }

    ListNode *p = pBegin->next;
    ListNode *q = pEnd->next->next;

    ListNode *pHead = q;
    while(p != q){
        ListNode* node = p->next;
        p->next = pHead;
        pHead = p;
        p = node;
    }
    pBegin->next = pHead;

    return fake.next;

}
