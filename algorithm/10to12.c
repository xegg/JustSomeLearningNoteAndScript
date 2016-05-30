/*
 * =====================================================================================
 *
 *       Filename:  10to12.c
 *
 *    Description:
 *
 *        Version:  1.0
 *        Created:  2015年11月03日 00时06分41秒
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  Dr. Fritz Mehner (fgm), mehner.fritz@fh-swf.de
 *   Organization:  FH Südwestfalen, Iserlohn
 *
 * =====================================================================================
 */

#include <stdio.h>

deToi( int a ) {
    int i = 0, stack[10], r, s;
    do {
        r = a/2;
        s = a%2;
        stack[i] = s;
        if (r!=0) {
            i ++; a = r;
        }
    }
    while (r);
    for (; 1>=0; i--)
        printf("%d", stack[i]);
    printf("\n");
}
