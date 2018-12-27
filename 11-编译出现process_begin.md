# 编译出现process_begin

这个问题好坑爹。

[TOC]

## 问题现象

```cmd
process_begin: CreateProcess(D:\LambdaPRO\host\bin\sh.exe, D:/LambdaPRO/host/bin/sh.exe C:\DOCUME~1\KY\LOCALS~1\Temp\make47562.sh, ...) failed.
make[1]: Leaving directory `D:/LambdaPRO/target/deltaos/board/MPC8640D_CPPCAB_0C1'
make (e=234): 有更多数据可用。
```

## 问题分析

当我第一时间看到这个问题的时候，首先想到的是，cmd一条命令容纳的最大字符数是8191，所以是我的命令太长了吗？

我把板级下面的Makefile中多余的头文件搜索路径给删除了，结果还是不行。然后，我又把该开发环境放到f:盘的根目录下面，还是不行。这让我怀疑是否不是这个原因引起的。

**PS：**

> 出现这种问题时，一般不是当前正在用的编译器等软件的原因（当然也有这种可能）。 
> 多数情况下是Windows cmd.exe的锅: 
> 因为自xp以后，windows的cmd窗口或者batch处理文件一条命令容纳的最大字符数是8191，其中包括命令和参数.而当执行一个命令其参数过长时就有可能超过这个限制，便会报错，这是操作系统的报错。

## 遇到难题

不是命令太长的错？

接着同事也从svn上export了该包进行测试，他们的电脑纷纷可行。

因为我之前测试是用xp，因此我也切换到了win7来试，在win7上是可行的！

算了，不纠结了，先打包再说吧，暂且把它定义为是我的电脑问题，而不是包本身。

## 峰回路转

晚上回家，洗漱的时候，突然想到。是否仍是cmd的命令太长的原因，而有些引起的方向我没考虑到？因为这报错的提示太像是这个错误了！

再想想，因为电脑的差异，也可导致包报错。

也就是说cmd的命令太长和包本身没有关系，和电脑有关系。电脑和电脑之间的差异是什么？而包和电脑之间的联系是什么？

**PATH环境变量！**

嗯，早上来到公司，启动xp，启动IDE，编译仍然报错！

删除PATH环境变量的所有内容，重新启动IDE，编译，(o゜▽゜)o☆[BINGO!]

## 解决方法

1. 修改bsp下Makefile，删除重复或多余的头文件搜索路径

   ```
   CFLAGS := $(CFLAGS)  -I$(PROJECT_PATH) -I$(BSPS_PATH) -I$(PROJECT_PATH)/src  $(DEFAULT_SEARCH_PATH)
   删除$(DEFAULT_SEARCH_PATH)
   ```

   把IDE放到根目录下，减少文件路径长度

2. 删除不必要的环境变量PATH中的路径

**当然，以上解决方案的最终目的都是为了减少在cmd中执行的一条命令的长度！**

## 思考

在问题的分析中，环境变量往往悄无声息地影响结果。按理说，环境变量极大的方便了我们对可执行程序的执行，但是，当环境变量导致问题时，却往往被忽略。

## 参考

[微软官方给出的解决方案](https://support.microsoft.com/en-us/kb/830473)