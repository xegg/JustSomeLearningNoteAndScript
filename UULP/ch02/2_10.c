#include <stdio.h>
#include <string.h>
#include <utmp.h>

int main()
{
       char *s,*c;
       struct utmp *u;
       int i;
       c=getlogin();
       printf("%d\n", getlogin());
       printf("%s", c);
       setutent();
       u=getutent();
       /*while(u!=NULL)*/
       /*{*/
          /*if(u->ut_type==7 && strcmp(u->ut_user,c)==1)*/
          /*{*/
               /*printf("%-12s",u->ut_user);*/
               /*printf("%-9s",u->ut_line);*/
               /*s=ctime(&u->ut_time);*/
               /*for(i=4;i<16;i++)*/
               /*printf("%c",s[i]);*/
               /*printf("(%s",u->ut_host);*/
               /*printf(")");*/
          /*}*/
       /*u=getutent();*/
       /*}*/
    return 0;
}
