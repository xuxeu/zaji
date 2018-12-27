## GDB的non-stop模式！

[TOC]

### 简介

开源的GDB被广泛使用在Linux、OSX、Unix和各种嵌入式系统（例如手机），这次它又带给我们一个惊喜。

### 多线程调试之痛

调试器（如VS2008和老版GDB）往往只支持all-stop模式，调试多线程程序时，如果某个线程断在一个断点上，你的调试器会让整个程序freeze，直到你continue这个线程，程序中的其他线程才会继续运行。这个限制使得被调试的程序不能够像真实环境中那样运行--当某个线程断在一个断点上，让其他线程并行运行。

GDBv7.0引入的non-stop模式使得这个问题迎刃而解。在这个模式下：

- ==当某个或多个线程断在一个断点上，其他线程仍会并行运行==
- ==你可以选择某个被断的线程，并让它继续运行== 

让我们想象一下，有了这个功能后：

- 当其他线程断在断点上时，程序里的定时器线程可以正常的运行了，从而避免不必要的超时
- 当其他线程断在断点上时，程序里的watchdog线程可以正常的运行了，从而避免嵌入式硬件以为系统崩溃而重启
- 可以控制多个线程运行的顺序，从而重现deadlock场景了。由于GDB可以用python脚本驱动调试，理论上可以对程序在不同的线程运行顺序下进行自动化测试

因此，non-stop模式理所当然成为多线程调试“必杀技”。这2009年下半年之后发布的Linux版本里都带有GDBv7.0之后的版本。很好奇，不知道VS2010里是不是也支持类似的调试模式了。

和现有的任务级调试对比：

现在的任务级调试只能调试单个线程！

可见non-stop模式优势巨大！

### 演示GDB的non-stop模式

让我们用一个C++小程序在Ubuntu Linux 09.10下demo这个必杀技。虽然我的demo使用命令行版gdb，如果你喜欢图形化的调试器，Eclipse2009年5月之后的版本可以轻松的调 用这个功能。

```
// gdb non-stop mode demo
// build instruction: g++ -g -o nonstop nonstop.cpp -lboost_thread
 
#include <iostream>
#include <boost/thread/thread.hpp>

struct op
{
        op(int id): m_id(id) {}

        void operator()()
        {
                std::cout << m_id << " begin" << std::endl;
                std::cout << m_id << " end" << std::endl;
        }

        int m_id;
};

int main(int argc, char ** argv)
{
        boost::thread t1(op(1)), t2(op(2)), t3(op(3));
        t1.join(); 
        t2.join(); 
        t3.join();
        return 0;
}
```











​                                                                                                                                   *transcribe by luosy*