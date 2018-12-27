# docker集装箱宝宝

[TOC]

## 从泡沫到戳破

好久都想实现自己所有的APP都docker化，想着那一定是一个有趣的创举。可是为何一直没有实现？

那是因为什么？什么？什么？理由这么多？那还不是因为我有**拖延症**！！！学习不能拖拖拉拉，不然怎么能嘻嘻哈哈！

现在，我第1024次下定决心，一定要完成它，yami！no，yaml！

## 搭建环境

### 选择环境

木有办法啊，我的开发机是win7，所以，就选win7的docker啦，虽然可能比较和win10不一样。但是，我们从来都不一样啊。

### 下载安装包

DOCKER CE FOR WINDOWS是Docker官方提供的一个可以快速、便捷地在Windows PC上安装Docker开发环境的本地Windows桌面应用。*但这只限于win10*

win7的则较为复杂：

Docker在Windows7（windows7之前）系统下的安装需要使用Docker Toolbox。

### 安装Toolbox

Toolbox包含以下Docker工具：

- Docker Machine for running `docker-machine` commands
- Docker Engine for running the `docker` commands
- Docker Compose for running the `docker-compose` commands
- Kitematic, the Docker GUI
- a shell preconfigured for a Docker command-line environment
- Oracle VirtualBox


下载官方地址：https://docs.docker.com/toolbox/overview/

或者国内镜像地址：https://mirrors.aliyun.com/docker-toolbox/windows/docker-toolbox/

主要是官方地址，下载网速太太太垃圾。

安装过程？默认即可。

### 下载安装boot2docker

打开docker quickstart，docker会去GitHub上去下载最新的boot2docker到本地电脑去。

但要是你的网速卡，爱，主要GitHub服务器在国外。

你可以使用迅雷等下载工具，然后，放到`C:\Users\luosy\.docker\machine\cache`里去就可以了。

### boot2docker是个啥？

boot2docker是基于tiny core Linux的轻量级Linux发行版，专为docker准备，完全运行于内存中，24M大小，启动仅仅5-6秒。

那么，为啥docker一起来就要运行boot2docker呢？而且还依赖vbox。

是不是可以这样理解，boot2docker就是在Windows下，用VBox运行Linux，然后再跑docker？

最后发现，docker依赖Linux的特性，其他平台要想跑个docker，就得开虚拟机。但真要搭个服务器，肯定用Linux啊，也就不需要虚拟机了。

### VBoxManage hostonlyif create fail

这个问题，我试了！需要重新下载一个virtual box来安装就可以了，自带的有问题！

### 你看到了什么？

当你历经重重困难，你看到了什么？当然是一个鲸鱼的标志啦！

这说明什么？这只能说明你的环境搭好了，boot2docker在VBox里面跑起来了。。。

输入`docker info`可以看到具体信息。可以看到，目前还没有container，也没有images。

## docker基本概念

Docker 包括三个基本概念
镜像（ Image ）
容器（ Container ）
仓库（ Repository ）
理解了这三个概念，就理解了 Docker 的整个生命周期。

### 镜像image

类似于虚拟机中的镜像，是一个包含有文件系统的面向docker引擎的只读模板。任何应用程序运行都需要环境，而镜像就是用来提供这种运行环境的。例如一个Ubuntu镜像就是一个包含Ubuntu操作系统环境的模板，同理在该镜像上装上Apache软件，就可以称为Apache镜像。

### 容器container

类似于一个轻量级的沙盒，可以将其看作一个极简的Linux系统环境（包括root权限、进程空间、用户空间和网络空间等），以及运行在其中的应用程序。docker引擎利用容器来运行、隔离各个应用。容器是镜像创建的应用实例，可以创建、启动、停止、删除容器，各个容器之间是相互隔离的，互不影响。注意：镜像本身是只读的，容器从镜像启动时，docker在镜像的上层创建一个可写层，镜像本身不变。

### 仓库repository

类似于代码仓库，这里是镜像仓库，是docker用来集中存放镜像文件的地方。注意与注册服务器registry的区别：

1. 注册服务器是存放仓库的地方，一般会有多个仓库；而仓库是存放镜像的地方，一般每个仓库存放一类镜像，每个镜像利用tag进行区分，比如Ubuntu仓库存放有多个版本的Ubuntu镜像。


