---
title: 09. 欧拉函数
tags:
  - zk
  - basic
  - euler's totient function 
---

# WTF zk教程第9讲：欧拉函数

给定一个整数 $n$，小于等于 $n$ 的正整数中有多少和 $n$ 互质的数呢？这一讲，我们将研究这个问题，知识点包括单元集和欧拉函数。

## 1. 单元集

如果 $x \in \mathbb{Z}_n$ 是可逆的（即存在乘法逆元），那么我们称 $x$ 为 $\mathbb{Z}_n$ 的单元。 $\mathbb{Z}_n$ 所有单元的组成的集合被称为单元集（Unit set），记为 $\mathbb{Z}_n^*$。

通过之前的学习，我们知道 $x \in \mathbb{Z}_n$ 可逆的充要条件是 $x$ 与 $n$ 互质。因此 $\mathbb{Z}_n^*$ 中的元素就是 $[1, ..., n-1]$ 中与 $n$ 互质的正整数。在同余理论中，这个集合也被称为模 $N$ 的互质同余类。

举个几个例子：

$\mathbb{Z}^*_2 = \{1\}$

$\mathbb{Z}^*_3 = \{1,2\}$

$\mathbb{Z}^*_5 = \{1, 2, 3, 4\}$

$\mathbb{Z}^*_8 = \{1, 3, 5, 7\}$

$\mathbb{Z}^*_9 = \{1, 2, 4, 5, 7, 8\}$

$\mathbb{Z}^*_{15} = \{1, 2, 4, 7, 8, 11, 13, 14\}$

## 2. 欧拉函数

欧拉函数为 $\phi(n) = \left| \mathbb{Z}_n^* \right|$，为单元集 $\mathbb{Z}_n^*$ 中元素的个数。也就是 $[1, ..., n-1]$ 中与 $n$ 互质的整数的个数。另外，我们特别定义 $\phi(1) = 1$。

举个几个例子: $\phi(2) = 1$, $\phi(3) = 2$, $\phi(5) = 4$, $\phi(8) = 4$, $\phi(9) = 6$, $\phi(15) = 8$。

### 2.1 欧拉函数的性质

欧拉函数有一些神奇的性质，让我们很容易计算 $\mathbb{Z}_n^*$ 中元素的个数。前两条性质是当 $n$ 为质数时的性质。第三条是欧拉函数的积性，当 $n$ 为合数时，我们可以将它转换为几个质数的欧拉函数的乘积，方便计算。

#### 1. 对于质数 $p$，有 $\phi(p) = p-1$

举几个例子： $\phi(2) = 1$, $\phi(3)=2$, $\phi(13)=12$。

<details><summary>点我展开证明👀</summary>

由于 $p$ 为质数，所以任意 $x \in \mathbb{Z}_p$ 都与 $p$ 互质，也就是 $[1, ..., p-1]$，共 $p-1$ 个元素。

</details>

#### 2. 对于质数 $p$， 正整数 $k$，有 $\phi(p^k) = p^k - p ^{k-1}$。

举几个例子： 

$$
\phi(8)= \phi(2^3) = 2^3 - 2^2 = 4
$$

$$
\phi(9)=\phi(3^2) = 3^2 - 3^1 = 6
$$

<details><summary>点我展开证明👀</summary>

在 $[1, ..., p^k]$ 中共有 $p^k$ 个元素。由于 $p$ 为质数，因此其中仅有 $p$ 的倍数 $[p, 2p, 3p, ..., p^k -p, p^k]$ 可以被 $p$ 整除，不与 $p$ 互质。所以，每 $p$ 个数中，仅有 $1$ 个数不与 $p$ 互质，这样的数总共有 $p^k / p = p^{k-1}$ 个。因此，与 $p$ 互质的数共有 $p^k - p ^{k-1}$ 个， $\phi(p^k) = p^k - p ^{k-1}$。

</details>

#### 3. 若 $m$ 和 $n$ 互质，即 $\gcd(m,n)=1$，有 $\phi(mn) = \phi(m)\phi(n)$

举几个例子： 
    
$$
\phi(15)= \phi(3) \times \phi(5) = 2 \times 4 = 8
$$

$$
\phi(18)= \phi(2) \times \phi(3^2) = 1 \times (3^2 - 3^1) = 6
$$

<details><summary>点我展开证明👀</summary>

我们要证明 ${ \mathbb{Z}_{mn}^* }$ 和 $\mathbb{Z}_m^* \times \mathbb{Z}_n^*$ 存在双射关系，即 ${\mathbb{Z}_{mn}^*}$ 和 $\mathbb{Z}_m^* \times \mathbb{Z}_n^*$ 的元素一一对应，那么他们的元素个数就是相等的。而左边元素的个数是 $\phi(mn)$，右边的是 $\phi(m)\phi(n)$，因此 $\phi(mn) = \phi(m)\phi(n)$。

我们建立一个映射关系 $f: \mathbb{Z}_{mn}^* \to{\mathbb{Z}_m^* \times \mathbb{Z}_n^*}$，它对模 $m$ 和模 $n$ 的余数 $a, b$ 都是唯一确定的，所以这个映射是定义明确的。

**满射**: 由于 $m$ 和 $n$ 互质，通过中国剩余定理，我们知道对于任意的 $(a, b) \in \mathbb{Z}_m^* \times \mathbb{Z}_n^*$，考虑同余方程系统：

$x \equiv a \pmod{m}$

$x \equiv b \pmod{n}$

，有唯一解 $x$。因此，对于 $\mathbb{Z}_m^* \times \mathbb{Z}_n^*$ 中的任意元素，都存在一个 $x$ 使得 $f(x) = (a, b)$。因此 $f$ 是满射，也就是说映射覆盖了整个集合 $\mathbb{Z}_m^* \times \mathbb{Z}_n^*$。

**单射**: 假设有两个不同的元素 $x_1$ 和 $x_2$。就有 $f(x_1) = f(x_2)$，也就是 

$(x_1 \mod m, x_1 \mod n) = (x_2 \mod m, x_2 \mod n)$

这意味着 $x_1 \equiv x_2 \pmod{m}$ 且 $x_1 \equiv x_2 \pmod{n}$。因此有 $x_1 \equiv x_2 \pmod{mn}$。因此，$x_1$ 和 $x_2$ 在模 $mn$ 下是相等的，证明了 $f$ 是单射。

由于 $f$ 既是满射又是单射，则 $f$ 是双射。因此 ${\mathbb{Z}_{mn}^*}$ 和 $\mathbb{Z}_m^* \times \mathbb{Z}_n^*$ 存在双射关系，它们的元素一一对应，有 $\phi(mn) = \phi(m)\phi(n)$。

</details>


根据以上三条性质，我们可以把一个大数的欧拉函数转化成为它的因式分解后欧拉函数的乘积：若 $n$ 有质数分解 $p_1^{k_1}p_2^{k_2}...p_r^{k_r}$（其中各 $p_{i}$ 为互异的质因子， $k_i \ge 1$ 为质因子的次数），则欧拉函数在该处的值为：

$$
\phi(n)= p_1^{k_1-1}p_2^{k_2-1}...p_r^{k_r-1} (p_1 - 1) (p_2 -1)...(p_r-1) 
$$

也可以等价的写为：

$$
\phi(n)= n (1 - 1/p_1) (1 -1/p_2)...(1-1/p_r) 
$$

总之：由于任意大于 $1$ 的正整数都可以分解成若干质数的乘积，不妨设 $N=\prod_{i=1}^lp_i^{\alpha_i}$ ，则 $\varphi(N)=\prod_{i=1}^lp_i^{\alpha_i-1}(p_i-1)$ 。特别地，如果 $N=p^\alpha$ ，则 $\varphi(N)=p^{\alpha-1}(p-1)$ 。更为特殊地，如果 $N=p$ ，则 $\varphi(N)=p-1$ 。

### 2.2 代码实现：

我们可以用python实现欧拉函数。代码包含两个函数，`prime_factors()` 将 $n$ 质数分解，`euler_phi` 利用公式计算 $\phi(n)$：

```python
# 针对小整数，大整数目前分解仍是难题
def prime_factors(n):
    factors = []
    p = 2
    while p * p <= n:
        while n % p == 0:
            factors.append(p)
            n //= p
        p += 1
    if n > 1:
        factors.append(n)
    return factors

def euler_phi(n):
    result = n
    factors = prime_factors(n)

    for p in set(factors):
        result -= result // p

    return result

# 示例
n = 15
print(f"欧拉函数 phi({n}): {euler_phi(n)}")
# 欧拉函数 phi(15): 8
```

## 总结

这一讲，我们介绍了单元集和欧拉函数，它们可以用来计算小于等于 $n$ 的正整数中和 $n$ 互质的数量。我们将在下一讲介绍欧拉定理，会用到欧拉函数。
