---
title: 01. 整数运算基础
tags:
  - zk
  - basic
  - integer
---

# WTF zk教程第1讲：整数运算基础

作为零基础的零知识证明教程，我们将从最基础的整数运算开始学习。相信大部分人在中学时已经学过，会非常轻松。我们还将用python复现整数运算，新手也可以很快上手。

对于没使用过python的朋友，建议安装[Anaconda](https://www.anaconda.com/download)来安装并管理python环境。

## 1. 基本定义

整数是没有小数部分的数，可以是正数、负数或零。我们用 $\mathbb{Z}$ 表示所有整数的集合。

$$
\mathbb{Z} = \lbrace \ldots, -3, -2, -1, 0, 1, 2, 3, \ldots \rbrace
$$

对于整数 $a \in \mathbb{Z}$，那么我们用 $\lvert a \rvert$ 表示 $a$ 的绝对值，也就是 $a$ 的非负值，不考虑其符号。

$$
\lvert 69 \rvert = 69
$$

$$
\lvert -69 \rvert = 69
$$


我们经常会用到自然数 $\mathbb{N}$，它是整数的子集，包含所有正整数。

$$
\mathbb{N} = \lbrace 1, 2, 3, \ldots \rbrace
$$

另外，我们有时会用到非负整数，我们用 $\mathbb{N_0}$ 表示：

$$
\mathbb{N_0} = \lbrace 0, 1, 2, 3, \ldots \rbrace
$$

> 注：在有些教材中会将0包含在自然数中，关于0是否包含在自然数中目前仍有[争议](https://zh.wikipedia.org/wiki/%E8%87%AA%E7%84%B6%E6%95%B0)。

## 2. 整数运算

整数运算包括加法、减法、乘法和除法。让我们回顾一下这些基本运算的规则：

- **加法（ $+$ ）：** 对于整数 $a$ 和 $b$，它们的和 $a + b$ 是将它们相加得到的结果。

    ```python
    a, b = 7, 5
    sum_result = a + b
    print(f'加法示例: {sum_result}')
    # 加法示例: 12
    ```

- **减法（ $-$ ）：** 对于整数 $a$ 和 $b$，它们的差 $a - b$ 是将 $b$ 从 $a$ 中减去得到的结果。

    ```python
    diff_result = a - b
    print(f'减法示例: {diff_result}')
    # 减法示例: 2
    ```

- **乘法（ $\times$ ）：** 对于整数 $a$ 和 $b$，它们的积 $a \times b$ 是将它们相乘得到的结果。

    ```python
    product_result = a * b
    print(f'乘法示例: {product_result}')
    # 乘法示例: 35
    ```


## 3. 整数性质

整数有一些重要的性质：

- **封闭性：** 整数加法和乘法在整数集合内是封闭的，即对任意两个整数的加法或乘法仍得到一个整数。

- **交换性：** 整数加法和乘法是交换的，即 $a + b = b + a$ 和 $a \times b = b \times a$ 对于任意整数 $a$ 和 $b$ 成立。

- **结合性：** 整数加法和乘法是结合的，即 $(a + b) + c = a + (b + c)$ 和 $(a \times b) \times c = a \times (b \times c)$ 对于任意整数 $a$, $b$ 和 $c$ 成立。

## 4. 欧几里得除法（Euclidean Division）

我们平常使用的除法是实数除法，两个整数相除的结果不一定是整数，比如 $7 \div 5=1.4$ 不是整数。因此，我们引入整数除法，也叫欧几里得除法（Euclidean Division）。它的结果由两部分组成：商（quotient）和余数（remainder）。欧几里得除法的定义：

对于整数 $a$ 和 $b$（其中 $b \neq 0$），存在唯一的整数对 $(q, r)$，使得 $a = bq + r$，其中 $q$ 是商, $r$ 是余数，且 $0 \leq r \lt |b|$。

如果 $a$ 除以 $b$ 的余数为零，则我们称 $a$ 可以被 $b$ 整除（ $b$ 整除 $a$），记为 $b \mid a$，我们可以称 $b$ 为 $a$ 的因数；若余数不为零，则记为 $b \nmid a$。

我们可以利用python实现欧几里得除法，实现的时候要注意处理当 $a$ 或 $b$ 为负数的情况：python中的`divmod`函数允许余数为负，而欧几里得除法要求余数 $0 \leq r \lt |b|$。相反，python 自带的模运算（求余数） `%` 是允许出现负数的。这里有必要去了解一下编程语言内部对模运算的实现公式： $a\%b=a-(a//b) * b$ 。(这里的 `//` 就是 python 内部对欧几里得除法的实现，保证余数为正且小于除数)。

```python
def euclidean_division(a, b):
    quotient, remainder = divmod(a, b)
    if remainder < 0:
        # 调整余数确保非负
        remainder += abs(b)
        # 调整商使等式仍然成立
        quotient += 1
    return quotient, remainder

quotient, remainder = euclidean_division(a, b)
print(f'除法示例: 商为 {quotient}, 余数为 {remainder}')
# 除法示例: 商为 1, 余数为 2
```

## 5. 总结

这一讲，我们介绍了整数基础，包括其定义及其基础运算（加、减、乘、欧几里得除法），并使用python实现了它们。相信大家中学都学过这些概念，觉得很简单，让我们继续WTF zk之旅！
