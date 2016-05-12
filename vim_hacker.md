2016年 05月 03日 星期二 20:47:40 CST:
<!--get current row number-->
nnoremap <F1> i<C-r>=line('.')+1<CR><Esc>

(C-r)= read from command line

help i_CTRL-R

ctrl-^ 切换缓存区
bd 关闭缓存区

noh: 不高亮
* 上一次完全pipei
# 下一次完全匹配

s用于替换单个字符
summary.l
tmux.l
vim.l
S用于替换一整行

:clo 关闭窗口
:hid 隐藏窗口
^W ^ 新窗口打开候补文件

:r 读入文件
!motion command 改变内容

ab 缩写

:a 增加文本

bd 溢出缓存区文件

ce 放在行的中间

:fole 折叠

:g/Name:/s/tom/Tom/ 批量替换

vim -u NONE -N 关闭vimrc文件
>{motion} 缩进制定的行数
o

var var = "method(" + argument1+",");
f+ s + <ESC> ; .
; 可以重复上一次的f{char}命令

@: 重复上一次command line

& 重复上一次ex命令

, 可以返回上一次f{char} 命令

使用<esc>o可以增加undo的粒度, 每当自己需要返回的时候都可以使用u
每一次使用<UP>等都会到了一般模式所以增加了一个undo

:h aw 用daw可以删除一整个单词, 而且有很多这样的快捷键
the end is nigh

cW 可以用来改变小数点大括号
<c-X>用来减少数字, 直接到达这一样第一个数字的地方

act, repeat reverse d3w is worth than dw..

:h operators
:h map-operator
:h omap-info

<C-o> jump into insert normal mode
<C-r>0 复制regist到当前光标
<C-r>= 可以计算一个表达式
<C-v>u{digit} 可以插入一个符号
:h i_CTRL-V_digit
:h ga
:h digraphs-default
:digraphs
:h tabstop

v 切换会视图模式
o 去到视图的另外一端

'm mark location

<C-d> 命令不全往下翻

<C-r><C-w> 可以不全当前的代码

:q 查看命令的历史

:setlocal
:bufdo setlocal 
:windo setlocal

know the saw, then sharp it

:h tag-priority
:tselect
:tag
:pop or <C-t>
:tjump
g<C-]>


<!--:args *.[ch]-->
:argdo %s/\<my_foo\>/My_Foo/ge | update
:h backtick-expansion
:h hidden

<C-w>o and <C-o>C
<C-w> T move current window into new tab
:h window-moving

:lcd change current window
:windo lcd

:tabmove
:set path+=app/**
:help wildsetting
:h markmotion
:h matchit

'拼写检测
[s ]s z=
zg zw zug
ftp.vim.org/vim/runtime/spell
<C-x>s 可以用来在编辑模式改变文字l:q

:!wc -m % 显示当前行多少字符

vim/jk-jumps.vim
this script can fix j-k with jumps

delete blank char in the end;
%s/\s\+$//
%norm $F|D

surround change the surround
c
d
yi textobject subtl

Plugin:signify
]c [c Move to next chanage bommer
text-object

Plubin:conflict-marker
[x ]x Jump among comflict marker
co ct cb cn ['choose ourselves', 'choose themselves', 'choose both', 'choose null']

Plugin:vim-bufferline
Show the bufferline.

Plugin:Undotree
<Leader>u Execlent!

Plugin:abolish
<Leader>u Execlent!

q: can search command history

Source:
http://usevim.com/

vim -x <FILENAME>

ci', di',

vim +"set nobomb | set fenc=utf8 | x" filename.txt
