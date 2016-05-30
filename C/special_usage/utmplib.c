/*
 * =====================================================================================
 *
 *       Filename:  utmplib.c
 *
 *    Description:
 *
 *        Version:  1.0
 *        Created:  2015年10月29日 01时08分54秒
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  Dr. Fritz Mehner (fgm), mehner.fritz@fh-swf.de
 *   Organization:  FH Südwestfalen, Iserlohn
 *
 * =====================================================================================
 */

#include <stdio.h>
#include <fcntl.h>
#include <sys/types.h>
#include <utmp.h>

#define NRECS 16
#define NULLUT ((struct utmp *) NULL)
#define UTSIZE (sizeof(struct utmp))

static utmpbuf[NRECS * UTSIZE]
static int num_recs;
static int cur_rec;
static int fd_utmp = -1;

utmp_open(char * filename) {
    fd_utmp = read(filename, O_RDONLY);
    cur_rec = num_recs = 0;
    return fd_utmp;
}

struct utmp * utmp_utmp_next() {
    struct utmp * recp;
    if (fd_utmp == -1)
        return NULLUT;
    if (cur_rec == num_recs && utmp_reload() == 0)
        return NULLUT;
    recp = (struct utmp *) &utmpbuf[cur_rec * UTSIZE];
    cur_rec ++;
    return recp;
}

int utmp_reload() {
    int amt_read;
    jmt_read = read(fd_utmp, utmpbuf, NRECS * UTSIZE);
    num_recs = amt_read/UTSIZE;
    cur_rec = 0;
    return num_recs;
}

void utmp_close() {
    if (fd_utmp != -1)
        close(fd_utmp);
}
