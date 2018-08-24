# git学习笔记

*outline*

[TOC]

## git是什么？

Git是目前世界上最先进的**分布式版本控制系统**（没有之一）。

Git有什么特点？简单来说就是：**高端大气上档次**！

## Git的诞生

**Linus在1991年创建了开源的Linux**，从此，Linux系统不断发展，已经成为最大的服务器系统软件了。

Linus虽然创建了Linux，但Linux的壮大是靠全世界热心的志愿者参与的，这么多人在世界各地为Linux编写代码，那Linux的代码是如何管理的呢？

事实是，在**2002年**以前，世界各地的志愿者把源代码文件通过diff的方式发给Linus，然后由Linus本人通过手工方式合并代码！

到了2002年，Linux系统已经发展了十年了，代码库之大让Linus很难继续通过手工方式管理了，社区的弟兄们也对这种方式表达了强烈不满，于是Linus选择了一个商业的版本控制系统BitKeeper，BitKeeper的东家BitMover公司出于人道主义精神，授权Linux社区免费使用这个版本控制系统。

安定团结的大好局面在**2005年**就被打破了，原因是Linux社区牛人聚集，不免沾染了一些梁山好汉的江湖习气。开发Samba的Andrew试图破解BitKeeper的协议（这么干的其实也不只他一个），被BitMover公司发现了（监控工作做得不错！），于是BitMover公司怒了，要收回Linux社区的免费使用权。

**Linus花了两周时间自己用C写了一个分布式版本控制系统，这就是Git！**一个月之内，Linux系统的源码已经由Git管理了！牛是怎么定义的呢？大家可以体会一下。

Git迅速成为最流行的分布式版本控制系统，尤其是**2008年，GitHub网站上线了**，它为开源项目免费提供Git存储，无数开源项目开始迁移至GitHub，包括jQuery，PHP，Ruby等等。

历史就是这么偶然，如果不是当年BitMover公司威胁Linux社区，可能现在我们就没有免费而超级好用的Git了。

## 配置Git

安装完成后，还需要最后一步设置，在命令行输入：

```
$ git config --global user.name "Your Name"
$ git config --global user.email "email@example.com"
```

因为Git是分布式版本控制系统，所以，每个机器都必须自报家门：你的名字和Email地址。你也许会担心，如果有人故意冒充别人怎么办？这个不必担心，首先我们相信大家都是善良无知的群众，其次，真的有冒充的也是有办法可查的。

注意`git config`命令的`--global`参数，用了这个参数，表示你这台机器上所有的Git仓库都会使用这个配置，当然也可以对某个仓库指定不同的用户名和Email地址。

## 注册gitlib账号

~~这个这个，我也没注册呢。。~~但应该不难吧！你注册GitHub账号，难吗？略。

## 和gitlib关联

保存公钥至git服务器端

通过浏览器打开git服务器【前提是已经有用户名和密码可以登录git服务器】。

点击右上角的用户图标，选择Profile Setting，再选择SSH Keys项，底下会出现一个key的输入框，将生成的id_rsa.pub文件里的内容全部复制到key框中。

Title框可随便输入一个名字，点击Add key按钮，完成git服务器端公钥的添加。

保存公钥的目的是告诉gitlib服务器，这台电脑是可信任的！

而这个操作是gitlib的用户操作，那么该用户需对此操作负责。

对于一个项目来说，gitlib账户是一个个真实的人。该项目把gitlib账户1加为developer，如果账户1需要对该项目进行开发，就可以直接push然后切换分支，进行开发了。

可是，如果gitlib账户1的电脑并没有生成key放到gitlib服务器。那么该电脑是没法取得gitlib服务器的信任的。

## gitlib权限问题

对于项目主干即master，只有拥有者即maintainers具有push，merge功能。*当然，还有万能的admin。*

普通开发者developers应该做的是，自行创建branch分支，才可push代码，当完成一个功能，可以申请merge，让maintainers进行合并。

对于赋权，是在成员的添加处添加成员的权限级别，默认赋权级别应该是不高于developer。

以及仓库的设置处Protected Branches对于分支的访问权限。默认应该是maintainers+owner。

## gitlib分支问题

既然，普通开发者不能push到master，那么我们只能切分支了。

1. 第一步，肯定是先把master 给pull下来，因为分支也依赖于master！

   git@192.168.11.72:liyj/LambdaPro.git，此为ssh

2. 在gitlib创建一个分支test

3. git fetch origin test，在gitlib上创建新分支好了后，需要用命令来fetch一下该分支

4. 可以使用git branch -a，查看本地有几个分支

5. git checkout -b test origin/test,这是拉取远程分支到本地

6. git checkout master

7. 以后就可以正常一样在分支下玩耍了。比如：

   git pull origin test

   git push -u origin test

   git add .，添加文件到仓库

   git commit -m "tian jia zhu shi",提交文件到仓库

## git查看配置信息

config 配置指令`git config`

config 配置有system级别 global（用户级别） 和local（当前仓库）三个 设置先从system-》global-》local  底层配置会覆盖顶层配置 分别使用--system/global/local 可以定位到配置文件。

查看系统config

```
git config --system --list
```

查看当前用户（global）配置

```git
git config --global  --list
```


查看当前仓库配置信息

```
git config --local  --list
```

## Git修改配置信息

```
git config --global --replace-all user.email "输入你的邮箱" 

git config --global --replace-all user.name "输入你的用户名"

$ git config --global user.name "Your Name"

$ git config --global user.email "email@example.com"

```

## git常用命令

```
git add .，添加文件到仓库
git status，仓库当前状态
git commit -m "tian jia zhu shi",提交文件到仓库
git push -u origin master
```



```
git init，创建本地仓库，会生成.git目录，可用ls -ah查看
git remote add origin ssh://me@192.168.16.135:29418/test.git    关联远程仓库
git clone ssh://me@192.168.16.135:29418/tools-source.git    从远程仓库克隆到本地
```

## ssh-keygen 

虽然一直知道ssh，但真正使用ssh-key还是因为gitlib。

为了让两个机器之间使用ssh不需要用户名和密码，所以我们采用了数字签名RSA或者DSA来完成这个操作。

来来来，建个魔：

假设 ：

1. A （192.168.20.59）为客户机器。
2. B（192.168.20.60）为目标机。

要达到的目的：

1. A机器ssh登录B机器无需输入密码。
2. 加密方式选 rsa|dsa均可以。

使用工具：

ssh-keygen.exe

使用命令：

ssh-keygen -t rsa -C  “文字”

操作过程：

1. 登录A机器
2. ssh-keygen -t rsa -C  “文字”，将会生成公钥id_rsa.pub和私钥文件id_rsa。
3. 将id_rsa.pub复制到B机器的.ssh目录，并cat id_dsa.pub >> ~/.ssh/authorized_keys。
4. 大功告成，从A机器登录B机器的目标账户，不需要使用密码了，直接运行**#ssh 192.168.20.60**。

当然，对于gitlib则是把id_rsa.pub的内容放到gitlib的sshkey中，这样，本机的git登录gitlib就可以不需要账户和密码了。