/**********************************************************************************
*
* Implement strStr().
*
* Returns a pointer to the first occurrence of needle in haystack, or null if needle is not part of haystack.
*
*
**********************************************************************************/

#include <stdio.h>
#include <stdlib.h>
#include <time.h>
//KMP
char *strStr1(char *haystack, char *needle) {
    if(!haystack || !needle ) {
        return NULL;
    }
    if (!*needle ) {
        return haystack;
    }

    char *ph = haystack;
    char *pn = needle;
    for( ;*ph && *pn ; ph++, pn++ );

    //len(haystack) < len(needle)
    if (!*ph && *pn){
        return NULL;
    }

    for(ph=ph-1; *ph; haystack++, ph++) {
        char *q=needle;
        char *p=haystack;
        int n=0;
        while(*q && *p && *p==*q){
            p++; q++;
            if (n==0 && *p == *needle){
                n = p - haystack;
            }
        }
        if (!*q){
            return haystack;
        }
        haystack += (n>0 ? n-1 : n);
    }
    return NULL;
}

//brute-force
char *strStr2(char *haystack, char *needle) {

    if(!haystack || !needle ) {
        return NULL;
    }
    if (!*needle ) {
        return haystack;
    }

    char *ph = haystack;
    char* pn = needle;
    for( ;*ph && *pn ; ph++, pn++ );

    //len(haystack) < len(needle)
    if (!*ph && *pn){
        return NULL;
    }
    ph--;

    for( ; *ph; haystack++, ph++) {
        char *q=needle;
        char *p=haystack;
        while(*q && *p && *p==*q){
            p++; q++;
        }
        if (!*q){
            return haystack;
        }
    }

    return NULL;
}
