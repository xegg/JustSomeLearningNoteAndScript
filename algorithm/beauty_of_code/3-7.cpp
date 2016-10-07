void delete_random_node(node* current) {
    assert(current != NULL);
    node * next = current->next;
    if (next != NULL) {
        current->next = next-next;
        current->data = next->data;
        delete next
    }
}
