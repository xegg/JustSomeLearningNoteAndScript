#include <stdio.h>
#include <errno.h>
#include <fcntl.h>

extern int errno;
void sample(void) {
    int fd;
    fd = open("file", O_RDONLY);
    if (fd == -1) {
        printf("Cannot open file: ");
        if (errno == ENOENT)
            printf("There is no such file.");
        else if (errno == EINTR)
            printf("Interrupted while opening file");
    }
}

void sample2(void) {
    int fd;
    fd = open("file", O_RDONLY);
    if (fd == -1) {
        perror("Cannot open file");
    }
}

int main(char* argc, char* argv[]) {
     sample();
     sample2();
     return 0;
}
