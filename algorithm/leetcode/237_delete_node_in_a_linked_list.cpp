
class Solution {
public:
    //becasue the deleted is not the tail.
    //So, we can move the content of next node to this one, and delete the next one
    void deleteNode(ListNode* node) {
        node->val = node->next->val;
        node->next = node->next->next;
    }
