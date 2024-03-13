---
title: 28. 二次剩余
tags:
  - zk
  - abstract algebra
  - field
  - number theory
  - quadratic residue
---

# WTF zk 教程第 28 讲：二次剩余


在这一讲中，我们将介绍有限域 $F_p$ 下的二次剩余，涉及一个数的平方和平方根，在密码学和零知识证明中会经常用到。

## 1. 二次剩余

**二次剩余** 是与模运算相关的一个概念。给定一个整数 $a$ 和正整数 $n$，如果存在整数 $x$ 使得 $x^2 \equiv a \pmod{n}$，则称 $a$ 是模 $n$ 的二次剩余。如果不存在这样的 $x$，则称 $a$ 是模 $n$ 的二次非剩余。

在本教程，我们仅介绍当模 $n$ 为奇质数 $p$ 的情况。

下面举个例子，以 $n = 7$ 为例，来看一下整数模7乘法群 $Z_7^*$ 中的二次剩余（不考虑0）：

$1^2 \equiv 1 \pmod{7}$

$2^2 \equiv 4 \pmod{7}$

$3^2 \equiv 2 \pmod{7}$

$4^2 \equiv 2 \pmod{7}$

$5^2 \equiv 4 \pmod{7}$

$6^2 \equiv 1 \pmod{7}$

因此，群 $Z_7^*$ 中一共有 6 个元素，二次剩余为 $\set{1, 2, 4}$，二次非剩余为 $\set{3, 5, 6}$，正好各占一半。

**性质1.** 模 $p$ 下的二次剩余共有 $\frac{p-1}{2}$ 个。

<details><summary>点我展开证明👀</summary>

对于奇素数 $p$，模 $p$ 的剩余类是 $1, 2, \ldots, p-1$，共有 $p-1$ 个元素。考虑元素 $x$ 和二次剩余 $a$，有 $x^2 \equiv a \pmod{p}$ 和 $(-x)^2 \equiv a \pmod{p}$。也就是若 $a$ 为 $x$ 的二次剩余，那么 $a$ 也是 $-x$ 的二次剩余，它们互为相反数。因此，在 $Z_p$ 剩余系中，每个二次剩余都对应两个元素，共有 $\frac{p-1}{2}$ 个二次剩余。证毕

</details>

## 2. 勒让德符号

勒让德符号 $\left(\frac{a}{p}\right)$ 是描述二次剩余的一种符号表示法。它定义如下：

$$
\left(\frac{a}{p}\right) = \begin{cases} 
1 & \text{如果 } a \text{ 是模 } p \text{ 的二次剩余} \\
-1 & \text{如果 } a \text{ 是模 } p \text{ 的二次非剩余} \\
0 & \text{如果 } a \equiv 0 \pmod{p}
\end{cases}
$$

勒让德符号给二次剩余问题提供了一种便捷的符号表示。举个例子，对于 $Z_7$，有 $(\frac{0}{7}) = 0$， $(\frac{1}{7}) = 1$， $(\frac{2}{7}) = 1$， $(\frac{3}{7}) = -1$， $(\frac{4}{7}) = 1$， $(\frac{5}{7}) = -1$， $(\frac{6}{7}) = 1$。

## 3. 欧拉准则

欧拉准则是一个关于模 $p$ 二次剩余的重要定理。如果 $p$ 是一个奇素数， $a$ 是与 $p$ 互质的整数，则有

$$
a^{\frac{p-1}{2}} \equiv \left(\frac{a}{p}\right) \pmod{p}
$$

这个准则对于判断二次剩余与否非常有用。

<details><summary>点我展开证明👀</summary>

若 $a = 0 \pmod{p}$，那么 $a^{\frac{p-1}{2}}  = 0^{\frac{p-1}{2}}  = 0$。

下面讨论 $a$ 和 $p$ 互质的情况。

根据费马小定理，有 $a^{p-1} -1 \equiv 0 \pmod{p}$，又因为 $p$ 是奇质数，我们可以分解为 $(a^\frac{p-1}{2} -1)(a^\frac{p-1}{2} + 1) = 0 \pmod{p}$。也就意味着 $a^\frac{p-1}{2} = \pm 1$。

若 $a$ 是二次剩余，那么存在 $b \in Z_p^*$ 使得 $a = b^2$。等式两边同时幂 $\frac{p-1}{2}$，有 $a^\frac{p-1}{2} \equiv b^{p-1} \pmod{p}$。根据费马小定理，有 $b^{p-1} \equiv 1 \pmod{p}$，因此有 $a^\frac{p-1}{2} \equiv 1 \pmod{p}$。

$Z_p^*$ 的共 $p-1$ 个元素对应着 $\frac{p-1}{2}$ 个二次剩余 $a$，根据拉格朗日定理，多项式 $a^\frac{p-1}{2} -1 =0$ 最多有 $\frac{p-1}{2}$ 个根，恰好被 $\frac{p-1}{2}$ 个二次剩余 $a$ 占满。因此，剩下的 $\frac{p-1}{2}$ 个二次非剩余必须满足 $a^\frac{p-1}{2} + 1 =0$，也就是 $a^\frac{p-1}{2} = -1 \pmod{p}$

</details>

以 $Z_7^*$ 为例， $0^3 = 0$， $1^3 = 1$， $2^3 = 1$， $3^3 = -1$， $4^3 = 1$， $5^3 = -1$， $6^3 = -1$，二次剩余为 $\set{1,2,4}$，与之前计算的一致。

## 4. 代码示例

我们可以在python中使用欧拉准则判断一个元素是否为二次剩余。

```python
def legendre_symbol(a, p):
    """计算勒让德符号 (a/p)"""
    legendre = pow(a, (p - 1) // 2, p)
    return -1 if legendre == p - 1 else legendre

def is_quadratic_residue(a, p):
    """检查 a 是否是模 p 意义下的二次剩余"""
    legendre = legendre_symbol(a, p)
    return legendre == 1

# 示例
p = 7
for a in range(p):
    if is_quadratic_residue(a, p):
        print(f"{a} 是模 {p} 下的二次剩余")
    else:
        print(f"{a} 不是模 {p} 下的二次剩余")

## 输出示例        
# 0 不是模 7 下的二次剩余
# 1 是模 7 下的二次剩余
# 2 是模 7 下的二次剩余
# 3 不是模 7 下的二次剩余
# 4 是模 7 下的二次剩余
# 5 不是模 7 下的二次剩余
# 6 不是模 7 下的二次剩余
```

## 5. 模平方根难题

当 $n$ 为大合数时，求模平方根的难度相当于大数的因式分解，非常困难。这一特点经常被用于构造加密算法和零知识证明算法，比如[Rabin加密算法](https://en.wikipedia.org/wiki/Rabin_cryptosystem)和[Goldwasser–Micali加密算法](https://en.wikipedia.org/wiki/Goldwasser%E2%80%93Micali_cryptosystem)。

## 6. 总结

这一讲，我们学习了二次剩余，勒让德符号，和欧拉准则。在密码学领域，二次剩余经常被用来构建加密算法。
