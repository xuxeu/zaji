# Git-runner环境搭建

[TOC]

## 安装Git

需要安装对应的git主程序。举个栗子：Git-2.11.1-64-bit.exe

安装git的可视化操作组件，类似svn的右键操作。如：TortoiseGit-2.4.0.0-64bit.msi

## 配置Git



通过开始--->GIT--->Git Bash打开git的shell终端，在shell下配置git的全局环境：

```
git config --global user.name “me”
git config --global user.mail“me@coretek.com.cn”
```

生成sshkey

```
ssh-keygen.exe–t rsa –C “me@coretek.com.cn”
```

输入上述命令后，会提示输入密码，直接按3个回车，不输入密码即可。命令执行完成之后，在.ssh目录下会生成两个文件，id_rsa【私钥】和id_rsa.pub【公钥】【路径可能是在C:\Users\Administrator\.ssh】

## 和gitlib关联

保存公钥至git服务器端

通过浏览器打开git服务器【前提是已经有用户名和密码可以登录git服务器】。

点击右上角的用户图标，选择Profile Setting，再选择SSH Keys项，底下会出现一个key的输入框，将生成的id_rsa.pub文件里的内容全部复制到key框中。

Title框可随便输入一个名字，点击Add key按钮，完成git服务器端公钥的添加。

## 安装jdk

安装Java开发工具集：jdk-8u71-windows-x64

## 安装Python

安装Python2.7.10

安装库pywin32-218.win32-py2.7

安装Python的IDE：pycharm-community-2018.1.2

设置字体:file->setting->Editor->Font

使用```ctrl+`~```，设置自己的风格

## 安装VMware

安装VMware，以及DOS系统，修改grub，放置TA

## 修改路径

修改py脚本中的路径，用于匹配我的电脑开发环境

## 修改文件格式

修改Python和批处理的文件格式为ASCII，并改```# -*- coding: GB2312 -*-```

## 修改环境变量

设置make等工具的环境变量
```
set PATH=%PATH%;G:\gitlibAuto\AutoBuild\platform\host\bin
```

## 本地运行流程

1. 设置环境变量
2. 编译父模型文件，编译IDE项目插件，提交插件
3. 编译工具库文件
4. 编译os项目
5. 编译dkm项目
6. 建立目标机连接通道
7. 启动虚拟机
8. 运行os，运行dkm项目


## pwd

*win下是没有pwd命令的！*

## gitlib

gitlib是一个利用ruby on rails开发的开源应用程序，实现一个自托管的Git项目仓库，可通过web界面进行访问公开的或者私人项目。

它拥有与GitHub类似的功能，能够浏览源代码，管理缺陷和注释。

可以管理团队对仓库的访问，它非常易于浏览提交过的版本并提供一个文件历史库。

团队成员可以利用内置的简单聊天程序（Wall）进行交流。

它还提供一个代码片段收集功能可以轻松实现代码复用，便于日后有需要的时候进行查找。

## Gitlib-CI

Gitlab-CI是GitLab Continuous Integration（Gitlab持续集成）的简称。

从Gitlab的8.0版本开始，gitlab就全面集成了Gitlab-CI,并且对所有项目默认开启。

只要在项目仓库的根目录添加`.gitlab-ci.yml`文件，并且配置了Runner（运行器），那么每一次合并请求（MR）或者push都会触发CI pipeline。

`.gitlab-ci.yml`的脚本解析就由它来负责。

## Gitlab-runner

Gitlab-runner是`.gitlab-ci.yml`脚本的运行器，Gitlab-runner是基于Gitlab-CI的API进行构建的相互隔离的机器（或虚拟机）。

这个是脚本执行的承载者，`.gitlab-ci.yml`的script部分的运行就是由runner来负责的。GitLab-CI浏览过项目里的`.gitlab-ci.yml`文件之后，根据里面的规则，分配到各个Runner来运行相应的脚本script。这些脚本有的是测试项目用的，有的是部署用的。

GitLab Runner 不需要和Gitlab安装在同一台机器上，但是考虑到GitLab Runner的资源消耗问题和安全问题，也不建议这两者安装在同一台机器上。

Gitlab Runner分为两种，Shared runners和Specific runners。

Specific runners只能被指定的项目使用，Shared runners则可以运行所有开启` Allow shared runners`选项的项目。

### GitRunner注册

1、gitlab-runner-windows-386 register

```shell
1)Settings->CI/CD->Runners settings里面的URL
2)Settings->CI/CD->Runners settings里面的注册令牌
3)描述随便写
4)tag可随便写
5)其他默认
6)最后输shell
```

2、git-runner install
3、git-runner start

在Git服务器上可以看见**Runners activated for this project**对应有刚注册的runner，且显示为绿色，则成功。

4、另外会有git-runner stop，git-runner uninstall ，git-runner restart。

### 注册令牌是什么？



### 带空格的路径

当yaml脚本里的变量带空格，可把变量带上双引号来传参给Python

## pipelines

Pipelines是定义于`.gitlab-ci.yml`中的不同阶段的不同任务。

我把Pipelines理解为流水线，流水线包含有多个阶段（stages），每个阶段包含有一个或多个工序jobs。

比如先购料、组装、测试、包装再上线销售，每一次push或者MR都要经过流水线之后才可以合格出厂。

而`.gitlab-ci.yml`正是定义了这条流水线有哪些阶段，每个阶段要做什么事。

## Gitrunner启动

Gitrunner启动是靠Gitrunner所在服务器的命令行！而且该命令行是SYSTEM用户名。

可以在进程中，看到，只要Gitrunner启动一个job，就会在进程中多一个cmd.exe

因此我需要在SYSTEM账户下注册一个git，并把它的公钥放到gitlib上。

在使用jenkins或者gitlib自带的CI调用命令行工具的时候，jenkins使用system身份调用，这使得在admin身份时设置的某些功能在system时不起作用，所以我们也要获得system身份来进行配置。

## 如何在cmd中切换为SYSTEM

我是使用了微软官方的工具。步骤如下：

 1. 从微软网站下载[PSTool](http://download.sysinternals.com/files/PSTools.zip)。
 2. 以管理员运行CMD，进入到解压的PSTool目录。
 3. 运行psexec -i -s cmd.exe
 4. 在新打开的CMD中运行whoami，或者从进程中也可以看到！

怎么样？是不是已经(ˉ▽￣～) 切~~换过来了呢？

**然后我就在SYSTEM账户下的cmd，注册了git，并把它的key放到了gitlib的liyj账户中去。**

## unable to unlink old

error: unable to unlink old 'platform/host/pub/ts/log/MsgLog/app.log': Invalid argument

这种情况一般就是app.log 被某个程序占用了

## 任务须知

这次有个任务，就是支持gitlib上的自动编译测试。

完成阶段：

1. 完成了gitlib环境搭建
2. 完成了rtp的自动编译
3. 完成了rtp在本地的自动运行
4. 完成了rtp在gitlib上的CI/CD
5. 完成了最终的测试用例统计

以及还有个任务是打包在gitlib上的arm平台。

这个任务已经完成，并且实现了通环的自动打包。

我们现在的步骤是：

1. IDE源码在gitlib上，但我要把它先下下来，然后编译IDE源码，这符合集成测试逻辑吗？
2. 工具库在本地
3. platform在本地，在这里我们要编译os以及dkm和rtp，以及创建目标机连接
4. 启动虚拟机
5. 在虚拟机中运行os，在os上运行dkm或者rtp
6. 关闭虚拟机和ts

新的需求：

1. 现在我们的gitlib-ci.yml在IDE的源码库里，它的名字叫x86_platform
2. **但是我们现在需要依赖更多的源码库，需把目标机端的代码提交到gitlib，需把操作系统的库加进来**
3. 项目platform需要保存到gitlib。我们需把编译好的插件和库放到本地的platform就可以测试，测试完成后需要提交。
4. 当真正需要打包该版本的platform时，我们只需走以上流程，就可以获得最新的platform。
5. **我们现在把所有的都部署到服务器，除了Gitrunner在我本地电脑上，因此，我需要注册3个runner，一个插件用，一个工具库用，一个测试用。**
6. **自动提交代码到gitlib。**这也挺简单，就几个命令：
7. 现在环境变量的设置是一个问题。在Python中使用environ解决。
8. 库的位置解决方案，我认为写到Makefile里去就行了，我们给他提供platform根目录就行了，他想放在platform的哪个目录，他就自己写在Makefile。
9. 注意，一个文件在gitlib上最好不要重复，不然很容易出错。尽量保证唯一性。
10. 现行的解决方法是：在服务器上checkout出一个platform版本。但有个问题是：服务器上的platform版本最初是master，如果是普通开发者又要切换branch分支，这样好吗？**这样很容易出现问题。**有更好的解决办法吗？可以把服务器上生成的文件传给普通开发者的电脑吗，不，这样也不行。其实最大的问题是，普通开发者是不能随意去操控服务器的。怎么做到服务器中platform版本的自动切换就是要解决的。
11. 可以在个人电脑上部署Gitrunner吗？这样的话，想想，没人的电脑上都有runner，很容易跑错了。正常的做法是每个项目只有一个runner。
12. **Gitrunner的创建，platform的checkout，都需要一个远程连接**

## gitlib集成编译测试打包最终步骤

1. 项目负责人在gitlib上创建项目，并设置项目权限为maintainer，默认即可。
2. 对新项目添加成员，设置成员权限。一般为developer，即可以创建分支，但没有往master提交代码的权限。
3. 项目负责人使用远程桌面对Gitrunner所在服务器进行创建新的runner，并把platform checkout到服务器本地。
4. 修改yml脚本里的变量PLATFORM_PATH为checkout出的地址路径。
5. 修改yml脚本里的变量BRANCH为开发者的分支。

这样，一个项目的准备工作都已经做好。每个developer只需自己创建分支，并把分支检出到自己的本地电脑即可操作，提交便会触发编译和测试。

## 后续工作

1. 脚本和源码的路径问题，需改进
2. 需把Gitrunner部署到服务器
3. 需使用远程连接登录服务器
4. 需找一个真实的项目来使用
5. 自动打包还未集成到里面去

