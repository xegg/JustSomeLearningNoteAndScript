/**********************************************************************************
*
* Implement wildcard pattern matching with support for '?' and '*'.
*
* '?' Matches any single character.
* '*' Matches any sequence of characters (including the empty sequence).
*
* The matching should cover the entire input string (not partial).
*
* The function prototype should be:
* bool isMatch(const char *s, const char *p)
*
* Some examples:
* isMatch("aa","a") → false
* isMatch("aa","aa") → true
* isMatch("aaa","aa") → false
* isMatch("aa", "*") → true
* isMatch("aa", "a*") → true
* isMatch("ab", "?*") → true
* isMatch("aab", "c*a*b") → false
*
*
**********************************************************************************/

#include <iostream>
#include <string>
using namespace std;


bool isMatch(const char *s, const char *p) {

    const char *last_s = NULL;
    const char *last_p = NULL;
    while( *s != '\0' ){
        if (*p=='*'){
            //skip the "*", and mark a flag
            p++;
            //edge case
            if (*p=='\0') return true;
            //use last_s and last_p to store where the "*" match starts.
            last_s = s;
            last_p = p;
        }else if (*p=='?' || *s == *p){
            s++; p++;
        }else if (last_s != NULL){ // check "last_s" to know whether meet "*" before
            // if meet "*" previously, and the *s != *p
            // reset the p, using '*' to match this situation
            p = last_p;
            s = ++last_s;
        }else{
            // *p is not wildcard char,
            // doesn't match *s,
            // there are no '*' wildcard matched before
            return false;
        }
    }
    //edge case: "s" is done, but "p" still have chars.
    while (*p == '*') p++;
    return *p == '\0';
}