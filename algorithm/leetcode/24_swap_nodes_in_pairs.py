from itertools import chain
a = [1,2,3,4,5,6,7]
b = a[0::2]
c = a[1::2]

if len(a) % 2 == 0:
    print reduce(lambda l, (x,y): l + [x, y], zip(c, b), [])
else:
    print reduce(lambda l, (x,y): l + [x, y], zip(c, b), []) + [a[-1]]

class Solution {
public:
    Solution(){
        srand(time(NULL));
    }
    /*
     * Here we have two ways to solve this problem:
     * 1) keep the list's nodes no change. only swap the data in the list node.
     * 2) swap the list node physically.
     */
    ListNode *swapPairs(ListNode *head) {
        if(random()%2){
            return swapPairs1(head);
        }
        return swapPairs2(head);
    }
    /*just swap the node's value instead of node*/
    ListNode *swapPairs1(ListNode *head) {
        for (ListNode *p = head; p && p->next; p = p->next->next) {
            int n = p->val;
            p->val = p->next->val;
            p->next->val = n;
        }
        return head;
    }
    /*swap the list nodes physically*/
    ListNode *swapPairs2(ListNode *head) {
        ListNode *h = NULL;
        //using `*p` to traverse the linked list
        for (ListNode *p = head; p && p->next; p = p->next) {
            //`n` is `p`'s next node, and swap `p` and `n` physcially
            ListNode *n = p->next;
            p->next = n->next;
            n->next = p;
            //using `h` as `p`'s previous node
            if (h){
                h->next = n;
            }
            h=p;

            //determin the really 'head' pointer
            if (head == p){
                head = n;
            }
        }

        return head;
    }
};
