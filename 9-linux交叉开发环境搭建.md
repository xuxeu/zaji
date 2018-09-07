

# linux交叉开发环境搭建

因为此次需要在linux上面进行调试，所以需要搭建系统。我的想法是：主机是linux的ubuntu16-64，然后在主机上面安装mware虚拟机，然后在虚拟机里面再次安装ubuntu16-64。

[TOC]

## 1.安装宿主机ubuntu16-64

安装宿主机linux应该很简单，但也有注意的地方。我想了想，主要有三点。

1. 如果是双系统，安装类型时得选择其它，他能让你很好的掌控硬盘分区。

2. 如果是双系统，得注意选择安装启动引导器的设备，选择为boot目录所在的分区。然后，安装好以后，通过easyBCD把启动项放在表里。

3. 注意分区，主要有:

   /根目录和swap交换分区，这是必须的；

   /boot目录，用于启动操作系统linux的；

   /usr目录，用于放置用户程序的；

   /home目录，用于用户工作空间。




## 2.安装宿主机的中文字体

1. 先安装语言包

   System Settings–>Language Support–>Install/Remove Languages选中chinese，点击Apply应用即可，等待下载安装完成。

2. 安装ibus框架

   ```sudo apt-get install ibus ibus-clutter ibus-gtk ibus-gtk3 ibus-qt4```

3. 启动ibus框架

   ```im-config -s ibus```

4. 安装拼音引擎

   ```sudo apt-get install ibus-pinyin```
   安装完之后需重启机器

5. 设置快捷切换
   使用text entry set




## 3.安装虚拟机vmware

1. 用apt-get命令更新系统

    ```shell
    sudo apt-get update
    sudo apt-get upgrade
    ```

2. 从vmware官网下载适合linux的虚拟机版本。

3. 在脚本包上设置执行命令

    ```chmod a+x VMware-Workstation-Full-11.0.0-2305329.x86_64.bundle```

4. 执行脚本开始安装

    ```sudo ./VMware-Workstation-Full-11.0.0-2305329.x86_64.bundle```

5. 接下来就可以进入可视化界面，输入密钥，即可。




## 4.虚拟机中安装ubuntu16-64作为目标机

虚拟机中安装ubuntu就更简单了，首先先创建一个虚拟机，然后就安装了，不细说。
为了能更好的和主机联接工作，可以自由拷贝文件等，vmware tools就必须安装。

1. 进入系统后，在VMware菜单栏找到安装虚拟工具的时候，它会弹出一个文件夹，里面就有VMware Tools的安装包。

2. 把WMwareTools拷贝出来，然后打开终端解压

   ```tar -xzvf  VMwareTools-10.0.6-3595377.tar.gz```


3. 进入解压后的目录，执行脚本

   ```sudo ./wmware-install.pl  然后就一直回车了。```


4. Ubuntu会进行的很顺利，而其他发行版却未必。一直回车到底，到最后提示成功，reboot就可以了。




##5.网络配置

主机和虚拟机之间的通信，这里我用了些时间。
briged，NAT，host-only，我就不细说了，想了解都能找到。我主要记录我的方法，这里我使用的是briged。
因为它的好处是，两台电脑可以各自拥有各自的静态ip，虽然是共用一个物理网卡，但是虚拟机里面会模拟一个mac地址，并且两台电脑都可以上网。
之前我在windows上很简单，只需要在网络适配器处选择briged，然后再虚拟中配好ip即可。
但这次，我的主机和目标机都是linux，所以遇到了些苦难:cry:。我的操作如下：

1. 网络适配器处选择briged

2. virtual network editor，briged中，选择briged to enp3s0，之前是auto

3. 在主机中，使用sudo vi /etc/network/interfaces,在末尾加入(通过ifconfig知道，我的网卡名字叫enp3s0)：

   ```shell
   auto enp3s0

   iface enp3s0 inet static

   address 192.168.16.40

   netmask 255.255.255.0
   ```

4. 在虚拟机中，再做相同的操作，ip和主机在同一网段即可。

5. 在右上角编辑网络中操作。




## 6.使用gdb和gdbserver调试

1. 首先在目标机端：

   ```gdbserver 192.168.16.40:111(hostip:port) test(应用程序)```


2. 在主机端：

   ```shell
   gdb test
   target remote 192.168.16.41:111(targetip:port)
   ```

   ​
   然后，你可以开心的使用b命令打断点，使用c命令运行啦啦啦。

   ​

## 7.通信工具

*Windows 下有飞鸽传书，Linux 下则有 IPtux 和 Dukto。IPtux 是 Linux 下目前最好的局域网通讯工具，没有之一。*
终端中使用如下命里安装即可：
```sudo apt-get install iptux```

“网路”标签中可以添加网段。
如果不添加网段，则只能显示本网段的用户。如我是处于 192.168.16.x 网段，是无法显示 192.168.116.x 网段的好友的。所以添加 192.168.161.1-255 的网段。



##8.ubuntu全局菜单栏

当我从windows转换到ubuntu的时候，使用各种工具总是不习惯，其中有一个就是ubuntu的全局菜单栏。
每当我打开一个窗口，菜单栏就在最上面，然而我使用工具时候也几乎不最大化，因此当我想要趣做一些操作时，总要把鼠标和视线移到屏幕最上方，真的很不习惯。
那么，能不能把菜单栏变回每个应用工具的菜单栏应该在的位置呢？
其实只需要在desktop background(桌面背景设置)中，找到behavior(行为设置)，然后选中in the window's title bar，即可。



## 9.编译gdb和gdbserver

1. 编译gdb7.10

   ```shell
   ../gdb-7.10/configure  --enable-targets=all --enable-64-bit-bfd --prefix=/home/me/Documents/gdbbuild/1-install
   ../gdb-7.10/gdb/gdbserver/configure  --enable-targets=all --enable-64-bit-bfd --prefix=/home/me/Documents/gdbbuild/1-installserver
   ```


2. 配置环境变量

   在~/.bashrc中添加path环境变量的内容
   ```export PATH=/home/me/cross-compile/gdb/bin:/home/me/cross-compile/gdbserver/bin:$PATH```
   具体路径依照实际环境而定。


3. 编译源文件

   ```gcc -g -Wl,-Bstatic -IC -Wl,-Bdynamic -lgcc_s -o test test.c```


4. 进行gdb-gdbserver的调试




## 10.配置NFS

1. NFS服务端安装与配置

  * 下载安装:~$ sudo apt-get install nfs-kernel-server
  * 安装完成后，创建NFS文件夹：~$ sudo mkdir /home/me(用户名)/nfsroot
  * 修改NFS服务器配置：~$ sudo gedit /etc/exports
  * 在exports最后一行写入：/home/me/nfsroot *(rw,sync,no_root_squash,no_subtree_check)

  其中：

  * /home/nfsroot：NFS文件夹
  * *：允许所有的网段访问，也可以使用具体的IP
  * rw：挂载此目录的客户端对该共享目录具有可读可写权限
  * sync：资料同步写入内存和硬盘
  * no_root_squash：root用户具有对根目录的完全管理访问权限
  * no_subtree_check：不检查父目录的权限

2. 重启服务：
  重启rpcbind服务：```~$ sudo /etc/init.d/rpcbind restart```
  重启nfs服务：```~$ sudo /etc/init.d/nfs-kernel-server restart ```

3. NFS客户端安装配置
  NFS客户端在Ubuntu上使用~$ sudo apt-get install nfs-common 安装。ARM开发板则需要重新编译更新内核。
  ```sudo mount -o nolock -t nfs 192.168.16.40:/home/me/nfsroot /mnt```





##11.镜像里的包本地安装

1. 将ubuntu的ISO文件mount到文件系统的某个新建目录下，如新建了/media/ubuntuISO目录，则执行以下命令进行挂载：

   ```sudo mount -o loop ubuntu-10.04.4-dvd-amd64.iso /media/ubuntuISO/```

   注：sudo为在root权限下进行mount操作，是必须的

2. 修改/etc/apt/sources.list文件内容，指定更新源位置，在该文件中屏蔽掉其他的更新源路径，并在文件最后增加以下内容：

   ```deb file:///media/ubuntuISO/ lucid main restricted```

   注：该文件也必须在root权限下修改

3. 执行更新软件包列表命令：

   ```apt-get update```

4. 通过“系统->系统管理->新立得软件包管理器”安装需要的软件包 




##12.安装wine

*Wine 是一个令人神往而且目标远大的开放源代码项目，它尝试去解决在 Linux 上运行 Windows 可执行文件的复杂问题。*
*这样就可以在linux下面玩游戏哟，但现在如果只是玩游戏的话steam更好用啦:smiley_cat:。*

1. 添加PPA

   点击系统->系统管理->软件源->其他软件，点击添加，输入：ubuntu-wine/ppa

2. 更新列表

   ```sudo apt-get update```

3. 安装Wine

   ```sudo apt-get install wine winetricks```

4. tab和enter键一起按，可点击确定。




## 13.键盘错乱

```ibus-daemon -drx```



##14.配置tftp

FTP(Trivial File Transfer Protocol),即普通文件传输协议，是用来传送文件的Internet软件程序,它比文件传输协议(FTP)使用简单,但是功能少。
*在嵌入式系统中（特别是在开发初期），TFTP和NFS（网络文件系统）这两种方式常用来为目标板从服务器上下载程序。*

1. 安装tftp服务

   ```shell
   sudo apt-get install tftp-hpa

   sudo apt-get install tftpd-hpa
   ```

2. 创建TFTP目录

   首先需要建立一个TFTP目录，以供上传和下载。

3. 修改配置文件

   ```sudo vi /etc/default/tftpd-hpa```

   ```shell
   TFTP_USERNAME="root"
   TFTP_DIRECTORY="/home/me/tftpboot"
   TFTP_ADDRESS="0.0.0.0:69"
   TFTP_OPTIONS="-l-c-s"
   说明：
   TFTP_USERNAME：必须改为当前的用户名，或者root；
   TFTP_DIRECTORY：我们设定的TFTP根目录；
   TFTP_OPTIONS：TFTP启动参数。意义如下：
   -l：以standalone/listen模式启动TFTP服务，而不是从inetd启动。
   -c：可创建新文件。默认情况下，TFTP只允许覆盖原有文件，不能创建新文件。
   -s：改变TFTP启动的根目录。加了-s后，客户端使用TFTP时，不再需要输入指定目录，填写文件的完整路径，而是使用配置文件中写好的目录。这样也可以增加安全性。
   ```

4. 重新启动服务

   ```sudo service tftpd-hpa restart```

5. 查看tftp相关进程

   ```ps -aux|grep tftp```




##15.minicom串口通信

安装minicom

```sudo apt-get install minicom```

后面的配置,因为目标机是虚拟机的原因,暂时遇到了问题。。。
先不管了。。







