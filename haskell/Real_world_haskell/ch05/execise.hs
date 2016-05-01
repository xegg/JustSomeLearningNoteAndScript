我们现有的美观打印器已经可以满足一定的空间限制要求，我们还可以对它做更多改进。

用下面的类型签名写一个函数 fill。

-- file: ch05/Prettify.hs
fill :: Int -> Doc -> Doc
它应该给文档添加空格直到指定宽度。如果宽度已经超过指定值，则不加。

fill :: Int -> Doc -> Doc
fill width x = hcat (init (scanLines 0 [x <> Line]))
  where
    scanLines _ []         = []
    scanLines col (d:ds) =
      case d of
        Empty        -> scanLines col ds
        Char c       -> Char c : scanLines (col + 1) ds
        Text s       -> Text s : scanLines (col + length s) ds
        Line         -> Text (padLine (width - col)) : Line : scanLines 0 ds
        a `Concat` b -> scanLines col (a:b:ds)
        _ `Union` b  -> scanLines col (b:ds)
    padLine w = replicate w ' '

我们的美观打印器并未考虑嵌套（nesting）这种情况。当左括号（无论是小括号，中括号，还是大括号）出现时， 之后的行应该缩进，直到对应的右括号出现为止。

实现这个功能，缩进量应该可控。

-- file: ch05/Prettify.hs
nest :: Int -> Doc -> Doc
nest indentation x = indent 0 [x]
  where
    indent _ []             = Empty
    indent nestLevel (d:ds) =
      case d of
        Empty        -> indent nestLevel ds
        Char '{'     -> padLine nestLevel <> Char '{' <> indent (nestLevel + 1) (Line:ds)
        Char '}'     -> padLine (nestLevel - 1) <> Char '}' <> indent (nestLevel - 1) ds
        Char '['     -> padLine nestLevel <> Char '[' <> indent (nestLevel + 1) (Line:ds)
        Char ']'     -> padLine (nestLevel - 1) <> Char ']' <> indent (nestLevel - 1) ds
        Char c       -> Char c <> indent nestLevel ds
        Text s       -> Text s <> indent nestLevel ds
        Line         -> padLine nestLevel <> indent nestLevel ds
        a `Concat` b -> indent nestLevel (a:b:ds)
        a `Union` b  -> indent nestLevel (a:ds) `Union` indent nestLevel (b:ds)
    padLine nl = Line <> Text (replicate (nl * indentation) ' ')est :: Int -> Doc -> Doc
