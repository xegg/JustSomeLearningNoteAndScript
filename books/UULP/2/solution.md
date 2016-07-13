#### 2.1
`man w` 表明：**idle time, JCPU, PCPU, and the command line of their current process** 为 `who` 所没有提供的信息；除去 `idle time` 之外，其它可能来自 `/proc` 目录。

#### 2.2

`man utmp`:

> The first entries ever created result from init(1) processing inittab(5).  Before an entry is processed, though, init(1) cleans up  utmp  by setting ut_type to DEAD_PROCESS, clearing ut_user, ut_host, and ut_time with null bytes for each record which ut_type is not DEAD_PROCESS or RUN_LVL and where no process with PID ut_pid exists.  If no empty record with the needed ut_id can be found, init(1) creates a new one.   It sets ut_id from the inittab, ut_pid and ut_time to the current values, and ut_type to INIT_PROCESS.
>
> mingetty(8) (or agetty(8)) locates the entry by the PID, changes ut_type to LOGIN_PROCESS, changes ut_time, sets ut_line, and waits for connection to be established.  login(1), after a user has been authenticated, changes  ut_type  to  USER_PROCESS,  changes  ut_time,  and  sets ut_host  and  ut_addr.   Depending  on  mingetty(8) (or agetty(8)) and login(1), records may be located by ut_line instead of the preferable ut_pid.

#### 2.3

![GUI 下的虚拟终端对应文件要用 tty 查询，不能直接默认为 /dev/tty.](https://lh4.googleusercontent.com/-jrD9xVQZVL0/VIwuaqYJoVI/AAAAAAAAI6Q/R48v5Id1tvg/s0/DeepinScreenshot20141213201633.png)
tty
cat /dev/pts/0
cp file /dev/pts/0

#### 2.4

[Where to find struct _IO_FILE](http://stackoverflow.com/a/16424544/1546088).
grep -rn "struct _IO_FILE {" --include="\*.h" /usr/include
echo '#include<stdio.h>' | gcc -E -

### 2.5
A successful return from write() does not make any guarantee that data has been committed to disk.  In fact, on some buggy implementations, it does not even guarantee that space has
successfully been reserved for the data.  The only way to be sure is to call fsync(2) after you are done writing all your data.

If a write() is interrupted by a signal handler before any bytes are written, then the call fails with the error EINTR; if it is interrupted after at least one byte has been written,
the call succeeds, and returns the number of bytes written.

#### 2.6

参见 `2.6.c` 文件. 执行：

	echo "1234567890abcdefghijklmnopqrstuvwxyz" > 2.6.text
	cc 2.6.c -o 2.6.out
	./2.6.out

返回：

    fd1: 1234567890abcdefghij
    fd1: testing 123...efghij

#### 2.7

`man man` 表明：

>        The table below shows the section numbers of the manual followed by the types of pages they contain.
> 
>        1   Executable programs or shell commands
>        2   System calls (functions provided by the kernel)
>        3   Library calls (functions within program libraries)
>        4   Special files (usually found in /dev)
>        5   File formats and conventions eg /etc/passwd
>        6   Games
>        7   Miscellaneous (including macro packages and conventions), e.g. man(7), groff(7)
>        8   System administration commands (usually only for root)
>        9   Kernel routines [Non standard]

事实上有些 Manual 的 Section Numbers 自带 P 后缀，比如 `read (1p)` 和 `read (3p)`, 大概是它们属于 POSXI 规范的意思。值得一提，Linux Programmer's Manual 和 POSIX Programmer's Manaual 分别属于 2, 3p Section, 有不少 Unix 系统调用都有这两方面的 Manual.


#### 2.8

我执行 `cat /var/run/utmp`, 返回 `~~~reboot3.17.4-1-ARCHacTetty1tty1acgtyrantegcT      %`, 大概只记录了内核版本吧。

### 2.9
可以参见APUE的相关描述
Linux_File_Hole_And_Sparse_Files
[root@localhost ~]# dd if=/dev/zero of=sparse-file bs=1 count=1 seek=1024k
[root@localhost ~]# ls -l sparse-file
-rw-r--r-- 1 root root 1048577 Oct 15 17:50 sparse-file
[root@localhost ~]# du -sh sparse-file
8.0K
sparse-file
[root@localhost ~]# cat anaconda-ks.cfg >> sparse-file
[root@localhost ~]# du -sh sparse-file
12K sparse-file
[root@localhost ~]# du -sh anaconda-ks.cfg
12K anaconda-ks.cfg
[root@localhost ~]#
dd 命令的使用
debugfs
