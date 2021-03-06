---
layout: post
title: linux0.01进程时间片的消耗和再生
date: 2020-04-06
Author: xuxeu
categories: 
tags: [编程杂谈]
comments: true
typora-root-url: ..
---

　　这是《朴素linux》系列的第一篇，为什么要从进程开始讲呢？
因为操作系统里边最热门、被解释得最多的就是进程，
而对进程的管理最重要的部分就是对时间片的处理，
<b>这部分的算法会影响到进程切换的速度（
这是操作系统的一个最重要的性能指标）</b>，
同时还体现出<b>操作系统的智能性</b>，
但是《操作系统》里边少有提及。

---

　　首先，所有操作系统都应该有的特性：

1. 每个进程都会被分配若干个时间片，时间片被用完，
这个进程<b>暂时</b>就不能再投入运行
2. 每个进程都会有优先级，优先级高的进程分配较多的时间片
3. 时间片用完后，进程如果还没有终结，应该再分配时间片
（总不能限制一个进程必须多少时间完成吧^_^）

`　　`linux0.01的<b>一个时间片代表10毫秒</b>（0.01秒），
进程的优先级从1~15，<b>优先级就是重新分配
时间片时进程获得的时间片的数量</b>。

　　<b>那么时间片是怎么消耗的呢？</b>

　　这里不得不提我们的大功臣——8253计数器，
没错，它就是微机原理课上讲到的可编程定时/计数控制器！
就是它<b>每10ms触发一次时钟中断，
中断程序中把当前进程的时间片减1</b>，
时间片就是这样被消耗的。

　　说到中断，还有一哥们也是我们熟悉的，那就是8259中断控制器，
这两个芯片就不多说了，否则读者就开始厌烦这篇文章了
O(∩_∩)O~。

---

　　当当前进程的时间片被<b>减到0</b>了之后就会调用schedule
函数切换到一个能运行的剩余时间片最多的进程，
这里需要遍历所有进程，所以是个O(n)级时间复杂度的过程
（n代表进程的个数）。

*注意：一般情况下，当前进程只有在自己所有的时间片都用完之后才
调用schedule，如果是每用完一个时间片就调用一次schedule
，开销就大了。*

　　下面模拟一下进程的调度情况：

1. 假设有3个进程，分别剩余时间片5、4、3，优先级都是15，
这个时候调用了 schedule，
那么进程1将会被选中做为接下来要执行的进程：

	![1](http://fmn.rrimg.com/fmn063/20121022/1950/original_9rlY_112f0000631a1191.jpg)

2. 执行第一个进程50ms，耗光进程1的所有时间片：

	![2](http://fmn.rrimg.com/fmn063/20121022/1950/original_zHfv_346c000051721190.jpg)

3. 这时候时钟中断程序中会调用schedule切换到进程2执行，
可是进程2执行了20ms后由于等待磁盘IO而休眠了：

	![3](http://fmn.rrimg.com/fmn060/20121022/1950/original_eMlh_2ddb000063e4118f.jpg)

4. 休眠的函数中会调用schedule切换到进程3执行，
一直到进程3的时间片也全用完：

	![4](http://fmn.rrimg.com/fmn065/20121022/1950/original_jC84_7acf000062c5118e.jpg)

5. 现在进程1和进程3没有时间片了不能投入运行，
进程2休眠了不能投入运行，
所以schedule函数希望通过再生时间片来解除这种尴尬：

	每个进程新的时间片的计算公式是：

		新的时间片 = 旧的时间片 / 2 + 优先级

	这个式子看起来有点奇怪，旧的时间片不应该都是0吗？
从上面的模拟中可以看出休眠的进程可能还有时间片，
所以休眠的进程就被特别关照了：

	![5](http://fmn.rrimg.com/fmn063/20121022/1950/original_Gfvs_7179000063f0118d.jpg)

	　　休眠的进程被特别关照的原因是这类程序可能是IO频繁的
程序（如文本编辑器），这类程序容易进入休眠状态，
不特别关照的话很难被schedule选中：

	　　假设分配时间片时进程2保持原来的2个时间片不变，
时间片分配完后刚好被唤醒，这时进程1和进程3的时间片数量是15
比它多，那也就是说要等进程1和进程3相继被调度运行之后，
进程2才能被投入运行。这还只有2个抢CPU的进程，
最多等300ms进程2就能运行了，但是如果这样的进程有20个呢？
那就等3s？那打字的那位仁兄岂不要火冒三丈了？

如果上面的过程画在一条时间线上，就是这样的：

![timeline](http://fmn.rrimg.com/fmn063/20121022/1950/original_lAYT_11df0000635e118c.jpg)

---

## 总结

`　　`linux0.01中切换进程(schedule)的开销有：

1. 选出剩余时间片最多的可运行的进程(O(n))，
如果有，切换到它
2. 如果没有可投入运行的进程，重新分配时间片(O(n))，
再执行1

`　　`所以linux0.01的进程切换开销是O(n)复杂度的，
排序有 O(nlog(n)) 变 O(n) 的奇迹，那进程切换的开销能从
O(n) 变 O(1) 吗？

　　欲知后事如何，且听下回分解。

[回目录][content]
