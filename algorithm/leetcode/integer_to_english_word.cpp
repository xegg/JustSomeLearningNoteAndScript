#include <stdlib.h>
#include <iostream>
#include <vector>
#include <string>
using namespace std;

static string dict1[] ={"Zero","One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine",
                 "Ten", "Eleven", "Twelve", "Thirteen", "Fourteen", "Fifteen", "Sixteen",
                 "Seventeen", "Eighteen", "Nineteen"};

static string dict2[]={"","", "Twenty", "Thirty", "Forty", "Fifty", "Sixty", "Seventy", "Eighty", "Ninety" };
static string dict3[]={"Hundred", "Thousand", "Million", "Billion" };

string numberLess1000ToWords(int num) {
    //char n[3] = {0, 0, 0};
    string result;

    if (num == 0) {
        return result;
    }else if (num < 20) {
        return dict1[num];
    } else if (num < 100) {
        result = dict2[num/10];
        if (num%10 > 0) {
            result += " " + dict1[num%10];
        }
    }else {
        result = dict1[num/100] + " " + dict3[0];
        if ( num % 100 > 0 ) {
            result += " " + numberLess1000ToWords( num % 100 );
        }
    }
    return result;
}

string numberToWords(int num) {
    //edge case
    if (num ==0 ) return dict1[num];

    vector<string> ret;
    for( ;num > 0; num/=1000 ) {
        ret.push_back( numberLess1000ToWords(num % 1000) );
    }

    string result=ret[0];
    for (int i=1; i<ret.size(); i++){
        if (ret[i].size() > 0 ){
            if ( result.size() > 0 ) {
                result = ret[i] + " " + dict3[i] + " " + result;
            } else {
                result = ret[i] + " " + dict3[i];
            }
        }

    }
    return result;
}

