/**********************************************************************************
 *
 * Implement a basic calculator to evaluate a simple expression string.
 *
 * The expression string contains only non-negative integers, +, -, *, / operators and empty spaces  .
 * The integer division should truncate toward zero.
 *
 * You may assume that the given expression is always valid.
 *
 * Some examples:
 *
 * "3+2*2" = 7
 * " 3/2 " = 1
 * " 3+5 / 2 " = 5
 *
 * Note: Do not use the eval built-in library function.
 *
 * Credits:Special thanks to @ts for adding this problem and creating all test cases.
 **********************************************************************************/
#include <iostream>
#include <sstream>
#include <string>
#include <stack>
using namespace std;

/*
 * Acuatlly, everything I've already implemented in "Basic Calculator"(RPN way and Design pattern way).
 * So, here, I just use the quick-dirty way - just like the "two stacks solution" in "Basic Calulator".
 */


//Quick & Dirty Solution
bool isOperator(const char ch) {
    return (ch=='+' || ch=='-' || ch=='*' || ch=='/');
}


int Priority(const char c) {
    if (c == '*' || c == '/') {
        return 2;
    } else if (c== '+' || c == '-') {
        return 1;
    } else {
        return 0;
    }
}

long long calculate_exp(long long x, long long y, char op) {
    switch(op) {
        case '+': return x + y;
        case '-': return x - y;
        case '*': return x * y;
        case '/': return x / y;
    }
    return -1;
}


//Two Stacks solution
int calculate_two_stacks(string& s) {

    s += "+0";
    stack<long long> num_stack; //put the number
    stack<char> op_stack; //put the operations

    #define CALCULATE_IT { \
        long long y = num_stack.top(); num_stack.pop(); \
        long long x = num_stack.top(); num_stack.pop(); \
        char op = op_stack.top(); op_stack.pop(); \
        num_stack.push(calculate_exp(x, y, op));\
    }

    for(int i = 0; i < s.size(); i++){
        char ch = s[i];
        if (isspace(ch)) continue;
        if (isdigit(ch)) {
            string num;
            num += s[i];
            while(isdigit(s[i+1])){
                num += s[i+1];
                i++;
            }
            num_stack.push(stoll(num));
            continue;
        }
        if (isOperator(ch)) {
            while (!op_stack.empty() && Priority(op_stack.top()) >= Priority(ch) ) {
                CALCULATE_IT;
            }

            op_stack.push(ch);
        }

    }

    while(!op_stack.empty()){
        CALCULATE_IT;
    }

    return num_stack.top();
}


int calculate(string s) {
    return calculate_two_stacks(s);
}

int main(int argc, char**argv)
{
    string exp = " 3+5 / 2 ";
    if (argc>1) {
        exp = argv[1];
    }

    cout << "\"" << exp << "\" = " << calculate(exp) << endl;

}


/**********************************************************************************
 *
 * Implement a basic calculator to evaluate a simple expression string.
 *
 * The expression string may contain open ( and closing parentheses ), the plus + or minus sign -,
 * non-negative integers and empty spaces  .
 *
 * You may assume that the given expression is always valid.
 *
 * Some examples:
 *
 * "1 + 1" = 2
 * " 2-1 + 2 " = 3
 * "(1+(4+5+2)-3)+(6+8)" = 23
 *
 * Note: Do not use the eval built-in library function.
 *
 *
 **********************************************************************************/
#include <stdlib.h>
#include <ctype.h>
#include <iostream>
#include <string>
#include <stack>
#include <vector>
using namespace std;

/*
 * Sorry, I cannot help using Design Pattern  ;-)
 * (https://en.wikipedia.org/wiki/Interpreter_pattern)
 *
 * Two Stack is cheap, design pattern is powerful!   ;-)
 *
 * But WTF, Memory Limit Exceeded!! Shit!!
 */

class Expression
{
    public:
        virtual int interpret() = 0;
        virtual ~Expression() {};
};

class Number: public Expression
{

    public:
        Number(string num) { this->number = atoi(num.c_str()); }
        ~Number() { }
        int interpret() { return number; }
    private:
        int number;
};

class Plus : public Expression
{
    public:
        Plus(Expression* left, Expression* right) :leftOperand(left), rightOperand(right) { }
        ~Plus() { delete leftOperand; delete rightOperand; }
        int interpret() { return leftOperand->interpret() + rightOperand->interpret(); }
    private:
        Expression* leftOperand;
        Expression* rightOperand;
};

class Minus : public Expression
{
    public:
        Minus(Expression* left, Expression* right) :leftOperand(left), rightOperand(right) { }
        ~Minus() { delete leftOperand; delete rightOperand; }
        int interpret() { return leftOperand->interpret() - rightOperand->interpret(); }
    private:
        Expression* leftOperand;
        Expression* rightOperand;
};

class Multiply : public Expression
{
    public:
        Multiply(Expression* left, Expression* right) :leftOperand(left), rightOperand(right) { }
        ~Multiply() { delete leftOperand; delete rightOperand; }
        int interpret() { return leftOperand->interpret() * rightOperand->interpret(); }
    private:
        Expression* leftOperand;
        Expression* rightOperand;
};

class Divide : public Expression
{
    public:
        Divide(Expression* left, Expression* right) :leftOperand(left), rightOperand(right) { }
        ~Divide() { delete leftOperand; delete rightOperand; }
        int interpret() { return leftOperand->interpret() / rightOperand->interpret(); }
    private:
        Expression* leftOperand;
        Expression* rightOperand;
};

bool isOperator(const string &c) {
    return (c == "+" || c == "-" || c == "*" || c == "/" );
}
bool isOperator(const char &c) {
    return (c == '+' || c == '-' || c == '*' || c == '/');
}

class Evaluator : public Expression
{
    private:
        Expression* syntaxTree;

    public:
        Evaluator(vector<string>& s)
        {
            vector<Expression*> stack;
            for (unsigned int i=0; i < s.size(); i++) {
                if (isOperator(s[i])) {
                    Expression* left  = stack.back(); stack.pop_back();
                    Expression* right = stack.back(); stack.pop_back();
                    switch(s[i][0]) {
                        case '+' :
                            stack.push_back(new Plus(right, left)); break;
                        case '-' :
                            stack.push_back(new Minus(right, left)); break;
                        case '*' :
                            stack.push_back(new Multiply(right, left)); break;
                        case '/' :
                            stack.push_back(new Divide(right, left)); break;
                    }

                }else{
                    stack.push_back(new Number(s[i]));
                }
            }
            syntaxTree = stack.back();
        }
        ~Evaluator() {
            delete syntaxTree;
        }

        int interpret() {
            return syntaxTree->interpret();
        }
};




vector<string> Parse(string& s){
    vector<string> exp;
    for(int i=0; i<s.size(); ){
        char c = s[i];
        string token;
        if (c == '+' || c == '-' || c == '*' || c == '/' || c == '(' || c == ')' ) {
            exp.push_back(token+c);
            i++;
            continue;
        }
        if ( isdigit(c) ) {
            while( isdigit(s[i]) ) {
                token.push_back(s[i++]);
            }
            exp.push_back(token);
            continue;
        }
        i++;
    }
    return exp;
}


int Priority(const string &c) {
    if (c == "*" || c == "/") {
        return 2;
    } else if (c== "+" || c == "-") {
        return 1;
    } else {
        return 0;
    }
}

vector<string> Infix2RPN(vector<string>& infix) {
    vector<string> rpn;
    stack<string> s;

    for(int i = 0; i < infix.size(); i++) {
        if(isdigit(infix[i][0])) { //number
            rpn.push_back(infix[i]);
        } else if (infix[i] == "(") {
            s.push(infix[i]);
        } else if (infix[i] == ")") {
            while(!s.empty() && s.top() != "(") {
                rpn.push_back(s.top());
                s.pop();
            }
            s.pop();
        }else if(isOperator(infix[i]) ){
            while(!s.empty() && Priority(s.top()) >= Priority(infix[i])) {
                rpn.push_back(s.top());
                s.pop();
            }
            s.push(infix[i]);
        }
    }
    while(!s.empty()) {
        rpn.push_back(s.top());
        s.pop();
    }


    return rpn;
}

//Design Pattern for RPN - Memory Limit Exceeded!!
int calculate_RPN_design_pattern(string& s) {
    vector<string> exp = Parse(s);
    //for (int i=0; i<exp.size(); i++){
    //    cout << exp[i] << " ";
    //}
    //cout << endl;
    exp = Infix2RPN(exp);
    for (int i=0; i<exp.size(); i++){
        cout << exp[i] << " ";
    }
    cout << endl;
    Evaluator sentence(exp);
    return sentence.interpret();
}


/*
 *  RPN - Reverse Polish Notation
 *  see:  https://en.wikipedia.org/wiki/Reverse_Polish_notation
 */

//RPN evluation - Memory Limit Exceeded!!
int calculate_RPN_evluation(string& s) {
    vector<string> exp = Parse(s);
    exp = Infix2RPN(exp);

    stack<int> ss;
    for(int i=0; i<exp.size(); i++) {
        if (isdigit(exp[i][0])) {
            ss.push(atoi(exp[i].c_str()));
        }
        if (exp[i]=="+" || exp[i]=="-") {
            int rhs = ss.top(); ss.pop();
            int lhs = ss.top(); ss.pop();
            if (exp[i]=="-") rhs = -rhs;
            ss.push(lhs + rhs);
        }
    }
    return ss.top();
}



//Two stack solution - quick & dirty solution
inline void calculate_two_stacks(stack<int>& num_stack, stack<char>& op_stack) {
    int lhs = num_stack.top(); num_stack.pop();
    int rhs = num_stack.top(); num_stack.pop();
    char op = op_stack.top(); op_stack.pop();
    if (op=='-') rhs = -rhs;
    num_stack.push(lhs + rhs);
}
int calculate_two_stacks(string& s) {
    stack<int> num_stack; //put the number
    stack<char> op_stack; //put the operations

    for(int i = s.size() - 1; i >= 0; i--){
        if(s[i] == ')' || s[i] == '+' || s[i] == '-') {
            op_stack.push(s[i]);
        } else if(isdigit(s[i])){
            string num;
            num += s[i];
            while(isdigit(s[i-1])){
                num.insert(num.begin(), s[i-1]);
                i--;
            }
            num_stack.push(atoi(num.c_str()));
        } else if(s[i] == '('){
            while(op_stack.top() != ')') {
                calculate_two_stacks(num_stack, op_stack);
            }
            op_stack.pop();
        }
    }
    while(!op_stack.empty()){
        calculate_two_stacks(num_stack, op_stack);
    }
    return num_stack.top();
}
