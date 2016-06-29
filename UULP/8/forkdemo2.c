#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

void main() {
    printf("My pid is %d\n", getpid());
    fork();
    fork();
    fork();
    printf("My pid is %d\n", getpid());
}
