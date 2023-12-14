---
title: 09. 欧拉定理
tags:
  - zk
  - basic
  - euler's thereom
  - euler's totient function 
---

# WTF zk教程第9讲：欧拉定理

给定一个整数$n$，小于等于 $n$ 的正整数中有多少和 $n$ 互质的数呢？这一讲，我们将研究这个问题，知识点包括单元集，欧拉函数，和欧拉定理。

## 1. 单元集

如果 $x \in \mathbb{Z}_n$ 是可逆的（即存在乘法逆元），那么我们称 $x$ 为  $\mathbb{Z}_n$ 的单元。$\mathbb{Z}_n$ 所有单元的组成的集合被称为单元集，记为 $\mathbb{Z}^*_n$。

通过之前的学习，我们知道 $x \in \mathbb{Z}_n$ 可逆的充要条件是 $x$ 与 $n$ 互质。因此，$\mathbb{Z}^*_n$ 中的元素就是 $[1, ..., n-1]$ 中与 $n$ 互质的正整数。

举个几个例子：

$\mathbb{Z}^*_2 = \set{1}$

$\mathbb{Z}^*_3 = \set{1,2}$

$\mathbb{Z}^*_5 = \set{1, 2, 3, 4}$

$\mathbb{Z}^*_8 = \set{1, 3, 5, 7}$

$\mathbb{Z}^*_{15} = \set{1, 2, 4, 7, 8, 11, 13, 14}$

## 2. 欧拉函数

欧拉函数为 $\phi(n) = \left|\mathbb{Z}^*_n\right|$，为单元集集 $\mathbb{Z}^*_n$ 中元素的个数。也就是 $[1, ..., n-1]$ 中与 $n$ 互质的整数的个数。另外，我们特别定义 $\phi(1) = 1$。

举个几个例子：

$\phi(2) = 1$

$\phi(3) = 2$

$\phi(5) = 4$

$\phi(8) = 4$

$\phi(15) = 8$

### 2.1 欧拉函数的性质

欧拉函数有一些神奇的性质，让我们很容易计算 $\mathbb{Z}^*_n$ 中元素的个数。

1. 对于质数 $p$， $\phi(p) = p-1$

    <details><summary>点我展开证明👀</summary>
    由于 $p$ 为质数，所以任意 $x \in \mathbb{Z}_n$ 都与
    </details>



## 3. 欧拉定理

