## vx下的ctdt.c文件，你知道多少？

> 学习是无法停止的，世界有太多美好和迷人的秘密。

[TOC]

### 遇到问题

dkm.out文件总是在下载运行时，进行二次链接时，出现未定义引用的符号。最终我们定位到这个符号是ctdt.c文件里面的。我记得之前有一次出现问题也是因为ctdt.c文件。所以，此次我想好好看看它。

### 初步认知

我现在对ctdt.c文件的认知是非常浅显的，大概知道的就是：

1. ctdt.c文件一般是和c++相关

2. 我看见它里面就是_ctors，_dtors，我猜可能是和构造函数和析构函数相关的东西

3. ctdt.c文件的生成：

   ```cmake
   $(LD) -r $(LD_ENDIAN) $(LIBS_PATH) -L$(LIB_PATH) $(PREFLAGS) $(CRT0) $(CRTBEGIN) --start-group $< $(LIBS) $(USER_OBJS) --end-group $(CRTEND) -o tmp.o

   $(NM) -g tmp.o @prjObjs.lst | $(HOSTPUB_PATH)/wtxtcl $(HOSTPUB_PATH)/munch.tcl -c $(CONFIG_ARGUMENT) -vars $(STAND_NEEDS_PATH)/build_vars_list > $(CONFIG_PATH)/make/ctdt.c
   ```

4. symTbl.c文件的生成：

   ```
   $(LD) -r $(LD_ENDIAN) $(LIBS_PATH) -L$(LIB_PATH) $(PREFLAGS) $(CRT0) $(CRTBEGIN) --start-group $< $(LIBS) $(USER_OBJS) --end-group $(CRTEND) -o tmp.o

   $(HOSTPUB_PATH)/wtxtcl $(TOOLS_CHAIN_PATH)/$(TOOLS_BIN_PATH)/makeSymTbl.tcl $(CONFIG_ARGUMENT)32 $(CONFIG_PATH)/make/symTbl.c tmp.o
   ```

5. 生成elf文件：

   ```
   $(LD) $(LD_ENDIAN) $(LIBS_PATH) -L$(LIB_PATH) $(FLAGS) $(CRT0) $(CRTBEGIN)  $(START_ADDRESS) --start-group $< $(LIBS) $(USER_OBJS) $(SYMTBL) $(CONFIG_PATH)/make/ctdt.o --end-group $(CRTEND) -o $@
   ```

6. 生成map.txt文件：

   通过ld参数-M map.txt获得。

   一个链接提供的关于连接的信息有如下一些:

   * 目标文件和符号被映射到内存的哪些地方
   * 普通符号如何被分配空间
   * 所有被连接进来的档案文件,还有导致档案文件被包含进来的那个符号

   ```
   G:/overallVar/workspace/kk_qt/default/lib\libbsp.a(sysLib.o)
                 G:/overallVar/workspace/kk_qt/default/make/src/sysAlib.o (sysProcessor)

   netBufLock          0x4               G:/overallVar/deltaos6.0/target/lib/gnu4.1.2/x86/pentium4/little\libvxmux.a(netBufLib.o)

    .text          0x010099e0      0x230 G:/overallVar/deltaos6.0/target/lib/gnu4.1.2/x86/pentium4/little\libdeltacore.a(coreARes.o)
                   0x01009b20                deltaDrGet
   ```

   ​

从这三个文件的对比发现了什么？

原来elf里面所有的目标文件都会大杂烩到tmp.o里面，然后供ctdt.c和symTbl.c享用啊！

那么问题来了，这两个c文件都用到了所有的目标文件，到底想干嘛！

### symTbl.c

先说说symTbl.c吧。

这个简单，目的就是获取所有的symbol，包括函数和全局变量。但它的生成方式不是很懂：

```
wtxtcl makeSymTbl.tcl pentium4 symTbl.c tmp.o
```

ld -r参数：

```
`-r'`--relocateable'
产生可重定位的输出，比如，产生一个输出文件,它可再次作为ld 的输入。这经常被叫做"部分连接"。
作为一个副作用，在支持标准Unix 魔数的环境中,这个选项会把输出文件的魔数设置为'OMAGIC'。如果这个
选项没有被指定，一个绝对文件就会被产生。
当连接C++程序时，这个选项就不会解析构造函数的引用；要解析，必须使用'-Ur'
如果输入文件跟输出文件的格式不同,只有在输入文件不含有重定位信息的时候部分连接才被支持.
输出格式不同的时候会有更多的限制.比如,有些'a.out'的格式在输入文件是其他格式的时候完全不支持部分
连接。
这个选项跟'-i'等效.
```

### ctdt.c

先看生成方式：

```
nm -g tmp.o @prjObjs.lst | wtxtcl munch.tcl -c pentium4 > ctdt.c
```

nm用于列出目标文件、库或是可执行文件中的代码符号及代码符号所对应的程序开始地址。

```
tmp.o:
00307188 D Acc
0030716c D AccessNULL
0014f22f T AllocateGCPrivate
0014f228 T AllocateGCPrivateIndex
0014f221 T AllocatePixmapPrivate
0014f21a T AllocatePixmapPrivateIndex
0014f3c4 T AllocateScreenPrivateIndex
000573a3 T BIOSTimeGet
000009be T BSP_UartInit
00000d35 T BSP_UartInterruptRead
00000d15 T BSP_UartInterruptWrite
```

@prjObjs.lst:

```
./src/linkSyms.o
./src/prjConfig.o
./src/ugldemo.o
./src/usr_main.o
```

问题是：wtxtcl munch.tcl，它们的作用是什么？资料又少得可怜。

### 结语

> VxWorks真的好烦！

