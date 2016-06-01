
#include <stdio.h>
#include <stdlib.h>
#include <sys/stat.h>
#include <unistd.h>
#include <fcntl.h>
#include <string.h>

int main(int argc, char *argv[]) {
  int fd1 = open("2_6_file", O_RDONLY);
  int fd2 = open("2_6_file", O_WRONLY);
  int fd3 = open("2_6_file", O_RDONLY);
  char buf[21];
  buf[20] = '\0';
  if (read(fd1, buf, 20) == 20) {
       printf("fd:1 %s\n", buf);
  }
  close(fd1);

  strcpy(buf, "testing 123...");
  int len = strlen(buf);
  printf("len %d", len);
  if (write(fd2, buf, len) != len) {
    perror("2.6.text");
    exit(EXIT_FAILURE);
  }
  close(fd2);

  if (read(fd3, buf, 20) == 20) {
    printf("fd1: %s\n", buf);
  }
  close(fd3);
  return 0;
}
