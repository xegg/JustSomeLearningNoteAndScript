/*
 * =====================================================================================
 *
 *       Filename:  who3.c
 *
 *    Description:
 *
 *        Version:  1.0
 *        Created:  2015年10月29日 01时22分45秒
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  Dr. Fritz Mehner (fgm), mehner.fritz@fh-swf.de
 *   Organization:  FH Südwestfalen, Iserlohn
 *
 * =====================================================================================
 */

#include <stdio.h>
#include <sys/types.h>
#include <tump.h>
#include <fcntl.h>
#include <time.h>

#define SHOWHOST

void show_info(struct utmp *);
void showtime(time_t);

int main() {
    struct utmp * utbufp, *utmp_next();

    if (utmp_open(UTMP_FILE) == -1) {
        perror(UTMP_FILE);
        exit(1);
    }
}
