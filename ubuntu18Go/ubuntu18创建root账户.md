# Ubuntu 18.04版本root账户						

Linux系统下文件的权限十分重要，大多数操作都需要一定的权限才可以操作，Ubuntu18.04默认安装是没有设置root账户的，因此想要获得root账户登录可以使用以下步骤：

1.首先获得临时的root权限，因为后面的一些操作需要root权限才可以，打开终端输入以下命令

```
sudo -s
```

之后直接输入当前账户的密码，就可以获得临时的root权限

2.先创建root账户：

```shell
sudo passwd root
```

根据提示输入密码（此时输入的密码是以后登录root账户时的密码）

3.修改配置文件，文件路径/usr/share/lightdm/lightdm.conf.d/50-unity-greeter.conf

可以使用vim修改，也可以用文档编辑器修改，此处我使用文档编辑器修改

```
gedit /usr/share/lightdm/lightdm.conf.d/50-unity-greeter.conf
```

（对普通文件进行编辑一定要先获得root权限）

打开后，在文档末尾输入

```
- greeter-show-manual-login = true
- all-guest = false
```

4.去除gdm登陆用户名检测：

 修改/etc/pam.d/gdm-autologin  文件

```
gedit /etc/pam.d/gdm-autologin
```

删除 或注释掉以下语句

```
auth required pam_succeed_if.so user != root quiet_success
```

修改 /etc/pam.d/gdm-password 文件

```
gedit /etc/pam.d/gdm-password
```

同样删除 或注释掉上面的语句

5.修改/root/.profile文件

```
gedit /root/.profile
```

文档最后一行 mesg n || true 前添加  tty -s && 即 tty -s &&mesg n || true

6.重启系统，终端界面输入 #reboot

重启完成后，登陆界面选择 “未列出”，之后用户名输入 root 进行登录即可。