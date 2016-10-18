--------------------------------------------------
第一步：新建分支
首先，每次开发新功能，都应该新建一个单独的分支（这方面可以参考《Git分支管理策略》）。

# 获取主干最新代码
$ git checkout master
$ git pull

# 新建一个开发分支myfeature
$ git checkout -b myfeature
