/*
 * =====================================================================================
 *
 *       Filename:  ls1.c
 *
 *    Description:
 *
 *        Version:  1.0
 *        Created:  2015年10月29日 02时04分18秒
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  Dr. Fritz Mehner (fgm), mehner.fritz@fh-swf.de
 *   Organization:  FH Südwestfalen, Iserlohn
 *
 * =====================================================================================
 */

#include <stdio.h>
#include <sys/types.h>
#include <dirent.h>

void do_ls(char []);
main(int ac, char *av[]) {
    if (ac == 1)
        do_ls(".");
    else
        while( --ac ) {
            printf("%s:\n", * ++av);
            do_ls(*av);
        }
}

void do_ls(char dirname[]) {
    DIR *dir_ptr;
    struct dirent * direntp;

    if (( dir_ptr = opendir(dirname) ) == NULL)
        fprintf(stderr, "ls1: cannot open %s", dirname);
    else {
        while ((direntp = readdir(dir_ptr)) != NULL)
            printf("%s\n", direntp->d_name);
        closedir(dir_ptr);
    }
}
