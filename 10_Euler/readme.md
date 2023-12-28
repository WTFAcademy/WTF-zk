---
title: 10. 欧拉定理
tags:
  - zk
  - basic
  - euler's theorem
---

# WTF zk教程第10讲：欧拉定理

欧拉定理是数论中的基本定理，表明在模运算中，对于任意整数与模数互质的情况下，该整数的欧拉函数次幂与模数同余于1，为RSA等加密算法提供了数学基础。这一讲，我们将介绍离散对数问题，单元阶，以及欧拉定理。

## 1. 离散对数问题

离散数学问题（Discrete Logarithm Problem）是数学和密码学中的一个经典难题，其实就是说模运算求对数非常难。

给定素数 $p$，以及整数 $g, h \in \mathbb{Z}_n^*$，要求找到整数 $x$，使得:

$$
g^x \equiv h \pmod{p}
$$

举个例子，对于 $(p, g, h) = (7, 3, 6)$，求满足等式 $3^x \equiv 6 \pmod{7}$ 的 $x$。我们尝试用穷举法来解决它：

$$
3^1 \equiv 3 \pmod{7}
$$

$$
3^2 \equiv 2 \pmod{7}
$$

$$
3^3 \equiv 6 \pmod{7}
$$

因此， $x = 3$ 满足条件。

但是对于更大的素数，计算离散对数非常难，比如 $(p, g, h) = (104729, 5, 3375)$ 就很难。而RSA加密算法和椭圆曲线密码系统的安全性就是由离散对数问题保障的，会选取更大更难计算的参数。


## 2. 单元阶

设 $a \in \mathbb{Z}_n$，能让 $a^k \equiv 1 \pmod{n}$ 的最小整数 $k$ 被称为单元 $a$ 的阶。

举个例子：

当模 $n = 5$， $a = 2$ 时，有：

$$
2^1 = 2 \pmod{5}
$$

$$
2^2 = 4 \pmod{5}
$$

$$
2^3 = 8 = 3 \pmod{5}
$$

$$
2^4 = 16 = 1 \pmod{5}
$$

因此 $a$ 的阶为 $4$。单元的阶很重要，因为它刻画了单元集的循环性质。我们可以看到 $2^5 = 2 \cdot 2^4 = 2 \cdot 1 = 2 \pmod{5}$，落入了下一个 $\set{2, 4, 3, 1}$ 循环中。

### 2.1 阶的性质

在数论中，阶（order）是一个重要的概念，表示一个元素与模数之间的循环性质。以下是数论中阶的一些重要性质：

#### 1. 如果 $a$ 的阶为 $k$，那么 $a^j \equiv 1 \pmod{n}$ 当且仅当 $k$ 整除 $j$。

继续使用上面的例子， $a=2, n =5$， $a$ 的阶为 $4$，有 $2^8 \equiv 256 \equiv 1 \pmod{5}$， $4$ 能整除 $8$。

<details><summary>点我展开证明 👀</summary>

首先，我们先把 $j$ 用 $k$ 表示。根据欧几里得除法，有

$$
j = qk + r
$$

其中 $0 \le r < k$。然后将它代入原式，有

$$
a^j = a^{qk+r} = a^{qk}a^r = (a^{k})^qa^r \equiv 1 \pmod{n}
$$

又因为 $a^k \equiv 1 \pmod{n}$，所以 $(a^{k})^q\equiv 1 \pmod{n}$，上式可以简化为

$$
a^r \equiv 1 \pmod{n}
$$

根据阶的定义，$k$ 是能让 $a^k \equiv 1 \pmod{n}$ 的最小整数，又因为 $0 \le r < k$，所以 $r = 0$，有：

$$
j = qk
$$

因此 $k$ 整除 $j$，证毕。
</details>

#### 2. 如果 $a$ 与模数 $n$ 互质，那么 $a$ 的阶 $k$ 能够整除 $\phi(n)$，其中 $\phi(n)$ 是欧拉函数。

<details><summary>点我展开证明 👀</summary>

这一性质涉及欧拉定理，我们会在下一节介绍。

根据欧拉定理，有 $a^{\phi(n)} \equiv 1 \pmod{n}$。根据第一个性质：如果 $a$ 的阶为 $k$，那么 $a^j \equiv 1 \pmod{n}$ 当且仅当 $k$ 整除 $j$。有 $k$ 整除$\phi(n)$。证毕。
</details>

## 3. 欧拉定理

欧拉定理将欧拉函数和幂运算的循环性质联系起来。

**定理：** 如果整数 $a$ 和正整数 $n$ 互质（即 $\gcd(a,n)=1$），那么 $a^{\phi(n)} \equiv 1 \pmod{n}$。

其中 $\phi(n)$ 是欧拉函数，也就是 $[1, ..., n-1]$ 中与 $n$ 互质的整数的个数。

继续使用上面的例子， $a=2, n =5$，首先计算 $\phi(5)=5-1=4$，有 $2^4 \equiv 16 \equiv 1 \pmod{5}$， 符合欧拉定理。

再举个例子， $a = 3, n = 7$，首先计算 $\phi(7) = 7-1 =6$，然后应用欧拉定理得到 $3^6 \equiv 1 \pmod{7}$。检查一下 $3^6 = 729$，除 $7$ 的余数为 $1$，欧拉定理正确。

<details><summary>点我展开证明 👀</summary>

考虑集合 $S = Z_n^* = \set{1 \le x \le n | \gcd(x,n) = 1}$。我们知道 $S$ 共有 $\phi(n)$ 个元素，把它们记为 $\set{x_1, x_2, ..., x_{\phi(n)}}$。

再考虑另一个集合 $S'$，它的元素是 $S$ 中的元素乘以 $a$，可以表示为：

$S' = aS = \set{ax_1, ax_2, ..., ax_{\phi(n)}}$

**引理1：** $\gcd(ax_i,n) = 1$。

证明：因为 $\gcd(a, n) = 1$ 且 $\gcd(x_i,n) = 1$，因此 $\gcd(ax_i,n) = 1$。

**引理2：** 从集合 $S'$ 任取两个元素，它们不在模 $n$ 下同余。

证明：假设 $S'$ 中存在两个元素 $ax_i$ 和 $ax_j$ 同余，有 $ax_i \equiv ax_j \pmod{n}$，那么有 $a(x_i- x_j) \equiv 0 \pmod{n}$，也就意味着 $n$ 整除 $a(x_i- x_j)$，即 $n|a(x_i- x_j)$。又因为 $\gcd(a, n) = 1$，那么 $n|(x_i- x_j)$，也就是 $x_i- x_j = kn$。又因为 $1 \le x_i, x_j \le n$，因此 $x_i - x_j = 0$，也就是 $x_i = x_j$，因此当且仅当 $i=j$ 时， $x_i$ 才和 $x_j$ 同余。证毕。

根据引理1和2，我们知道 $S'$ 由 $\phi(n)$ 个与 $n$ 互质的元素组成，且它们两两不同余。也就是说 $S' = Z_n^*$，和 $S$ 中包含的元素相同（但是顺序可能改变）。

接下来，我们分别将 $S$ 和 $S'$ 所有元素相乘，它们应该同余，也就是：

$(ax_1)(ax_2)...(ax_{\phi(n)}) \equiv x_1x_2...x_{\phi(n)} \pmod{n}$

把所有的 $a$ 提出来，一共 $\phi(n)$ 个，有：

$a^{\phi(n)} x_1x_2...x_{\phi(n)}  \equiv x_1x_2...x_{\phi(n)} \pmod{n}$

设 $X = x_1x_2...x_{\phi(n)}$，有 $\gcd(X,n) = 1$，因此原式可以简化成：

$a^{\phi(n)} X  \equiv X \pmod{n}$

因为 $X^{-1}$ 存在，我们在两边同时乘以 $X^{-1}$ 并简化，可以得到：

$a^{\phi(n)}  \equiv 1 \pmod{n}$

证毕！
</details>

### 3.1 与费马小定理的关系

我们可以很轻松的利用欧拉定理证明费马小定理。

根据欧拉定理：如果整数 $a$ 和正整数 $n$ 互质（即 $\gcd(a,n)=1$），那么 $a^{\phi(n)} \equiv 1 \pmod{n}$。

当 $n$ 为质数时， $\phi(n)=n-1$，代入原式，有 $a^{n-1} \equiv 1 \pmod{n}$， 等价于 $a^{n} \equiv a \pmod{n}$。这样，我们就证明了费马小定理，它可以被认为是欧拉定理 $n$ 为质数时的特殊情况。

### 3.2 代码实现

你可以在python中验证欧拉定理：

```python
def gcd(a, b):
    while b:
        a, b = b, a % b
    return a

def euler_phi(n):
    count = 0
    for i in range(1, n + 1):
        if gcd(n, i) == 1:
            count += 1
    return count

def euler_theorem(a, n):
    if gcd(a, n) != 1:
        raise ValueError("a and n must be coprime for Euler's theorem.")
    
    result = pow(a, euler_phi(n), n)
    return result

# 示例
n = 15
print(f"欧拉函数 phi({n}): {euler_phi(n)}")
# 欧拉函数 phi(15): 8

a = 7
result = euler_theorem(a, n)
print(f"欧拉定理: {a}^phi({n}) mod {n} = {result}")
# 欧拉定理: 7^phi(15) mod 15 = 1
```

## 4. 总结

这一讲，我们介绍了欧拉定理，以及它和费马小定理的关系。欧拉定理是RSA加密算法的数学基础，非常重要，大家要好好掌握。