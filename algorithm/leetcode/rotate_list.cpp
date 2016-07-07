ListNode *rotateRight(ListNode *head, int k) {
        if (!head || k<=0){
            return head;
        }
        int len=1;
        ListNode *p=head;
        while( p->next != NULL ){
            p = p->next;
            len++;
        }
        //connect the tail to head
        p->next = head;
        //find the left place (take care the case - k > len)
        k = len - k % len;

        //find the place
        for(int i=0; i<k; i++){
            p = p->next;
        }

        //break the list
        head = p->next;
        p->next = NULL;

        return head;

}
