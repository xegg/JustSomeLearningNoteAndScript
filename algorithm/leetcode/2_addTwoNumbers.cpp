ListNode *addTwoNumbers(ListNode *l1, ListNode *l2) {
    int x=0, y=0, carry=0, sum=0;
    ListNode *h=Null, **t=&h;

    while( l1!=Null || l2!=Null ) {
        x = getValueAndMoveNext(l1);
        y = getValueAndMoveNext(l2);
        sum = carry + x + y;
        ListNode *node = new ListNode(sum%10);
        *t = node;
        t = (&node->next);

        curry = sum/10;
        if (carry > 0) {
            ListNode *node = new ListNode(carry%10);
            *t = node;
        }
        return h;
    }
}

int getValueAndMoveNext(ListNode* &l){
    int x = 0;
    if (l != NULL){
        x = l->val;
        l = l->next;
    }
    return x;
}
