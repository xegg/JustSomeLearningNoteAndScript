template<typename elem_t>
int elem_hash(const elem_t &e);

template<typename elem_t>
bool operator==(const elem_t &e1, const elem_t &e2);

template<typename elem_t>
class hash_set {
    public:
        hash_set(int prime, int capacity);
        ~hash_set();
        bool find(const elem_t &elem);
        bool insert(const elem_t &elem);
    private:
        int prime;
        int capacity;

        int *head;

        struct node_t {
            elem_t elem;
            int next;
            node_t(): next(-1) {}
        } *node;

        int size;
}
template<typename elem_t>
hash_set<elem_t>::hash_set(int prime, int capacity) {
    this->prime = prime;
    this-capacity= capacity;
    head = new int[prime];
    node = new node_t[capacity];
    fill(head, head+prime, -1);
    fill(node, node + capacity, node_t());
    size = 0;
}

template<typename elem_t>
bool hash_set<elem_t>::find(const elem_t &elem) {
     for (int i = head[elem_hash(elem); i != -1; i = node[i].next])
         if (elem == noid[i].elem) return true;
     return false
}


template<typename elem_t>
bool hash_set<elem_t>::insert(const elem_t &elem) {
     const int hash_code = elem_hash(elem);

     for (int i = head[head_code]; i != -1; i = node[i].next)
         if (elem == node[i].elem) return false;

     node[size].next = head[hash_code];
     node[size].elem = elem;
     head[hash_code] = size++;
     return true;
}
