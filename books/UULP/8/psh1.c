#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>

#define MAXARGS 20
#define ARGLEN  100

extern char *makestring(char argbuf[]);
extern void execute(char *arglist[]);
int main() {
    char *arglist[MAXARGS+1];
    int numargs;
    char argbuf[ARGLEN];
    char *makestring();
    numargs = 0;
    while (numargs < MAXARGS) {
         printf("Arg[%d]? ", numargs);
         if (fgets(argbuf, ARGLEN, stdin) && *argbuf != '\n')
             arglist[numargs++] = makestring(argbuf);
         else {
             if (numargs > 0) {
                 arglist[numargs] = NULL;
                 execute(arglist);
                 numargs = 0;
             }
         }
    }
    return 0;
}

extern void execute(char *arglist[]) {
  execvp(arglist[0], arglist);
  perror("execvp failed");
  exit(EXIT_FAILURE);
}

extern char *makestring(char argbuf[]) {
  argbuf[strlen(argbuf) - 1] = '\0';
  char *cp = (char *)malloc(strlen(argbuf) + 1);
  if (cp == NULL) {
    fprintf(stderr, "no memory\n");
    exit(EXIT_FAILURE);
  }
  strcpy(cp, argbuf);
  return cp;
}
