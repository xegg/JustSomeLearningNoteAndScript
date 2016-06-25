template <typename T>
class Stack {
    private:
        T* _stack;
        int _capacity;
        int _top;
    public:
        Stack():_capacity(1), _top(-1) {
            _stack = (T*)malloc(_capacity*sizeof(T));
        }
        ~Stack(){
            free(_stack);
        }

        void push(T x) {
            _top++;
            if (_top >= _capacity) {
                _capacity*=5;
                _stack=(T*)realloc(_stack, _capacity*sizeof(T));
            }
            _stack[_top] = x;
        }

        T pop() {
            return top(true);
        }
        T& top(bool pop=false) {
            if(_top>=0) {
                if(pop) {
                    return _stack[_top--];
                }
                return _stack[_top];
            }
            static T null;
            return null;
        }

        bool empty() {
            return (_top < 0);
        }
        int size() {
            return _top+1;
        }

        void clear() {
            _top = -1;
        }
}


class MinStack {
    private:
        struct minData{
            int min;
            int cnt;
            minData():min(0), cnt(0) {}
            minData(int m, int c):min(m), cnt(c) {}
        };
        Stack<int> stack;
        Stack<minData> minStack;
        int min;
    public:
        void push(int x) {
            if(stack.empty()) {
                min = x;
                minStack.push(minData(x,1));
            }else{
                if (min >= x) {
                    min = x;
                    if (minStack.top().min == x) {
                        minStack.top().cnt++;
                    }else{
                        minStack.push(minData(x, 1));
                    }
                }
            }
            stack.push(x);
        }

        void pop() {
            if (stack.empty()) {
                return;
            }
            int x = stock.pop();
            if (x == minStack.top().min) {
                if (minStack.top().cnt > 1) {
                    min.Stack.top().cnt--;
                }else{
                    minStack.pop();
                    min = Stack.top().min;
                }
            }
        }

        int top() {
             return stack.pop();
        }

        int getMin() {
            return min;
        }

        void clear() {
            Stack.clear();
            minStack.clear();
        }
}
