# openOCD

刚开始接触嵌入式硬件时只知道写程序，觉得调试根本不需要，随着时间的积累和问题复杂度的提升，才发现调试对于一个系统的重要性。生活中很多这样的例子，调试，永远都是事物良性发展过程中必不可少的一个环节，两个人过日子遇到了矛盾，静下来沟通就是调试，总不能一言不合就分手。在设计一个产品或者一个流程时，都要充分的考虑到调试因素，这样系统在运行过程中一旦出现了问题，可以及时的追溯。

OpenOCD就是这样一个工具，配合JTAG调试协议，可以对硬件设备进行指令集级别和寄存器级别的调试。

了解一个新软件最好的方式就是读官方的Manual。当然，不一定非得从Manual开始，可以从一些实例开始，或者基于母语的博客或者论坛，但想掌握得更彻底，还是得找官方的文档，解铃还须系铃人。如果软件的设计思想过于复杂，Manual读一遍是不管用的。往往盘旋式的前进会收到更好的效果，也就是带着问题读Manual，解决了问题；再遇到一些问题时，再读一遍Manual，就这样反复几遍也就逐渐掌握了，所谓的一万小时理论也是基于此。

OpenOCD的优势就是开源，支持N种调试器。充分的理解和掌握整个开发过程中的调试方法，是项目稳定进行的可靠保障，很多未知问题都得通过底层调试才能分析出来。

## 调试ARM

linux下使用gdb调试stm32可以使用两套环境：

1. stlink硬件+openocd软件+arm-none-eabi-gdb
2. jlink硬件+jlink_gdb_server软件+arm-none-eabi-gdb

## 搭建环境

1. 通过网站[http://www.freddiechopin.info/en/download/category/4-openocd](http://www.freddiechopin.info/en/download/category/4-openocd)下载openOCD for windows软件包，现在的版本是0.9.0。如果希望下载源代码，可以访问网站[http://openocd.sourceforge.net/](http://openocd.sourceforge.net/)。
2. 登陆网站[http://zadig.akeo.ie/](http://zadig.akeo.ie/)下载zadig软件，用来安装仿真器的驱动程序，当前版本是2.1.2，说的直白一些openOCD只把Jlink仿真器当作普通的USB设备来使用，不使用Jlink自带的仿真器驱动程序，如果已安装了Jlink仿真器驱动程序，这个过程就是把原先的驱动程序换掉。


3. 插入Jlink仿真器（如果是第一次插入Jlink仿真器，系统会要求安装驱动程序，我们可以点击取消，不必理会)，运行zadig软件。
4. 选择J-Link,然后选择WinUSB驱动程序，点击Reinstall Driver按钮或Replace Driver按钮，这样便完成了驱动程序的替换。
5. 解压缩openOCD软件包，在硬盘上建立openocd文件夹（可写其它的任意名称），拷贝bin和scripts文件夹下面的所有文件到该文件夹。
6. 使用Jlink仿真器连接目标板，并给目标板上电。
7. 在windows运行中输入cmd，启动控制台程序，并切换至步骤7建立的文件夹。
8. 输入命令openocd -f interface/jlink.cfg -f target/k60.cfg，jlink.cfg表示使用jlink仿真器，k60.cfg表示下载k60系列MCU。
9. 出现下列界面表示连接成功。

![openOCDqidong](F:\gitHub\zaji\pic\openOCDqidong.png)

## openOCD思考

OpenOCD是一款功能强大的开源调试软件，支持多种调试器，例如Jlink、STlink、FT2232、并口等；支持多种嵌入式处理器，例如ARM7,ARM9, ARM10, ARM11和Cortex等核心的芯片；另外还提供一个GDB Server接口。

刚一开始可能还摸不清OpenOCD的运作模式，毕竟它不是一款图形化软件，而是基于command line 的交互方式。而且OpenOCD运行后直接就是一个Daemon，我第一次运行时还真有点懵。这种软件还是得靠动手操作实例来掌握。

使用OpenOCD开发项目，我们需要做的不止是将调试器连接到开发板，我们还需要配置OpenOCD让它知道我们的调试器和开发板的型号，可以使用OpenOCD连接GDB，然后使用例如Eclipse或者其它图形化的工具。

## TAP

Test Access Ports (TAPs) are the core of JTAG. TAPs serve many roles, including:

测试访问端口TAPs是JTAG的核心，TAPs服务许多角色，包括：

1. Debug TargetA CPU TAP can be used as a GDB debug target.
2. 调试目标端CPU TAP可以作为GDB调试的目标端程序，即GDBServer。
3. ​



通俗点讲，TAP就是一个调试链，通常一个芯片就是一个TAP，但是一个芯片往往包含多个IP核，比如，ARM+DSP或者ARM+FPGA或者ARM+ASIC，所以在这个chain里面通常会包含多个可调试对象，比如使用scan_chain命令显示的信息，可以看到omap5912下面包括3个可调试成员。

OpenOCD启动时将配置文件作为参数.

openocd.exe -f jlink.cfg -f openocd-ralink.cfg 命令就是将jlink.cfg和openocd-ralink.cfg两个配置文件作为配置参数。

## 怎么学openOCD

其实也很简单。首先弄明白了原理，知道openOCD是搞毛线用的。

然后，知道怎么搭建环境。比如需要什么硬件J-Link，什么软件openOCD，zadig等。

环境搭建好以后，知道如何输入命令来和目标机连接。

知道openOCD的常用命令，知道如何分析和更改配置文件。

知道如何配合gdb进行调试。

如果以上都搞定，那么我就认为，openOCD已经尽在掌握中，剩下的就是不断尝试和完善自己的openOCD的知识体系结构了。

## 对比JLink驱动

通过上面的学习，我们可以看到openOCD只把Jlink仿真器当作普通的USB设备来使用，不使用Jlink自带的仿真器驱动程序。也即是说：openOCD替代了jlink驱动提供的功能。

我们知道JLink驱动提供给了我们使用命令下载bin文件，运行bin文件，以及调试bin文件等功能。那么openOCD呢？说实话，我还没用过呢......O(^_^)O哈哈~





















































