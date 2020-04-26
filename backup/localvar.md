---
layout: post
title: �ֲ�����
date: 2020-04-06
Author: xuxeu
categories: 
tags: [�����̸]
comments: true
typora-root-url: ..
---

�����ڽ������ļ�ƪ�����У�
�ҽ�����"���۽�"������һ������C����
Ϊ��ҽҿ� C ���Եİ��ء�

## ����

������һ�죬һ�����ѷ���һ����ֵ� C ����

	int i = 3;
	int ans = (++i)+(++i)+(++i);

`����`����˵���� 18���һ���Ϊ�� 4+5+6=15 �ء�

## ��֤

����Ȼ���Ҿ�������֤һ�½�������������ģ�
��д�����µĲ��Գ���inc.c����

	#include <stdio.h>
	
	int main()
	{
		int i = 3;
		int ans = (++i)+(++i)+(++i);
	
		printf("%d\n",ans);
		return 0;
	}

`����`�� linux �б��롢���У�������£�

	[lqy@localhost temp]$ gcc -o inc inc.c
	[lqy@localhost temp]$ ./inc
	16
	[lqy@localhost temp]$ 

`����`��Ȼ�ֳ�����һ�����˷�����˼�� 16��

## ����

�����ðɣ��Ȳ��� 18 �ˣ�������� 16 ����ô���ģ�

	gcc -S -o inc.s inc.c

`����`�����˻��Դ�ļ� inc.s��
��������ֻ�������е�<b>����</b>���֣�

<pre><code>    .file	"inc.c"
	.section	.rodata
.LC0:
	.string	"%d\n"
	.text
.globl main
	.type	main, @function
main:
	pushl	%ebp
	movl	%esp, %ebp
	andl	$-16, %esp
	subl	$32, %esp<b>
	movl	$3, 28(%esp)
	addl	$1, 28(%esp)
	addl	$1, 28(%esp)
	movl	28(%esp), %eax
	addl	%eax, %eax
	addl	$1, 28(%esp)
	addl	28(%esp), %eax
	movl	%eax, 24(%esp)</b>
	movl	$.LC0, %eax
	movl	24(%esp), %edx
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	printf
	movl	$0, %eax
	leave
	ret
	.size	main, .-main
	.ident	"GCC: (GNU) 4.5.1 20100924 (Red Hat 4.5.1-4)"
	.section	.note.GNU-stack,"",@progbits
</code></pre>

�����������Ҳ��ò�����һ�����ֻ��ĸ�ʽ�ˣ�
���� AT&T ��ʽ�� x86 ��࣬
������ windows �ϼ�����һ���� Intel ��ʽ�Ļ�࣬
AT&T ����� Intel ��ʽ�Ļ����Щ���죬
�������Ǻܺ����ġ�

���������ǼĴ�����������ʽ��ͬ��
�� Intel ��ʽ�ļĴ���ǰ���˸� %��eax ����� %eax  
Ȼ�����˫Ԫָ��Ĳ������Ĵ��ݷ����� Intel �ĸպ��෴��
mov eax��ebx���൱�� eax=ebx;�� ����� movl %ebx��%eax
�������Ҵ�ֵ��  
��������һЩ��𣬲����������׿����׵ġ�

���������岿�ּӵ�ע�Ͱɣ�

	movl	$3, 28(%esp)	# i = 3;
	addl	$1, 28(%esp)	# ++i; // 4
	addl	$1, 28(%esp)	# ++i; // 5
	movl	28(%esp), %eax	# eax = i;
	addl	%eax, %eax		# eax = eax + eax; // 10
	addl	$1, 28(%esp)	# ++i; // 6
	addl	28(%esp), %eax	# eax = eax + i; // 16
	movl	%eax, 24(%esp)	# ans = eax;

`����`Ȼ�����Ǿ�֪���� 16 ����ô�����ˡ�

����Ϊʲô�ҾͿ϶� 28(%esp) ���Ǳ��� i �أ�
��Ϊֻ������д���� 3��û�б���ڴ汻д�� 3��
���Ҵ�֮��������ĸ���ָ��Ҳ����ȷ�������� C 
�����еı��� i���ñ��߰���
����һ���ֲ�����������������յ���ԼĴ���Ѱַ��һ���ڴ棡����
���Ƶģ��ֲ����� ans ����� 24(%esp)��
��������ó����ֲ�������󶼱������� esp Ѱַ���ڴ��
��֮���ƪ�»ῴ��������ۻ����Ǻ���ȷ����

## ����

����ͬ���ĳ����� VC �ϱ������У�
Debug ģʽ�����н���� 16��Release ģʽ�����н���� 18��
���� Visual Studio 2010 �� Debug �� 
Release ģʽ�¶��� 18��

����VC �� VS Ҳ���Կ��������룬
�ڵ��Թ����������ϵ��жϵ�ʱ��
VC ʹ�� Alt + 8 �򿪷���ര�壬
VS �һ� C Դ����༭��ѡ��"ת�������"���򿪷���ര�塣

����Ϊʲô Intel �Լ���� CPU��AT&T ����һ���� Intel 
��ͬ��ʽ�Ļ�������أ�û���ӣ�AT&T Ҳ���Ǻ��ǵģ�
�˼�����������������Ӱ��ȫ���磺Unix��C���ԡ�

## С��

�������������������Ӧ����ȡ���飺
<b>��ʵʩ�������ݼ��������ı�����Ӧ���ڱ��ʽ�ж�γ���</b>��
�������Ͳ������ǿ����ˣ����Ǳ����������ɷ��ӣ�

����C ��׼�涨������[���е�](http://blog.csdn.net/huiguixian/article/details/6438613)֮�䣬
����ִ�е�˳�����������ġ�
���������˱������Ż��Ŀռ䡣[[1]](#tip1)

���������õ���� 15 �Ļ���������Ըĳ�������

	#include <stdio.h>
	
	int main()
	{
	    int i = 3;
	    int ans = (i+2)*3;
		i += 3;
	
	    printf("%d\n",ans);
	    return 0;
	}

`����`����������� windows �»����� linux �£�
������ Release ���� Debug�����һ���� 15��

�������� ���� C ���ԣ��ų�����ƪ���Ѿ��ܹ�Ϊ���ǽ���ˣ�
��պ���Ǳ������Ԫ��������ô����

[��Ŀ¼][content]

<a name="tip1"></a>
[1] �� ohyeah ָ����[http://rs.xidian.edu.cn/forum.php?mod=redirect&goto=findpost&ptid=412474&pid=8298351](http://rs.xidian.edu.cn/forum.php?mod=redirect&goto=findpost&ptid=412474&pid=8298351)
