#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>
#include <string.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>

#define BUFFERSIZE 4096
#define COPYMODE 0644

void oops(const char*, const char*);

int main(int argc, int *argv[]){
  if (argc != 3) {
    fprintf(stderr, "Usage: %s source destination\n", argv[0]);
    exit(EXIT_FAILURE);
  }

  struct stat src_stat;
  struct stat dst_stat;

  if (stat(argv[1], &src_stat) == -1)
      oops("Can not stat", argv[1]);

  if (stat(argv[2], &dst_stat) == -1)
    oops("Can not stat", argv[2]);

  if (src_stat.st_ino == dst_stat.st_ino) {
    fprintf(stderr, "%s: \"%s\" and \"%s\" are the same file\n", argv[0], argv[1], argv[2]);
    exit(EXIT_FAILURE);
  }

  int src_fd = open(argv[1], O_RDONLY);
  if (src_fd == -1) {
    oops("Can not open", argv[1]);
  }

  int dst_fd = creat(argv[2], COPYMODE);
  if (dst_fd == -1) {
    oops("Can not create", argv[2]);
  }

  char buf[BUFFERSIZE];
  int buf_size;

  while ((buf_size = read(src_fd, buf, BUFFERSIZE)) > 0)
    if (write(dst_fd, buf, buf_size) != buf_size)
      oops("Failed to create", argv[2]);

  if (buf_size == -1)
    oops("Failed to read", argv[1]);

  if (close(src_fd) == -1 || close(dst_fd) == -1)
    oops("Faile to close files.", "");

  return EXIT_SUCCESS;
}

extern void oops(const char *s1, const char *s2) {
  fprintf(stderr, "Error: %s ", s1);
  perror(s2);
  exit(EXIT_FAILURE);
}
