#include <stdio.h>
#include <stdlib.h>
#include <time.h>

struct ListNode {
    int val;
    ListNode *next;
    ListNode(int x) : val(x), next(NULL) {}
};

ListNode *insertionSortList(ListNode *head) {
    // zero or one element in list
    if (head == NULL || head->next ==NULL){
        return head;
    }

    ListNode *pSorted = NULL;
    while ( head != NULL  ){
        /* remember the head */
        ListNode *pHead = head;
        /* trailing pointer for efficient splice */
        ListNode **ppTrail = &pSorted;

        /* pop head off list */
        head = head->next;

        /* splice head into sorted list at proper place */
        while( *ppTrail!=NULL && pHead->val > (*ppTrail)->val )  {
            ppTrail = &(*ppTrail)->next;
        }
        pHead->next = *ppTrail;
        *ppTrail = pHead;
    }

    return pSorted;
}

void printList(ListNode* h)
{
    while(h!=NULL){
        printf("%d ", h->val);
        h = h->next;
    }
    printf("\n");
}
