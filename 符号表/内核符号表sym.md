# 内核符号表sym

[TOC]

## 前言

在内核开发中，有时候我们必须检查某些内核状态，或者我们想冲用某些内核功能，我们需要得到（read，write，exe）内核符号。对于内核，这里讲的是VxWorks，但应该大同小异吧？

本文是因为要查看所有全局变量，而做的折腾，共勉之。

## 什么是内核符号

在编程语言中，符号指的是一个变量或者函数。更一般地说，符号是一个代表着内存中指定空间的名称，这个空间存储着数据（可读或者可写的变量）或者指令（可以执行的函数）。为了让不同的内核功能单元能够更好地协同工作，linux内核中有着数以千计的内核符号。一个全局变量在一个函数之外定义。一个全局函数声明的时候不能带有inline和static。

## 构思方案

我的入口函数应该只有一个：symTblCommand()

通过这个函数去找一个表，找到表中对应的功能函数。

调用该功能函数，执行相关功能。具体功能如下：

- 获取所有模块信息
- 获取所有rtpId
- 获取指定模块的全局变量
- 获取指定rtpId的全局变量

**如何通信？**

之前想过用shell。但是这样很不爽耶。还是自己写一个socket吧！服务器就是我这边，一直在等待获取信息，然后执行相关功能，并返回信息。

## 任务完成度

- [x] 获取所有模块信息
- [x] 获取所有rtpId
- [x] 获取指定模块的全局变量
- [x] 获取指定rtpId的全局变量
- [x] 建立一个表
- [x] 构建一个入口函数
- [x] 标准格式化功能函数
- [ ] 通信


## 完成过程

### 第一道难关symEach

```c
symEach(sysSymTbl, (FUNCPTR)mdlGetModuleSymId, (int)&matchInfo);
```

说实话，在写这个的时候，我还是懵的。所以先看看注释吧！注释说该接口调用函数来检查符号表中的每一个入口。

被symEach调用的函数需要遵循以下结构：

```c
     BOOL routine
         (
         char *	    name,	/@ symbol/entry name           @/
         int		val,    /@ symbol/entry value          @/
         SYM_TYPE	type,   /@ symbol/entry type           @/
         int		arg,    /@ arbitrary user-supplied arg @/
         UINT16     group   /@ symbol/entry group number   @/
         )
```

内核符号表

内核模块dkm符号表

rtp符号表