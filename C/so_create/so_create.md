gcc test_a.c test_b.c test_c.c -fPIC -shared -o libtest.so

gcc test.c -L . -ltest -o test

-shared该选项指定生成动态连接库（让连接器生成T类型的导出符号表，有时候也生成弱连接W类型的导出符号），不用该标志外部程序无法连接。相当于一个可执行文件

-fPIC：表示编译为位置独立的代码，不用此选项的话编译后的代码是位置相关的所以动态载入时是通过代码拷贝的方式来满足不同进程的需要，而不能达到真正代码段共享的目的。

-L .：表示要连接的库在当前目录中

-ltest：编译器查找动态连接库时有隐含的命名规则，即在给出的名字前面加上lib，后面加上.so来确定库的名称

LD_LIBRARY_PATH：这个环境变量指示动态连接器可以装载动态库的路径。

当然如果有root权限的话，可以修改/etc/ld.so.conf文件，然后调用 /sbin/ldconfig来达到同样的目的，不过如果没有root权限，那么只能采用输出LD_LIBRARY_PATH的方法了。

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:./

ldd is not safe to find share library dependiencies use below command
$ objdump -p /path/to/program | grep NEEDED

静态函数库:
ar rcs my_library.a file1.o file2.o

3.2. 这些函数库如何使用

在基于GNU glibc的系统里，包括所有的linux系统，启动一个ELF格式的二进制可执行文件会自动启动和运行一个program loader。对于Linux系统，这个loader的名字是/lib/ld-linux.so.X（X是版本号）。这个loader启动后，反过来就会load所有的其他本程序要使用的共享函数库。

到底在哪些目录里查找共享函数库呢？这些定义缺省的是放在/etc/ld.so.conf文件里面，我们可以修改这个文件，加入我们自己的一些特殊的路径要求。大多数RedHat系列的发行包的/etc/ld.so.conf文件里面不包括/usr/local/lib这个目录，如果没有这个目录的话，我们可以修改/etc/ld.so.conf，自己手动加上这个条目。

如果你想覆盖某个库中的一些函数，用自己的函数替换它们，同时保留该库中其他的函数的话，你可以在 /etc/ld.so.preload中加入你想要替换的库（.o结尾的文件），这些preloading的库函数将有优先加载的权利。

当程序启动的时候搜索所有的目录显然会效率很低，于是Linux系统实际上用的是一个高速缓冲的做法。ldconfig缺省情况下读出/etc/ld.so.conf相关信息，然后设置适当地符号链接，然后写一个cache到 /etc/ld.so.cache这个文件中，而这个/etc/ld.so.cache则可以被其他程序有效的使用了。这样的做法可以大大提高访问函数库的速度。这就要求每次新增加一个动态加载的函数库的时候，就要运行ldconfig来更新这个cache，如果要删除某个函数库，或者某个函数库的路径修改了，都要重新运行ldconfig来更新这个cache。通常的一些包管理器在安装一个新的函数库的时候就要运行ldconfig。 

另外，FreeBSD使用cache的文件不一样。FreeBSD的ELF cache是/var/run/ld-elf.so.hints，而a.out的cache则是/var/run/ld.so.hints。它们同样是通过ldconfig来更新。


参考文献:
http://blog.csdn.net/ithomer/article/details/7346146
