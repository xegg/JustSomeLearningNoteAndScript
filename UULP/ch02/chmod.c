#include <stdio.h>
#include <unistd.h>

/*static bool mode_changed(mode_t new_mode, mode_t old_mode) {*/
    /*return ((new_mode ^ old_mode) & 777) != 0;*/
/*}*/

int main(int argc, char * argv[]) {
    int a = access("2_6.c", F_OK);
    printf("%d", a);
    return 0;
}
