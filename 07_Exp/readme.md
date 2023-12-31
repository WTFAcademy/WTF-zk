---
title: 07. 费马小定理
tags:
  - zk
  - basic
  - chinese remainder theorem
---

# WTF zk教程第7讲：费马小定理

之前我们介绍了模运算中的加减乘除，这一讲，我们介绍模幂和小费马定理。

## 1. 模幂

模幂指对模进行的幂运算，在密码学中很常用：

$$
b = a^c \mod{n}
$$

其中 $0 \le b < n$。

举个例子，给定 $(a, c, n) = (7, 5, 13)$，我们可以计算得到 $7^5=16807$，除以 $13$ 余 $11$，因此 $b = 11$。

当然，模幂也可以写为同余的形式：

$$
b \equiv a^c \pmod{n}
$$

### 1.1 优化算法

$a^c$ 是个很大的数，很占计算机的内存，而模运算的结果 $0 \le b < n$，因此，我们可以运用模运算的特性节省计算时的内存。

根据模运算，有：

$$
x \cdot y \mod{n} = (x \mod{n})  \cdot (y \mod{n}) \mod{n}
$$

如果 $x$ 和 $y$ 很大的时候，我们可以先进行取模运算，再进行乘法运算，节省内存。而幂运算可以展开为连乘：

$$
a^c \mod{n} = a \cdot a \cdot a \cdot ... \mod{n} 
$$

因此，我们可以每一步乘 $a$ 再取模，将乘积转化为一个较小的数，再继续乘 $a$ 取模，直到运算结束。

$$
a^c \mod{n} = (((a \cdot a \mod{n}) \cdot a \mod{n}) \cdot ... )\mod{n} 
$$

以 $(a, c, n) = (7, 5, 13)$ 为例：

1. 第一步，计算 $7 * 7 \mod{13} =10$。

2. 第二步，计算 $10 * 7 \mod{13} = 5$。

3. 第三步，计算 $5 * 7 \mod{13} = 9$。

4. 第四步，计算 $9 * 7 \mod{13} = 11$，结束。因此 $b = 11$。

## 1.2 代码实现

我们用python实现模幂的优化算法：

```python
def mod_pow(base, exponent, modulus):
    result = 1

    # 将指数展开为二进制形式，从高位到低位逐位处理
    while exponent > 0:
        # 如果当前位是1，则乘上当前的 base，然后取模
        if exponent % 2 == 1:
            result = (result * base) % modulus
        # 将 base 平方，然后取模
        base = (base * base) % modulus
        # 右移一位，相当于除以2
        exponent //= 2

    return result

# 示例：计算 (7^5) % 13
a = 7
c = 5
n = 13
result = mod_pow(a, c, n)
print(f"{a}^{c} mod {n} = {result}")
# 7^5 mod 13 = 11
```

## 2. 费马小定理

费马小定理是数论中的一个重要定理，为解决模幂问题提供了有力的工具。

### 2.1 定义

费马小定理指出，如果 $p$ 是一个质数，则对于任意整数 $a$ 是，有

$$
a^{p} \equiv a \pmod{p}
$$

也就是说 $a^p -a$ 可以被 $p$ 整除。举个例子， $a = 3$ ， $p = 5$ ，有 $3^5 - 3 = 240 = 48 \cdot 5$。

费马小定理还可以写成另一个形式。当 $a$ 与 $p$ 互质时，我们可以在等式左右两端同除以 $a$ ，得到下面这个形式：

$$
a^{p-1} \equiv 1 \pmod{p}
$$

也就是说 $a^{p-1} -1$ 可以被 $p$ 整除。举个例子， $a = 3$ ， $p = 5$ ，有 $3^4 -1 = 80 = 16 \cdot 5$。

### 2.2 证明

首先我们要证明对于质数 $p$，以下等式成立：

$$
(x+y)^p \equiv x^p +y^p \pmod{p}
$$

我们对原式进行二项式展开，除了 $x^p$ 和 $y^p$，其余项都含有 $p$，可以被 $p$ 整除消去：

$$
(x+y)^p \equiv  x^p +y^p + p(...) \equiv x^p +y^p \pmod{p}
$$

通过归纳法，我们可以得到：

$$
(x_1 + ... + x_n)^p \equiv x_1^p + ... + x_n^p \pmod{p}
$$

如果我们将 $a$ 展开为 $a$ 个 $1$ 相加 $a = 1+ ... +1$，并代入上式展开，就有：

$$
a^p \equiv (1 + ... + 1)^p \equiv 1^p + ... + 1^p \equiv a \pmod{p}
$$

证明完成。

### 2.3 应用
#### 2.3.1 计算逆元

费马小定理在计算模逆元时也能派上用场。如果 $p$ 是素数，且 $a$ 不可被 $p$ 整除，那么 $a^{p-2}$ 就是 $a$ 在模 $p$ 意义下的逆元。即：

$$
a \cdot a^{p-2} \equiv 1 \pmod{p}
$$

举个例子， $a = 3$ ， $p = 5$ ，那么 $a$ 的逆元就是 $3^{5-2} \equiv 27 \equiv 2 \pmod{5}$。

#### 2.3.2 素数测试

费马小定理可用于进行概率性的素数测试。如果对于给定的素数 $p$，随机选择一个整数 $a$ 并检查是否满足 $a^{p-1} \equiv 1 \pmod{p}$。如果不满足，则一定不是素数；如果满足，则 $p$ 有可能是素数。然而，需要注意的是，存在伪素数，即不是素数但通过测试的数。



## 3. 总结

这一讲，我们介绍了模幂和费马小定理，费马小定理是一个在数论和密码学领域中非常有用的工具，具有广泛的应用。通过深入理解费马小定理，我们可以更好地应用它解决与素数测试、模逆元等相关的数学问题。
