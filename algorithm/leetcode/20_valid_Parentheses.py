tup = (('(', ')'),('{','}'), ('[', ']'))
parenthes = {}
for i, j in tup:
    parenthes[i] = j
tmp= list("{({})}")
tmp = list("{[()[]][]}")
# def valid_parenthese(tmp):
    # if len(tmp) % 2 != 0:
        # return False
    # for i in range(1,len(tmp)+1):
        # for j in tup:
            # print i, j
            # print tmp[i-1], tmp[-i]
            # if tmp[i-1] in j and tmp[-i] in j:
                # break
            # else:
                # continue
        # else:
            # return False
    # return True
# print valid_parenthese(tmp)
pre = []
for i in tmp:
    try:
        if parenthes[pre[-1]] == i:
            pre.pop()
        else:
            pre.append(i)
    except:
        pre.append(i)
else:
    if pre == []:
        print 'yes'

bool isValid(string s) {
    stack<char> st;
    for(auto ch : s) {
        if (ch=='{' || ch =='[' || ch=='(' ) {
            st.push(ch);
        }else if (ch=='}' || ch ==']' || ch == ')' ){
            if (st.empty()) return false;
            char sch = st.top();
            if ( (sch=='{' && ch =='}') || (sch=='[' && ch==']') || (sch=='(' && ch==')' ) ){
                st.pop();
            }else {
                return false;
            }
        }else{
            return false;
        }
    }
    return st.empty();
}

int main(int argc, char**argv)
{
    string s = "{{}{[]()}}";
    if (argc>1){
        s = argv[1];
    }
    cout << "str = \"" << (s) << "\"" << endl;
    cout << isValid(s) << endl;
}
