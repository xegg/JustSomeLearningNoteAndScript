#include <stdio.h>
#include <pthread.h>

#define NUM 5

void *print_count(void *);
int counter = 0;

int main(void) {
    pthread_t t1;
    pthread_create(&t1, NULL, print_count, NULL);
    int i;
    for(i=0; i<NUM; i++){
        counter++;
        sleep(1);
    }
    return 0;
    pthread_join(t1, NULL);
}

void *print_count(void *m) {
    int i;
    for (i=0; i< NUM; i++) {
        printf("count = %d\n", counter);
        sleep(1);
    }
    return NULL;
}
