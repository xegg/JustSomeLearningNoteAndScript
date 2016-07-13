#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>
#include <utmp.h>

#define NERCS 16
#define NULLUT ((struct utmp *) NULL)
#define UTSIZE (sizeof(struct utmp))

extern int utmp_open(char *filename);
extern struct utmp *utmp_next(void);
extern int utmp_reload(void);
extern void utmp_close(void);

static char utmpbuf[NERCS * UTSIZE];
static int num_recs;
static int cur_rec;
static int utmp_fd = -1;

extern int utmp_open(char * filename) {
    utmp_fd = open(filename, O_RDONLY);
    cur_rec = num_recs = 0;
    return utmp_fd;
}

extern struct utmp *utmp_next(void) {
     if (utmp_fd == -1)
         return NULLUT;
     if (cur_rec == num_recs && utmp_reload() == 0)
         return NULLUT;
     struct umtp *recp = (struct utmp *) utmpbuf[cur_rec * UTSIZE];
     ++cur_rec;
     return recp;
}

extern int utmp_reload(void) {
  int amt_read;
  amt_read = read(utmp_fd, utmpbuf, NERCS * UTSIZE);
  num_recs = amt_read / UTSIZE;
  cur_rec = 0;
  return num_recs;
}

extern int utmp_close(void) {
    if (utmp_fd != -1)
        close(utmp_fd);
}
