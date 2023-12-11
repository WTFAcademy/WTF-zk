---
title: 05. 模运算基础
tags:
  - zk
  - basic
  - modular arithmetic
  - congruence
---

# WTF zk教程第5讲：模运算基础

这一讲，我们将探讨模运算（Modular Arithmetic），我们在密码学领域会经常用到。

## 1. 取模运算

取模运算（modulo）是一种整数运算，它通过对一个整数进行欧几里得除法获得余数，将结果限定在一个固定的范围内。

我们通常使用符号 $\text{mod}$ 来表示取模/取余，例如 $a \mod n$ 表示整数 $a$ 对 $n$ 进行取模运算，也就是 $a$ 除以 $n$ 的余数。这里 $n$ 被称为模数（modulus）。

先举几个简单的例子：

$17 \mod 5 = 2$

$25 \mod 7 = 4$

$69 \mod 23 = 0$

我们可以用python实现取模运算：

```python
def mod(a, b):
    remainder = a % b
    if remainder < 0:
        # 调整余数确保非负
        remainder += abs(b)
    return remainder

a = 17
b = 5
remainder = mod(a, b)
print(f'{a} mod {b} = {remainder}')
# 17 mod 5 = 2

a = 25
b = 7
remainder = mod(a, b)
print(f'{a} mod {b} = {remainder}')
# 25 mod 7 = 4

a = 69
b = 23
remainder = mod(a, b)
print(f'{a} mod {b} = {remainder}')
# 69 mod 23 = 0
```

我们使用的24小时计时法也是取模运算的应用。比如当前是12点，20小时过后是不是32点，而是 $32 \mod 24 = 8$ 点。大家可以算一下，再过69小时是几点呢？

![](./img/5-1.png)

## 2. 同余

同余是一种关系，在密码学中有广泛应用。在给定模数 $n$ 的情况下，如果两个整数 $a$ 和 $b$ 取模后的结果相等，我们就称它们在模 $n$ 下是同余的。记为：

$$
a \equiv b \pmod{n}
$$

比如在模数 $3$ 下，4 和 7 的余数均为 1，因此它们在模 3 下时同余的，写为 $4 \equiv 7 \pmod{3}$。但是在另一个模数 $5$ 下，它们就不同余了，因此确认同余关系时必须给出模数。

### 2.1 同余的性质

1. 反身性：在任何模 n 下，整数 $a$ 与自己本身同余。可以写为 $a \equiv a \pmod{n}$。

2. 对称性：如果在模 n 下 $a$ 与 $b$ 同余，那么 $b$ 与 $a$ 也同余。可以写文：如果 $a \equiv b \pmod{n}$，那么 $b \equiv a \pmod{n}$ 成立。举个例子, $4 \equiv 7 \pmod{3}$，同时 $7 \equiv 4 \pmod{3}$, 它们除以3的余数都是1。

3. 传递性：如果 $a$ 与 $b$ 同余且 $b$ 与 $c$ 同余，那么 $a$ 与 $c$ 也同余。可以写为：如果 $a \equiv b \pmod{n}$ 且 $b \equiv c \pmod{n}$，那么有 $a \equiv c \pmod{n}$。举个例子, $4 \equiv 7 \pmod{3}$ 且 $7 \equiv 10 \pmod{3}$, 那么有 $4 \equiv 10 \pmod{3}$。

这三个性质都很好证明，大家可以试着写一下。提示：用欧几里得除法将 $a, b$ 展开，如果它们同余，则有：

$$
a=pn+r
$$

$$
b=qn+r
$$

### 2.2 剩余类

我们用符号 $Z_n$ 表示模 $n$ 的剩余类，它是 $0$ 到 $n-1$ 所有整数的集合：

$$
Z_n = \{0, 1, 2, \ldots, n-1\}
$$

任何整数 $a$ 对 $n$ 取模的结果都会落在 $Z_n$ 中。也就是说，对于任意整数 $a$，都存在 $b \in Z_n$，使得 $a \equiv b \pmod{n}$。利用同余关系，我们可以把无限个整数的模运算，映射到 n 个整数的 $Z_n$ 的运算中。

以24小时计时法为例，任何时间都会落在 $Z_{24}$ 中，比如 $32 \mod 24 = 8$，$56 \mod 24 = 8$。

> 注: 还需要补充更多介绍剩余类性质的内容

## 3. 基础模运算

1. 平移：对于任何整数 $k$，如果 $a \equiv b \pmod{n}$，那么 $a+k \equiv b+k \pmod{n}$。当 $k < 0$ 时，它的效果就是减法。

    例子：$4 \equiv 7 \pmod{3}$，两边同时加 4，我们得到 $8 \equiv 11 \pmod{3}$，仍然成立。

2. 缩放：对于任何整数 $k$，如果 $a \equiv b \pmod{n}$，那么 $a \cdot k \equiv b \cdot k \pmod{n}$。

    例子：$4 \equiv 7 \pmod{3}$，两边同时乘 4，我们得到 $16 \equiv 28 \pmod{3}$，仍然成立。

3. 加法：如果 $a_1 \equiv a_2 \pmod{n}$ 且 $b_1 \equiv b_2 \pmod{n}$，那么有 $a_1 + b_1 \equiv a_2 + b_2 \pmod{n}$。

    例子：$4 \equiv 7 \pmod{3}$，且 $2 \equiv 5 \pmod{3}$，我们将两边相加，得到 $6 \equiv 12 \pmod{3}$，仍然成立。

4. 乘法：如果 $a_1 \equiv a_2 \pmod{n}$ 且 $b_1 \equiv b_2 \pmod{n}$，那么有 $a_1 b_1 \equiv a_2  b_2 \pmod{n}$。

    例子：$4 \equiv 7 \pmod{3}$，且 $2 \equiv 5 \pmod{3}$，我们将两边相乘，得到 $8 \equiv 35 \pmod{3}$，仍然成立。

5. 如果整数 $k$ 和 $n$互质，即 $\gcd(k,n) = 1$，且 $k \cdot a \equiv k \cdot b \pmod{n}$ ，那么有 $a \equiv b \pmod{n}$。

    例子：已知 $8 \equiv 14 \pmod{3}$，且 $\gcd(2, 3) = 1$，我们将等式两边同除以 $2$，得到 $4 \equiv 7 \pmod{3}$，仍然成立。

## 4. 总结

这一讲，我们介绍了取模运算的定义，同余，和基础模运算。模运算看起来很陌生，但其实它在生活中无处不在，只是你没有发觉而已。你能说出几个模运算在生活中的应用呢？
