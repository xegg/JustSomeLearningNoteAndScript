### Element
^ 表示一行的开头。如：/^#/ 以#开头的匹配。
$ 表示一行的结尾。如：/}$/ 以}结尾的匹配。
\< 表示词首。 如 \<abc 表示以 abc 为首的詞。
\> 表示词尾。 如 abc\> 表示以 abc 結尾的詞。
. 表示任何单个字符。
* 表示某个字符出现了0次或多次。
[ ] 字符集合。 如：[abc]表示匹配a或b或c，还有[a-zA-Z]表示匹配所有的26个字符。如果其中有^表示反，如[^a]表示非a的字符

多个匹配
sed '1,3s/my/your/g; 3,$s/This/That/g' my.txt

圆括号是变量 \1, \2访问
sed 's/This is my \([^,]*\),.*is \(.*\)/\1:\2/g' my.txt

N 基数行纳入偶数行
sed 'N;s/my/your/' pets.txt

i 向某行前添加行, a 为追加
$ sed "1 i This is my monkey, my monkey's name is wukong" my.txt
$ sed "$ a This is my monkey, my monkey's name is wukong" my.txt

# 注意其中的/fish/a，这意思是匹配到/fish/后就追加一行
$ sed "/fish/a This is my monkey, my monkey's name is wukong" my.txt

c 替换匹配行
sed "2 c This is my monkey, my monkey's name is wukong" my.txt

d 删除匹配航
sed '/fish/d' my.txt

# 这是因为sed处理时会把处理的信息输出
$ sed '/fish/p' my.txt

# 其中的+3表示后面连续3行
$ sed '/dog/,+3s/^/# /g' pets.txt

# 命令打包
$ sed '1,${/This/d;s/^ *//g}'g： 

# Hold space
将hold space中的内容拷贝到pattern space中，原来pattern space里的内容清除
G： 将hold space中的内容append到pattern space\n后
h： 将pattern space中的内容拷贝到hold space中，原来的hold space里的内容被清除
H： 将pattern space中的内容append到hold space\n后
x： 交换pattern space和hold space的内容 pets.txt


反序一个文件
其中的 '1!G;h;$!d' 可拆解为三个命令

1!G —— 只有第一行不执行G命令，将hold space中的内容append回到pattern space
h —— 第一行都执行h命令，将pattern space中的内容拷贝到hold space中
$!d —— 除了最后一行不执行d命令，其它行都执行d命令，删除当前行

Using & as matched string
% echo "123 abc" | sed 's/[0-9][0-9]*/& &/'

Extended Regular expression
sed -r in linux, sed -E in max os or FreeBSD

The numeric value can have up to nine values: "\1" thru "\9." If you wanted to reverse the first three characters on a line, you can use
sed 's/^\(.\)\(.\)\(.\)/\3\2\1/'

/1/2 Specify which occurrence
sed 's/\([a-zA-Z]*\) \([a-zA-Z]*\) /\1 /' <old >new
Yuck. There is an easier way to do this. You can add a number after the substitution command to indicate you only want to match that particular pattern. Example:

sed 's/[a-zA-Z]* //2' <old >new
You can combine a number with the g (global) flag. For instance, if you want to leave the first word alone, but change the second, third, etc. to be DELETED instead, use /2g:

sed 's/[a-zA-Z]* /DELETED /2g' <old >new
I've heard that combining the number with the g command does not work on The MacOS, and perhaps the FreeSBD version of sed as well.

Don't get /2 and \2 confused. The /2 is used at the end. \2 is used in inside the replacement field.

Note the space after the "*" character. Without the space, sed will run a long, long time. (Note: this bug is probably fixed by now.) This is because the number flag and the "g" flag have the same bug. You should also be able to use the pattern

sed 's/[^ ]*//2' <old >new
but this also eats CPU. If this works on your computer, and it does on some UNIX systems, you could remove the encrypted password from the password file:

sed 's/[^:]*//2' </etc/passwd >/etc/password.new
But this didn't work for me the time I wrote this. Using "[^:][^:]*" as a work-around doesn't help because it won't match an non-existent password, and instead delete the third field, which is the user ID! Instead you have to use the ugly parenthesis:

sed 's/^\([^:]*\):[^:]:/\1::/'  </etc/passwd >/etc/password.new
You could also add a character to the first pattern so that it no longer matches the null pattern:

sed 's/[^:]*:/:/2'  </etc/passwd >/etc/password.new
The number flag is not restricted to a single digit. It can be any number from 1 to 512. If you wanted to add a colon after the 80th character in each line, you could type:

sed 's/./&:/80' <file >new
You can also do it the hard way by using 80 dots:

sed 's/^................................................................................/&:/' <file >new

By default, sed prints every line. If it makes a substitution, the new text is printed instead of the old one. If you use an optional argument to sed, "sed -n," it will not, by default, print any new lines. I'll cover this and other options later. When the "-n" option is used, the "p" flag will cause the modified line to be printed. Here is one way to duplicate the function of grep with sed:
sed -n 's/pattern/&/p' <file

sed -n 's/^[0-9]*[02468] /&/w even' <file 

sed -e 's/a/A/' -e 's/b/B/' <old >new

sed 's/^#.*//'  f1 f2 f3 | grep -v '^$' | wc -l

sed -f sedscript <old >new

sed -e '1,/start/ s/#.*//'
This example will remove comments everywhere except the lines between the two keywords:

sed -e '1,/start/ s/#.*//' -e '/stop/,$ s/#.*//'

sed -e 's/#.*//' -e 's/[ ^I]*$//' -e '/^$/ d' 

sed '1,10 q'
