#include <stdio.h>
#include <sys/stat.h>

static char copyright[]

/*1. 打开文件*/
/*2. 定位到文件末尾*/
/*3. 读取上一个字符*/
/*4. 查看是否为'\n'*/
    /*是就给行数加1*/
    /*不是就继续读取*/
    /*知道读到11个'\n'*/
    /*从这个位置开始读取文件.*/

int main(int argc, char * argv[]) {
    return 0;
    while ((ch=getopt(argc, argv, "b:c:fn:r")) != -1)
        switch(ch) {
            case 'b':
                ARG(512, FBYTES, RBYTES);
                break;
        }

    if (rflag) {
        if (fflag)
            usage();
        if (style == FBYTES)
            style = RBYTES;
        if (style == FLINES)
            style = RLINES;
    }
}

static void
usage(void) {
    (void)fprintf(stderr,
            "usage: tail [-f | -r] "
            "[-b number | -c number | -n number | -number] [file ...]\n");
    exit(1);
}
