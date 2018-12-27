# RTP

[TOC]

## 概述

RTP【实时进程】是real-time process的缩写，具有全部保护功能。引入RTP可以更完美的解决内核保护+实时性+确定性之间的矛盾。用户可以根据需要动态的创建／删除RTP实时保护进程或仅将一部分代码运行在 RTP实时保护进程中。RTP实时进程可以随时动态装载运行外部代码。==代码在 RTP进程内部出现的任何错误都被限制在RTP进程内部 ，删除RTP实时进程时自动释放所有资源。==RTP实时进程具有全部的静态确定性 ，提供保护功能的同时提供最高的实时响应确定性+快速性 ，并且可以提供全部的存储错误检测+存储报告功能。

实时进程本身不参与调度，仅仅是对资源进行管理，这些资源包括RTP使用的空间、RTP内创建的对象等。

为了实现RTP和内核空间的独立性，每个RTP都有独立的空间管理数据结构，具体描述参见“空间管理”章节。

为了实现RTP可以在用户态执行核心接口，操作系统提供了系统调用机制，具体描述参见“系统调用”章节。

RTP可执行文件可以链接静态库，也可以链接实现RTP动态库，动态库的具体描述参见“动态库”章节。

## 空间管理

###  空间管理数据结构

操作系统为了支持RTP内的空间和操作系统的空间是相互独立的，操作系统根任务会执行**usrMmuInit()**来初始化核心态和用户态可以使用的空间:

- 使用**adrSpacePgPoolId 、kernelRgnPoolId、kernelVirtPgPoolId、userRgnPoolId、RTPVirtPoolId**来管理核心态和用户态可以使用的及已经使用的虚拟空间；
- 使用**globalRAMPgPoolId**来管理可以使用的及已经使用的物理空间。

![虚拟地址管理](F:\gitHub\zaji\rtp\pic\虚拟地址管理.gif)



#### adrSpacePgPoolld

adrSpacePgPoolId用于在初始化过程中管理4GB所有虚拟空间。在调用adrSpaceLibInit()空间初始化过程中，管理整个4GB的虚拟空间。由于RTP在拷贝核心的页表映射时，最后一级页表没有拷贝，所以粒度为最后一级页表能管理的空间大小，也就是块大小，如SW的最后一级页表能管理的空间是8MB，所以块大小为8MB。在初始化结束后，此变量管理的所有空间都处于分配状态（PAGES_ALLOCATED），所以没有用了，需要删除。

#### kernelRgnPoolld

kernelRgnPoolId用于管理内核空间。在调用adrSpaceLibInit()空间初始化过程中，以sysPhysMemDesc中配置的虚拟地址和以块粒度大小从adrSpacePgPoolId分配对应的虚拟空间，并添加到kernelRgnPoolId。在初始化结束后，此变量管理的sysPhysMemDesc中描述所有空间，以页粒度大小，都处于分配状态PAGES_ALLOCATED。