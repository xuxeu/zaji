# myWorks

[TOC]

##1.typora

```shell
# optional, but recommended
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys BA300B7755AFCFAE

# add Typora's repository
sudo add-apt-repository 'deb http://typora.io linux/'
sudo apt-get update

# install typora
sudo apt-get install typora
```

最重要的：
```python
目录：[TOC]
一级标题：#
二级标题：##
有序列表：1. 
无序列表：- 
代码块呢：```  ```
```
一般重要的：
```c
斜体： * *
加粗：** **
高亮：== ==
表格：crtl+t
```
特色：

这是我最喜欢**typora**的地方，相对于word文档的优势也在于此，对于程序员来说，这个特色简直是爽得不要不要的:smile:。

```python
引用：>
数学公式： $$  $$
代码块呢：```  ```
萌emoji：  :  :
```


## 2.vim

学习vim是要遵循基本法的，那就是学习一个文本编辑器所具有的最基本的功能，而vim把它用命令来实现了。

vim是模式编辑器，具有三种模式：命令模式，底行ex模式，编辑模式。

而底行ex模式就是命令模式的一种，编辑模式就是可以正常编辑文档。因此，最重要的就是vim命令模式。

打开文本：

```vi *.txt```

移动：

```
1. 左右上下箭头
2. 上下翻页  ：pageup和pagedown
3. 移动行首  ：0
4. 移动行尾  ：$
5. 移动文件首：gg
6. 移动文件尾：G
7. 移动第几行：numberG
```

编辑：

```
1. 撤销：u
2. 插入：i
3. 添加：a
4. 移动到行尾添加：A
```

查找：

```
1. 查找一行内字母：falpha
2. 查找整篇文章：/alpha 使用n切换
```

保存退出：

```
1. 写入：w
2. 退出：q
3. 强制：!
4. 保存并退出：wq
5. 不保存退出：q!
```



## 3.dpkg

功能：

1. 安装，移除已下载到本地的软件包
2. 查询，解包已下载到本地的软件包
3. 维护，保存已下载到本地的软件包信息

总之，dpkg是一个底层的软件包管理系统，主要用于对**已下载到本地和已安装的软件包进行管理**。

> dpkg:底层软件包管理命令
>
> apt-get：命令模式的高级包管理命令
>
> aptitude：文本界面的高级包管理程序
>
> dpkg :只是用来安装本地软件包的，不解决软件关系。
>
> apt-get 和 aptitude 是从网络安装软件包的（如果把 file:// 也当成网络环境的话），解决依赖关系。
>
> 不同的是 apt-get 不删除已经安装的没有用的软件包，而 aptitude 更加智能，它会删除已经安装没有用的软件包。
>
> 别把 apt-get 和 aptitude 混用，它们使用不同软件安装记录。



## 4.手动编译

apt-get是包管理工具，我想对包管理了解更深入。

###不同的理念

Linux与windows实在有很大的理念差异。不说商业运作，盖茨在微软的发展阶段利用DOS的兼容性迅速打开用户市场，在windows1，windows2之后的成功之作windows3.x又对当时他的竞争对手重拳出击。后来，网络开始普及，windows利用IE的捆绑销售抢占先机，后来其他的很多软件也是捆绑销售。虽然当时微软就有很多的反垄断诉讼，盖茨也通过各种手段处理这些问题。但是不提褒贬，盖茨的确可以称得上是一个“枭雄”，而且他的windows对于pc的普及也的确起到了莫大贡献。

而对于linux走的却是一条截然不同的开放之路（当然linux也有收费的服务，但是这和开源并不矛盾），在这里我主要讲GNU和FSF。我们的主人公是Stallman，在百度百科上可以看见他的介绍是“自由软件运动的精神领袖”，而本人是一个长得很像哈利波特中的海格的一个大叔。由于历史环境原因和其他的种种因素，他一直想成立一个开放的程序员团体来为自由软件而工作，但一直没有成功。

后来1983年他接触到了Unix，觉得这个操作系统的移植性非常好，便将自己的工作环境迁移到Unix下，这是他迈出的第一步。1984年，他开始了GUN项目，这个项目的目的是**创建一个自由开放的UNIX 操作系统**，他开始独立着手编写一些免费的Unix来为自己的项目打开知名度。他编写的著名软件有gcc，emacs，bash，成立自由软件基金会，并且为了防止自己苦心经营的GNU为其他的商家做嫁衣，与律师草拟通用公共许可证（GPL），并称之为CopyLeft。这些都在1990年左右完成。

### make

这个开放源码最初的目的就是大家一起为一个软件团队工作，形成自由的生态圈，还有就是每个人可以自己改动并供自己使用，也就是可以私人订制。所以我们可以下载源代码，按照自己的喜好阅读并修改源码，然后自行编译安装。 

这也就是make程序做的事情，它会根据makefile的参数配置，自动编译链接安装。

###tarball

tarball实际上就是源码的压缩包，也就是我们下载的.tar.gz文件。里面通常会有源代码，程序检测文件（生成makefile）和相关信息（readme等）。

## 5.apt-get

而这个步骤全要用户亲力亲为可能又有些麻烦，懒是科技发展的重要推动力。所以软件厂商自己编译好了很多二进制文件，只要系统和环境对应，下载之后就能直接安装。

但是如果下载了很多软件我想要管理怎么办？

下载器中一个软件还需要依赖很多别的软件怎么办？

想要及时更新怎么办？

那么把自己下载的历史信息记录下来，软件也记录自己的版本信息和依赖包。

服务器也记录这些信息，这就是软件管理器了。

redhat主要是rpm和更高级的yum，debian主要是dpkg和更高级的apt。


###源

源和软件仓库实际上是一个意思，厂商将编译后的二进制文件和软件信息存放至服务器，用户需要安装软件时，包管理器自动分析本机和容器（repository）内的信息，下载需要的包并自动安装，安装后将新安装的软件信息存放至本地数据库。如果有前置软件没有安装，rpm和dpkg会提示安装失败，也可以强制安装，yum和apt会自动安装全部需要的依赖包。更新和卸载也同理。
这些源的位置记录在`/etc/apt/sources.list`，我们可以手动修改这些文件，但是修改重要系统配置前先备份是一个好习惯（`sudo cp /etc/apt/sources.list /etc/apt/sources.list_backup`）。

###apt-get相关目录

**/var/lib/dpkg/available**

> 文件的内容是软件包的描述信息, 该软件包括当前系统所使用的 ubunt 安装源中的所有软件包,其中包括当前系统中已安装的和未安装的软件包.

**/var/cache/apt/archives**

> 目录是在用 apt-get install 安装软件时，软件包的临时存放路径

**/etc/apt/sources.list**

> 存放的是软件源站点

**/var/lib/apt/lists**

> 使用apt-get update命令会从/etc/apt/sources.list中下载软件列表，并保存到该目录

### 安装位置

| 位置             | 信息       |
| -------------- | -------- |
| /usr/bin       | 二进制文件    |
| /usr/lib       | 动态函数库文件  |
| /usr/share/doc | 使用手册     |
| /usr/share/man | man page |

而我自己编译，自己手动安装软件的时候，喜欢将该文件的根目录放到/usr/local下，这样安装的好处是卸载方便，直接删除就基本完成了，而且不同的软件泾渭分明，不会说大家的文件混一起不好找。如果是那样的话，只能使用locate或者find之类的命令辅助查询了。

但是手动这样安装也有不好的地方，就是会导致man命令和一些二进制命令不能直接使用，这也是为什么我们安装完以后需要配置PATH的原因。

man命令同理，如果有需要可以在/etc/manpath.config文件中定义，这样就能查询该软件的man手册了。

###apt-get update

**sudo apt-get update 执行这条命令后计算机做了什么？**

无论用户使用哪些手段配置APT软件源，只是修改了配置文件——/etc/apt/sources.list，目的只是告知软件源镜像站点的地址。但那些所指向的镜像站点所具有的软件资源并不清楚，需要将这些资源列个清单，以便本地主机知晓可以申请哪些资源。

用户可以使用“apt-get update”命令刷新软件源，建立更新软件包列表。在Ubuntu Linux中，“apt-get update”命令会扫描每一个软件源服务器，并为该服务器所具有软件包资源建立索引文件，存放在本地的/var/lib/apt/lists/目录中。 使用apt-get执行安装、更新操作时，都将依据这些索引文件，向软件源服务器申请资源。因此，在计算机设备空闲时，经常使用“apt-get update”命令刷新软件源，是一个好的习惯。

###apt-get install

**sudo apt-get install XXX 后计算机做了什么？**

使用“apt-get install”下载软件包大体分为4步：

> 1. 扫描本地存放的软件包更新列表（由“apt-get update”命令刷新更新列表，也就是/var/lib/apt/lists/），找到最新版本的软件包；
> 2. 进行软件包依赖关系检查，找到支持该软件正常运行的所有软件包；
> 3. 从软件源所指 的镜像站点中，下载相关软件包，并存放在/var/cache/apt/archive；
> 4. 第四步，解压软件包，并自动完成应用程序的安装和配置。

###apt-get upgrade

**sudo apt-get upgrade 后计算机做了什么?**

使用“apt-get install”命令能够安装或更新指定的软件包。而在Ubuntu Linux中，只需一条命令就可以轻松地将系统中的所有软件包一次性升级到最新版本，这个命令就是“apt-get upgrade”，它可以很方便的完成在相同版本号的发行版中更新软件包。

在依赖关系检查后，命令列出了目前所有需要升级的软件包，在得到用户确认后，便开始更新软件包的下载和安装。当然，apt- get upgrade命令会在最后以合理的次序，安装本次更新的软件包。系统更新需要用户等待一段时间。



## 6.pip

pip是一个专门用于下载管理python库的软件。

使用pip下载的库，都会到PyPi，python官方镜像站去下载。并且可选择版本，apt则是只能下载最新。

她有pip和pip3的区别，当同时拥有两个python版本时，pip3用于安装python3的库，pip安装python库。

在ubuntu下pip需要自行安装：

1. 可执行命令sudo apt-get install python3-pip安装python3.x的pip


2. 或者sudo apt-get install python-pip安装python2.x的pip

*注：安装前最好sudo apt-get update一下*



>  python的可执行文件的目录一般在/usr/bin下，通过apt-get安装的应用一般会在这个目录.
>
>  自行安装的一般在/usr/local/bin下。



>  python3.5的自带库目录在:
>
>  /usr/lib/python3/dist-packages
>
>  /usr/lib/python3.5/



> python2.7的自带库目录在:
>
> /usr/lib/python2.6/dist-packages
>
> /usr/lib/python2.7/



> 通过pip安装的模块目录在:
>
> ~/.local/lib/python3.5/site-packages
>
> ~/.local/lib/python2.7/site-packages
>
> 或者/usr/local/lib/python2.7/dist-packages



## 7.virtalenvwrapper

virtualenv 是一个创建隔绝的Python环境的工具。virtualenv创建一个包含所有必要的可执行文件的文件夹，用来使用Python工程所需的包。

我是一个纠结主义者。。不管是软件或者库都希望管理好，而不让我的电脑处于混乱。所以虚拟环境对于我来说至关重要。在这里的东西，我可以尽情放飞自我，实在不行删了就是了，反正也不影响我的电脑环境。

使用pip3下载安装virtalenvwrapper

使用vi .bashrc，配置环境变量

```shell
export WORKON_HOME=~/virtualenvs
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
export VIRTUALENVWRAPPER_VIRTUALENV=~/.local/bin/virtualenv
source ~/.local/bin/virtualenvwrapper.sh
```

最后source  .bashrc，让我配置的环境变量生效即可。

接下来，就可以创建一个虚拟环境了。

```mkvirtualenv -p /usr/bin/python py2```

可以使用**workon py2**进行虚拟环境中。

在虚拟环境中安装的包，不会和系统中的python包相冲突。

## 8.压缩和解压
如果你想要在Linux下遨游，压缩和解压缩是必然会遇到，并且会经常遇到的，所以必须学会。

纵观计算领域的发展历史，人们努力想把最多的数据存放到到最小的可用空间中，不管是内存，存储设备还是网络带宽。

今天我们把许多数据服务都看作是理所当然的事情，但是诸如便携式音乐播放器，高清电视，或宽带网络之类的存在都应归功于高效的数据压缩技术。

压缩算法（数学技巧被用来执行压缩任务）分为两大类，无损压缩和有损压缩。

无损压缩保留了原始文件的所有数据。这意味着，当还原一个压缩文件的时候，还原的文件与原文件一模一样。

而另一方面，有损压缩，执行压缩操作时会删除数据，允许更大的压缩。

当一个有损文件被还原的时候，它与原文件不相匹配; 相反，它是一个近似值。有损压缩的例子有JPEG（图像）文件和MP3（音频）文件。

**当然，我现在只想了解无损压缩。因为计算机中的大多数数据是不能容忍丢失任何数据的。**

###gzip
1. gzip 程序被用来压缩一个或多个文件。当执行gzip 命令时，则原始文件的压缩版会替代原始文件。
2. 相对应的gunzip 程序被用来把压缩文件复原为没有被压缩的版本。
3. 使用gzip -rv ~/test,是分别压缩test目录下的每个文件，而不是压缩test目录。
4. 压缩文件后缀是.gz。
**注意：只能压缩文件,可一次性压缩很多文件。**


###bzip2
1. bzip2 程序与gzip 程序相似，但是使用了不同的压缩算法，舍弃了压缩速度，而实现了更高的压缩级别。
2. 在大多数情况下，它的工作模式等同于gzip。
3. 压缩文件后缀是.bz2。
**注意：只能压缩文件，并且只能压缩单个文件，因为和gzip相比，缺少了-r参数。**


###tar
1. 与文件压缩结合一块使用的文件管理任务是归档。
2. 归档就是收集许多文件，并把它们捆绑成一个大文件的过程。
3. tar 程序是用来归档文件的经典工具。它的名字，是tape archive 的简称，揭示了它的根源，它是一款制作磁带备份的工具。
4. 而它仍然被用来完成传统任务，它也同样适用于其它的存储设备。
5. 我们经常看到扩展名为.tar 或者.tar.gz 的文件，它们各自表示“普通”的tar 包和被gzip 程序压缩过的tar 包。
**注意：归档只是把许多文件捆绑成一个大文件，它并不压缩文件，只是为了给压缩文件做准备。**

## 9.shell环境
### shell环境有什么？
shell在环境中存储了两种基本类型的数据，它们是环境变量和shell变量。除了变量，shell也存储一些可编程的数据，命名为别名和shell函数。

### 如何查看shell环境？
我们可以用printenv，set，alias来查看shell环境。
set命令可以显示shell和环境变量两者。
printenv只显示环境变量。
如果shell 环境中的一个成员既不可用set 命令也不可用printenv 命令显示，则这个变量是别名。

### 如何建立shell环境？
1. 当我们登录系统后，启动bash程序，并且会读取一系列称为启动文件的配置脚本，这些文件定义了默认的可供所有用户共享的shell环境。
2. 读取更多位于我们自己主目录中的启动文件，这些启动文件定义了用户个人的shell环境。
3. 精确的启动顺序依赖于要运行的shell会话类型：登录shell会话，非登录shell会话。
4. 登录shell会话会提示用户输入用户名和密码；例如，我们启动一个虚拟控制台会话。
5. 当我们在GUI模式下运行终端会话，即为非登录会话。

**登录shell会话：**
| 文件               | 内容       |
| ------------------ | ---------- |
| /etc/profile       | 应用于所有用户的全局配置脚本    |
| ~/.bash_profile    | 用户私人的启动脚本。可以用来扩展或重写全局配置脚本中的设置。  |
| ~/.bash_login      | 如果.bash_profile没有找到，bash会尝试读取这个脚本     |
| /.profile          | 如果上面两个没找到，bash会尝试读取这个脚本  |

**非登录shell会话：**
| 文件               | 内容       |
| ------------------ | ---------- |
| /etc/bash.bashrc       | 应用于所有用户的全局配置脚本    |
| ~/.bashrc    | 用户私人的启动脚本。可以用来扩展或重写全局配置脚本中的设置。  |

**注意：**
> 除了读取以上启动文件外，非登录shell会话也会继承它们父进程的环境设置，通常是一个登录shell。
> 在普通用户看来，文件~/.bashrc可能是最重要的启动文件，因为它几乎总是被读取。
> 非登录用户默认会读取~/.bashrc文件。
> 大多数登录shell的启动文件会以读取~/.bashrc文件的方式来书写~/.bash_profile


### 修改文件定制shell环境？
1. 所需修改的文件就是/etc/profile,~/.bash_profile,/etc/bash.bashrc,~/.bashrc.
2. 最好使用vim进行编辑。
3. 修改好你的shell配置环境后，一定要对更改加注释#。
4. 使用source .bashrc等，即source命令来激活我们的修改。

### 思维延伸
> export
> export命令告诉shell让这个shell的子进程可以使用PATH变量的内容。
> export这个命令，最开始我是在makefile里面重视起来的。
> 如果我要传递变量到下级makefile中，那么则需要使用export   <variable>。
> 如果不想某些变量传递到下级makefile中，则需要使用unexport <variable>。
> 什么是下级makefile，他不是指mk2使用include mk1,则mk2为mk1的下级makefile，错！
> 下级makefile是指：在mk2中使用make -c mk1，那么mk1则为mk2的下级makefile。 对！
> SHELL和MAKEFLAGS，这两个变量不管你是否export，其总是要传递到下层Makefile。
> 如果你不想往下层传递参数，cd subdir && $(MAKE) MAKEFLAGS=
> 当make嵌套调用时，上传makefile中定义的变量会以系统环境变量的方式传递到下层的makefile中。
> 默认情况下，只有通过命令行设置的变量会被传递。
> 而定义在文件中的变量，如果要向下层makefile传递，则需要使用export关键字来声明。

> 知名达意
> export 出口，输出的意思。也即是把自己在用的变量也输出给自己的子进程或下级makefile享用享用。
> 同样的还有import，这个关键字是在Python里面有用到。
> import 进口，输入的意思。也即是我想用某些变量或函数，刚巧某个库里面有，我就把她进口过来享用享用。
> 类似的还有C语言常用的include等等，include 包括，包含。
> 但include的目的只是把几个小的C文件或者makefile，最后合成一个大的C文件或者makefile，却并没有主次之分。



## 10.Python最佳实践指南

1. Python版本的选择，最好是3.
2. Python解释器，最好用cpython，其他需求可选：PyPy，jpython，ironpython，pythonnet等。
3. 安装Python，推荐安装Python3，setuptools，pip。
4. 安装虚拟环境：pipenv，virtualenv，virtualenvwrapper，virtualenv-burrito，autoenv
5. 使用文本编辑器：vim可定制插件，emacs，textMate，sublime，atom，pycharm
6. 写优雅可读的Python代码
7. 字节码和可变默认参数export PYTHONDONTWRITEBYTECODE=1
8. 基于不同应用场景的Python库。
9. 打包冻结代码，py2exe，pyinstaller，bbFreeze，cx_freeze

> 这大概就是我得到的收获。通过阅读此指南，我知道Python的版本和安装，以及解释器的选择，了解到了Python的文本编辑器原来这么多，而优雅可读的代码真的很pythonic。

> 恩，也清楚了Python虚拟环境对于开发的重要，以及字节码的可恶，虽然可以加快运行速度，但开发过程中确实不需要。

> 重要的是，我看到了好多的Python库，并都有各自的应用场景，对于图形图像，机器学习和数据处理，人工智能也有好多。

> 最后，打包冻结生成别人可用的程序，就是我们成果的展示，也是很重要的。

