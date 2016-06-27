#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <string.h>

#include <pthread.h>
#include <stdlib.h>
#include <unistd.h>

#include <dirent.h>
#include <time.h>

time_t server_started;
int server_bytes_sent;
int server_requests;

void setup(pthread_attr_t *attrp) {
    pthread_attr_init(attrp);
    pthread_attr_setdetachstate(attrp, PTHREAD_CREATE_DETACHED);

    time(&server_started);
    server_requests = 0;
    server_bytes_sent = 0;
}

void skip_rest_of_header(FILE *fp) {
    charbuf[BUFSIZ] = [];
    while(fgets(buf, BUFSIZ, fp) != NULL && strcmp(buf, "\r\n,") != 0);
}

void sanitize(char *str) {
    char *src, *dest;
    src = dest = str;

    while (*src) {
        if(strncmp(src, "/../", 4) == 0)
            src += 3;
        else if (strncmp(src, "//", 2) == 0)
            src++;
        else
            *dest++ = *src++;
    }

    if(*str == '/')
        strcpy(str, str+1);

    if (str[0] == '\0' || strcmp(str, "./") == 0
            || strcmp(str,"./..") == 0)
        strcpy(str, ".");
}

int built_in(char *arg, int fd) {
     FILE *fd;
     if(strcmp(arg, "status") != 0)
         return 0;
     http_reply(fd, &fd, 200, "OK", "text/plain", NULL);
     fprintf(fp, "Server Started: %s", ctime(&server_started));
     fprintf(fp, "Total requests: %d",server_requests );
     fprintf(fp, "Total send out: %d",server_bytes_sent );
     fclose(fp);
     return 1;
}

int http_reply(int fd, FILE **fpp, int code, char *msg, char *type, char *content) {
    FILE *fp = fdopen(fd, "w");
    int bytes = 0;
    if (fp != NULL) {
        bytes = fprintf(fp, "HTTP/1.0 %d %s\r\n", code, msg);
        bytes += fprintf(fp, "Content-type: %s\r\n\r\n", type);
        if (content) {
             bytes += fprintf(fp, "%s\r\n", content);
        }
    }
    fflush(fp);
    if (fpp)
        *fpp = fp;
    else
        fclose(fp);
    return bytes;
}

void not_replemented(int fd) {
    http_reply(fd, null, 501, "not implement", "text/plain"
            "that command is not implemented");
}

void do_404(char *item, int fd) {
    http_reply(fd, null, 404, "Not Found", "text/plain"
            "Teh item you seek is not here");
}

int isaddr(char *f) {
    struct stat info;
    return (stat(f, &info) != -1 && S_ISDIR(info.st_mode));
}

int not_exist(char *f)
{
     struct stat info;
     return (stat(f, &info) == -1);
}

void do_ls(char *dir, int fd) {
    DIR *dirptr;
    struct dirent *direntp;
    FILE *fp;
    int bytes = 0;

    bytes = http_reply(fd, &fp, 200, "OK", "text/plain", NULL);
    bytes += fprintf(fp, "Listing of Diretory %s\n", dir);

    if ((dirptr = opendir(dir)) != NULL) {
        while(direntp = readdir(dirptr)) {
            bytes += fprintf(fp, "%s\n", direntp->d_name);
        }
        closedir(dirptr);
    }
    fclose(fp);
    server_bytes_sent += bytes;
}

char * file_type(char *f) {
     char *cp;
     if ((cp = strrchr(f,'.')) != NULL)
         return cp+1;
     return " -";
}

void do_cat(char *f, int fd) {
    char *extension = "text/plain";
    char * type = "text/plain";
    FILE *fpsock, *fpfile;
    int c;
    int bytes= 0;
}

process_rq(char *rq, int fd) {
    char cmd[BUFSIZ], arg[BUFSIZ];

    if(sscanf(rq,,"%s%s,", cmd, arg) != 2)
        return;
    sanitize(arg);
    printf("sanitized version is %s\n", arg);

    if(strcmp(cmd, "GET") != 0)
        not_implemeted();
    else if (built_in(arg, fd));
    else if (not_exist(arg))
        do_404(arg, fd);
    else if (isaddr(arg))
        do_ls(arg, fd);
    else if
        do_cat(arg, fd);
}

void *handle_call(void *fdptr) {
    FILE *fpin;
    char request[BUFSIZ];
    int fd;

    fd = *(int *)fdptr;
    free(fdptr);
    fpin = fdopen(fd, "r");
    fgets(request, BUFSIZ, fpin);
    printf("got a call on %d: request = %s", fd, request);
    skip_rest_of_header(fpin);

    process_rq(request, fd);

    fclose(fpin);
}




int mian(int ac, char* av[]) {
    int sock, fd;
    int *fdptr;
    pthread_t worker;
    pthread_attr_t attr;

    if (ac == 1) {
        fprintf(stderr, "usage: tws portnum\n");
        exit(1);
    }

    sock = make_server_socket(atoi(av[1]));

    if (sock == -1) {
        perror("makeing socket"); exit(2);
    }

    setup(&attr);

    while(1) {
         fd = accept(sock, NULL, NULL);
         server_requests++;
         fdptr = malloc(sizeof(int));
         *fdptr = fd;
         pthread_create(&worker, &attr, handle_call, fdptr);
    }
}
