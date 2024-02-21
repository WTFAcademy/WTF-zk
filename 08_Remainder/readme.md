---
title: 08. 中国剩余定理
tags:
  - zk
  - basic
  - chinese remainder theorem
---

# WTF zk教程第8讲：中国剩余定理

这一讲，我们将介绍剩余类和著名的中国剩余定理，它可以用来解同余方程组。

## 1. 物不知数问题

中国南北朝（公元420年—589年）的《孙子算经》上记载着这样一道题，被称为“物不知数”问题，解出这道题的勇士可以得到孙子所持有的BTC（余额：0）。

> 有物不知其数，三三数之剩二，五五数之剩三，七七数之剩二。问物几何？

翻译一下古文：有个未知数 $x$，除3余2，除5余3，除7余2，求 $x$。

其实这是一个求一元线性同余方程组的问题，即找到满足下列方程组的 $x$。

$$
x \equiv 2 \pmod{3}
$$

$$
x \equiv 3 \pmod{5}
$$

$$
x \equiv 2 \pmod{7}
$$

下面我们要介绍的中国剩余定理就是用来解决这一问题的。

## 2. 剩余类

在第5讲中，我们简单了解了剩余类（residual class）/同余类的概念，现在我们需要更系统的介绍它。

剩余类是一种等价关系，用于将整数划分为同余的集合，定义如下：

> 给定一个整数 $m$ ，我们定义整数 $a$ 在模 $m$ 下的剩余类为所有与 $a$ 在模 $m$ 下同余的整数的集合。这个集合通常用 $[a]_m$ 表示，可以表示为：

$$
[a]_m = \{ b \in \mathbb{Z} \mid a \equiv b \pmod{m} \}
$$

其中 $\equiv$ 表示同余关系。

举个例子，对于模 $m = 5$，剩余类有 $[0]_5, [1]_5, [2]_5, [3]_5, [4]_5$ 等：

$$
[0]_5 = \set{..., -10, -5, 0, 5, 10, ... }
$$

$$
[1]_5 = \set{..., -9, -4, 1, 6, 11, ... }
$$

$$
[2]_5 = \set{..., -8, -3, 2, 7, 12, ... }
$$

$$
[3]_5 = \set{..., -7, -2, 3, 8, 13, ... }
$$

$$
[4]_5 = \set{..., -6, -1, 4, 9, 14, ... }
$$

剩余类的选择并不唯一，比如 $[5]_5, [6]_5, [7]_5, [8]_5, [9]_5$ 也是模5下的剩余类，但我们通常选择最小的非负整数代表剩余类，它们被称为剩余类的代表元。比如模5下剩余类的代表元就是 $\set{0_5, 1_5, 2_5, 3_5, 4_5}$ ，在语义明确情况下也可以省略角标，写为 $\set{0, 1, 2, 3, 4}$ ，也可以写为 $Z_5$

### 2.1. 性质

剩余类构成了整数集合的一种划分，它满足等价关系的三个性质：

- **自反性：** 任意整数 $a$ 都与它自身同余， $a \equiv a \pmod{m}$ ，因此 $[a]_m$ 非空。

- **对称性：** 如果 $a \equiv b \pmod{m}$ ，则有 $b \equiv a \pmod{m}$ ， 也可以写为 $[a]_m = [b]_m$ 。

- **传递性：** 如果 $a \equiv b \pmod{m}$ 且 $b \equiv c \pmod{m}$ ，则有 $a \equiv c \pmod{m}$ ，也可以写为 $[a]_m = [b]_m = [c]_m$ 。

### 2.2 剩余类的运算

由于剩余类是将整数划分为同余的集合，可以看作是同余关系的一种抽象和推广，因此它的运算和同余是相同的。

例如，对于两个剩余类 $[a]_m$ 和 $[b]_m$ ，有：

$$
[a]_m + [b]_m = [a + b]_m
$$

$$
[a]_m \cdot [b]_m = [a \cdot b]_m
$$

## 3. 同余方程组

### 3.1 同余方程

同余方程是数论中重要的一类方程，形如 $ax \equiv b \pmod{m}$。解同余方程的过程涉及到模运算、模逆元等概念。

例子: $4x \equiv 2 \pmod{6}$

首先，我们发现式子两边都有 $2$，而且 $\gcd(2, 6) = 2$，因此我们可以将两边和模同时除以 $2$，得到：

$$
2x \equiv 1 \pmod{3}
$$

由于 $2$ 和模 $3$ 互质，因此 $2^{-1} \pmod{3}$ 存在。我们可以将上式写为：

$$
x \equiv 2^{-1} \pmod{3}
$$

我们可以通过穷举法得到 $2^{-1} \pmod{3} \equiv 2$，因此解得:

$$
x = [2]_3
$$

### 3.2 同余方程组

同余方程组是由多个同余方程组成的一组方程，每个方程都涉及模运算。

我们先看一个仅包含2个方程的例子: 

$$
x \equiv 2 \pmod{3}
$$

$$
x \equiv 3 \pmod{5}
$$

通过观察，我们知道如果 $y$ 是方程的解，那么 $y+15$ 也是。通过穷举法，我们容易得到 $y=8$ 是一个解，因此方程组的通解为 $[8]_{15}$，也就是:

$$
x = 8 + 15k
$$

其中 $k \in \mathbb{Z}$。

## 4. 中国剩余定理

中国剩余定理给出了一元线性同余方程组的解存在的条件和求解方法。

### 4.1 简单形式

我们先看只包含2个方程的同余方程组，然后再推广到 $n$ 个方程。

整数 $p$ 和 $q$ 互质，方程组如下：

$$
x \equiv a \pmod{p}
$$

$$
x \equiv b \pmod{q}
$$

根据中国剩余定理，该方程组有唯一解：

$$
x \equiv aqq_1+bpp_1 \pmod{pq}
$$

其中 $p_1 = p^{-1} \pmod{q}$， $q_1 = q^{-1} \pmod{p}$。

<details><summary>点我展开证明👀</summary>

用上式模 $p$，我们得到 $x \equiv aqq_1 \pmod{p}$，因为 $bpp_1$ 可以被 $p$ 整除。又因为 $qq_1\pmod{p} = 1$，因此有 $x \equiv a \pmod{p}$，满足条件。

同样的，用上式模 $q$，我们得到 $x \equiv b \pmod{q}$，满足条件。

因此 $x \equiv aqq_1+bpp_1 \pmod{pq}$ 是该方程组的解。

下面我们证明解是唯一的：

假设有另一个解 $y$ 满足方程组。

1. 因为 $y \equiv a \pmod{p}$，有 $p|y-x$。

2. 因为 $y \equiv b \pmod{q}$，有 $q|y-x$。

3. 因为 $p$ 和 $q$ 互质，有 $pq|y-x$，因此 $y \equiv x \pmod{pq}$，解是唯一的。

</details>

#### 示例

让我们用中国剩余定理来解 $3.2$ 中的示例：

$$
x \equiv 2 \pmod{3}
$$

$$
x \equiv 3 \pmod{5}
$$

有 $pq = 15$， $p_1= 3^{-1} = 2 \pmod{5}$， $q_1 = 5^{-1}  = 2\pmod{3}$。所以：

$$
x \equiv 2 \times 5 \times 2 + 3 \times 3 \times 2 \equiv 38 \equiv 8 \pmod{15}
$$

与我们之前用穷举法得到的答案一样。

### 4.2 通解

下面我们介绍中国剩余定理的通解形式。

整数 $m_1, m_2,...,m_n$ 两两互质（对于 $i \ne j$，有 $\gcd(m_i,m_j) = 1$），方程组包含 $n$ 个方程：

$$
x \equiv a_1 \pmod{m_1}
$$

$$
x \equiv a_2 \pmod{m_1}
$$

$$
...
$$


$$
x \equiv a_n \pmod{m_n}
$$

方程对于模 $M=m_1 \cdot m_2 \cdot... \cdot m_n$ 有唯一解：

$$
x \equiv \sum_{i=1}^{n}{a_ib_ib_i'} \pmod{M}
$$

其中 $b_i = M/m_i$（即除了 $m_i$ 以外的所有模数的乘积）， $b_i'=b_i^{-1} \pmod{m_i}$（即模 $m_i$ 下 $b_i$ 的逆元）。

<details><summary>点我展开证明👀</summary>

用通解模 $m_i$，得到 $x \equiv a_ib_ib_i' \pmod{m_i}$，因为除了第 $i$ 项，其余项的中都可以被 $m_i$ 整除。又因为 $b_ib_i' \equiv 1 \pmod{m_i}$，因此有 $x \equiv a_i \pmod{m_i}$，满足条件，是方程组的解。

</details>

### 4.3 解决物不知数问题

有了中国剩余定理，我们能够轻松的解决物不知数问题：

$$
x \equiv 2 \pmod{3}
$$

$$
x \equiv 3 \pmod{5}
$$

$$
x \equiv 2 \pmod{7}
$$

首先，模 $M = 3 \times 5 \times 7 = 105$。

接下来，分别计算 $a_i, b_i, b_i'$。

$a_1 = 2, b_1 = 35, b_1' \equiv 35^{-1} = 2\pmod{3}$

$a_2 = 3, b_2 = 21, b_2' \equiv 21^{-1} = 1\pmod{5}$

$a_3 = 2, b_3 = 15, b_3' \equiv 15^{-1} = 1\pmod{7}$

因此，方程组的解为 $x \equiv 2 \times 35 \times 2 + 3 \times 21 \times 1 + 2 \times 15 \times 1 \equiv 233 \equiv 23 \pmod{105}$。

代入方程试一下，23除3余2，除5余3，除7余2，满足条件。

### 4.4 代码实现

我们可以在python中实现中国剩余定理：

```python
def extended_gcd(a, b):
    if b == 0:
        return a, 1, 0
    else:
        d, x, y = extended_gcd(b, a % b)
        return d, y, x - (a // b) * y

def chinese_remainder_theorem(congruences):
    """
    中国剩余定理求解函数

    :param congruences: 模线性同余方程组，格式为 [(a1, m1), (a2, m2), ..., (an, mn)]，表示方程组为 x ≡ ai (mod mi)
    :return: 方程组的解 x
    """
    # 计算模数的乘积 M
    M = 1
    for _, mi in congruences:
        M *= mi

    # 计算 Mi 和 Mi 的模逆元素
    M_values = [M // mi for _, mi in congruences]
    Mi_values = [extended_gcd(Mi, mi)[1] for Mi, (_, mi) in zip(M_values, congruences)]

    # 计算解 x
    x = sum(ai * Mi * mi for (ai, _), Mi, mi in zip(congruences, Mi_values, M_values)) % M

    return x

# 示例：解 x ≡ 2 (mod 3), x ≡ 3 (mod 5), x ≡ 2 (mod 7)
congruences = [(2, 3), (3, 5), (2, 7)]
solution = chinese_remainder_theorem(congruences)
print(f"同余方程组的解为 x ≡ {solution} (mod {congruences[0][1] * congruences[1][1] * congruences[2][1]})")
# 同余方程组的解为 x ≡ 23 (mod 105)
```

### 4.5 逆向使用

中国剩余定理可以被逆向使用，将方程的解 $X$ 分解为若干个同余方程组。比如在物不知数问题中，我们得到的解 $x \equiv 23 \pmod{105}$，可以被分解为 3 个方程：

$$
x \equiv 2 \pmod{3}
$$

$$
x \equiv 3 \pmod{5}
$$

$$
x \equiv 2 \pmod{7}
$$

这样，我们可以将“大问题”分解为“小问题”，这一特性在零知识证明中非常重要。

## 5. 总结

这一讲，我们学习了剩余类，同余方程组，和中国剩余定理。其中中国剩余定理不仅可以解同余方程组，还可以逆向使用，将大问题分解为小问题，在零知识证明中非常重要。