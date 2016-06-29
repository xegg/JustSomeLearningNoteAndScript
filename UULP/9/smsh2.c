#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <signal.h>
#include "smsh1.h"

#define DFL_PROMPT ">"

int main(int argc, char *argv[]) {
  char *cmdline, *prompt, **arglist;

  prompt = DFL_PROMPT;

  while ((cmdline = next_cmd(prompt, stdin)) != NULL) {
    if ((arglist = splitline(cmdline)) != NULL) {
      process(arglist);
      freelist(arglist);
    }
    free(cmdline);
  }

  return EXIT_SUCCESS;
}

extern void fatal(char *s1, char *s2, int n) {
  fprintf(stderr, "Error: %s, %s\n", s1, s2);
  exit(n);
}
