a = [1,2,3,4,5]
def remove_nth_from_list(l, n):
    if n == 1:
        return l[:-n]
    elif n == 0:
        return l
    elif:
        return l[:-n] + l[-(n+1):]


ListNode *removeNthFromEnd(ListNode *head, int n) {
    if (head==NULL || n<=0){
        return NULL;
    }
    ListNode fakeHead(0);
    fakeHead.next=head;
    head=&fakeHead;

    ListNode *p1, *p2;
    p1=p2=head;
    for(int i=0; i<n; i++){
        if (p2==NULL) return NULL;
        p2=p2->next;
    }
    while (p2->next!=NULL){
        p2=p2->next;
        p1=p1->next;
    }

    p1->next = p1->next->next;
    return head->next;
}
