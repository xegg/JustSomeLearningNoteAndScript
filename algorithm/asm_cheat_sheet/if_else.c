/*
 * =====================================================================================
 *
 *       Filename:  if_else.c
 *
 *    Description:
 *
 *        Version:  1.0
 *        Created:  2015年11月02日 22时39分20秒
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  Dr. Fritz Mehner (fgm), mehner.fritz@fh-swf.de
 *   Organization:  FH Südwestfalen, Iserlohn
 *
 * =====================================================================================
 */

#include <stdio.h>

int main(void) {
    int score;
    printf("print input a score: ");
    scanf("%d", &score);
    if (score < 80)
        if (score < 70)
            if (score < 60)
                printf("E\n");
            else
                printf("D\n");
        else
            printf("C\n");
    else
        if (score < 90)
            printf("B\n");
        else
            printf("A\n");
    return 0;
}
