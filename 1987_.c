#include <stdio.h>
/*http://www.cnblogs.com/william-cheung/p/5371110.html*/

int main()
{
    printf("unix=%d\n", unix);

    printf("%s\n", "fun"+1);

    printf("%d\n", 'a');
    printf("%s\n", &1["abcde"]);
    printf("%s\n", (unix)["have"]+"fun"-0x60);
    printf(&unix["\021%six\012\0"], (unix)["have"] + "fun" -0x60);
    return 0;
}
