---
title: 33. 扩域上的椭圆曲线
tags:
  - zk
  - abstract algebra
  - elliptic curve
  - group theory
  - finite field
---

# WTF zk 教程第 33 讲：扩域上的椭圆曲线

之前我们介绍了有限域 $\mathbb{F}_p$ 上的椭圆曲线，这一讲，我们将介绍 $\mathbb{F}_{2^k}$ 上的椭圆曲线，包括其定义、性质和在密码学中的应用。

## 1. $\mathbb{F}_2$ 上的椭圆曲线

计算机使用二进制进行计算，执行模2运算非常高效，这一节我们来探索模2下的椭圆曲线。有限域 $\mathbb{F}_2$，也叫二元域，是包含两个元素的有限域，通常表示为 $\set{0, 1}$。在这个域上，加法和乘法遵循模2运算，即：

- 加法（异或操作 XOR）: $0 + 0 = 0$, $0 + 1 = 1$, $1 + 0 = 1$, $1 + 1 = 0$。
- 乘法: $0 \times 0 = 0$, $0 \times 1 = 0$, $1 \times 0 = 0$, $1 \times 1 = 1$

但是，如果按 $y^2 \equiv x^3 + ax + b$ 来定义有限域 $\mathbb{F}_2$ 上的椭圆曲线 $E(\mathbb{F}_2)$ 就会有问题，因为它的判别式为 $\Delta= -16(4a^3 + 27b^2) \mod 2$，在模2下，不论 $a$ 和 $b$ 取什么值，判别式均为 0，也就意味着该椭圆曲线是奇异的，没有良好的性质。

因此，我们需要使用其他形式的椭圆曲线。一般的，在模2下我们会使用 Koblitz 曲线，它的形式: $y^2 + xy \equiv x^3 + ax + 1$ ，等式左边多了 $xy$ 一项。在模2下，判别式 $\Delta = 1$ 非零，曲线非奇异。

但 $\mathbb{F}_2$ 下的椭圆曲线 $E(\mathbb{F}_2)$ 上仅有 5 个点，太少了。我们需要寻找其他满足 $2 = 0$ 的有限域。

## 2. $\mathbb{F}_{2^k}$ 上的椭圆曲线

另一个满足 $2=0$ 的有限域是 $\mathbb{F}_{2^k}$ （ $k$ 是一个正整数）。它是 $\mathbb{F}_{2}$ 的扩域，由多项式环 $F[x]$ 中所有度小于 $n$ 的多项式构成，共有 $2^k$ 个元素。 

$\mathbb{F}_{2^k}$ 很适合计算机运算，因为其中的元素可以自然地表示为 $k$ 位的二进制数。举个例子，有限域 $F_{2^4}$ 的元素 $t^3 + t^2 + t + 1$ 可以可以表示为 $1111$。 $F_{2^k}$ 上的加法运和乘法运算就是多项式在模2下的加法和乘法运算。

有限域 $\mathbb{F}_{2^k}$ 上的椭圆曲线可以表示为以下形式的方程：

$$
y^2 + xy = x^3 + ax^2 + 1
$$

其中，$a, b$ 是域 $F_{2^k}$ 中的元素，曲线非奇异，其上的点 $(x, y)$ 的坐标也属于 $F_{2^k}$。

## 2.1 点的运算

Koblitz 曲线上的点也能构成群，满足如下规则：

1. 逆元：点 $P(x, y)$ 的逆元为 $-P(x, -y-x)$

2. 单位元：无穷远点 $O$。

3. 点加公式：对于椭圆上的点 $P(x_1, y_1)$ 和 $Q(x_2, y_2)$，设 $Q(x_3, y_3) = P + Q$，有 $x_3 = \lambda^2 + \lambda -a -x_1 - x_2$， $y_3 =  \lambda(x_1-x_3) - y_1 - x_3$，，其中 $\lambda = \frac{y_2 - y_1}{x_2 - x_1}$。

4. 倍点公式： $x(2P) = \lambda^2 + \lambda -a - 2x - x$， $y(2P)= \lambda(x-x(2P)) - y - x(2P)$，其中 $\lambda = \frac{3x^2 + 2ax - y}{x+2y}$。

可以看到 Koblitz 曲线上点运算的代数公式比标准 Weierstrass 曲线复杂很多。下面，我们将介绍一种快速在 Koblitz 曲线计算标量乘法的方法：Frobenius 映射。

## 3. Frobenius 映射

Frobenius （弗罗贝尼乌斯）映射可以加速椭圆曲线 $E(\mathbb{F}_{2^k})$ 上的点运算，这一节，我们将介绍它。

### 3.1 Frobenius 自同态

在抽象代数中，Frobenius（弗罗贝尼乌斯）自同态是特征为 $p$ 的Abel环 $R_p$ 中的一个特殊的自同态，它的同态映射（Frobenius 映射） $\tau$ 将环中的每个元素射到它的 $p$ 次幂：

$$
\tau: x \to x^p
$$

对于 $\alpha , \beta \in R_p$，满足如下性质：

**性质1. 加法同态：** $\tau(\alpha + \beta) = \tau(\alpha) + \tau(\beta)$

<details><summary>点我展开证明👀</summary>

根据定义， $\tau(\alpha + \beta) = (\alpha + \beta)^p$，根据二项式定理展开，除了 $\alpha^p$ 和 $\beta^p$ 两项之外，其余的系数都能被 $p$ 整除。由于环的特征是p，这些项的系数是0，可以删去。因此有 $(\alpha + \beta)^p = \alpha^p + \beta^p = \tau(\alpha) + \tau(\beta)$，证毕。

</details>

**性质2. 乘法同态：** $\tau(\alpha \cdot \beta) = \tau(\alpha) \cdot \tau(\beta)$

由定义和交换律，可知 $\tau(\alpha \cdot \beta) = (\alpha \cdot \beta)^p = \alpha^p \cdot \beta^p = \tau(\alpha) \cdot \tau(\beta)$。

**性质3. 可迭代：** 可以连续应用 Frobenius 映射，形成 $\tau^n(a) = a^{p^n}$。

**性质4. 有限域 $F_p$ 上的恒等映射：** 当 $p$ 为质数时，Frobenius 自同态是 $F_p$ 上的恒等映射，即对于任意 $\alpha \in F_p$，有 $\tau(\alpha) = \alpha^p = \alpha$。

根据费马小定理就能推出这个性质。因此，有限域 $F_{p^k}$ 上的 Frobenius 自同态性质更有意思：有限域 $F_{p^k}$ 的特征也是 $p$，也存在 Frobenius 自同态，并且不是恒等映射。

### 3.2 椭圆曲线上的 Frobenius 映射

对于定义在 $\mathbb{F}_{2^k}$ 上的椭圆曲线 $E(\mathbb{F}_{2^k})$，Frobenius 映射可以用来高效地计算倍点和标量乘法。

考虑一个定义在有限域扩域 $\mathbb{F}_{2^k}$ 上的椭圆曲线 $E$，为了简单起见，我们设方程为 $y^2 + xy = x^3 + ax^2 + 1$。在这样的曲线上，Frobenius 映射 $\tau$ 对点 $P = (x, y)$ 作用如下：

$$
\tau(P) = \phi(x, y) = (x^2, y^2)
$$

因为域的特征为2，Frobenius 映射简化为对坐标应用平方运算。它有如下性质：

**性质5. 椭圆曲线上的封闭性：** 设点 $P \in E(\mathbb{F}_{2^k})$， 那么 Frobenius 映射后的点 $\tau(P) \in E(\mathbb{F}_{2^k})$ 成立。

<details><summary>点我展开证明👀</summary>

根据定义， $\tau(P) = (\tau(x), \tau(y))$。因为点 $P$ 在椭圆曲线上，因此满足方程： $y^2 + xy - x^3 - ax^2 - 1 = 0$。等式两边同时进行 Frobenius 映射，有：

$\tau(y^2) + \tau(xy) - \tau(x^3) - \tau(ax^2) - \tau(1) = 0$

由于 Frobenius 映射的加法和乘法的同态，以及在 $F_p$ 上恒等映射的性质（系数上会用到），可以简化为：

$\tau(y)^2 + \tau(x)\tau(y) - \tau(x)^3 - a\tau(x)^2 - 1 = 0$

因此点 $\tau(P) = (\tau(x), \tau(y))$ 也满足椭圆曲线方程，在椭圆曲线 $E(\mathbb{F}_{2^k})$ 上。证毕。

</details>

**性质6. 椭圆曲线上点加的保持：** 设点 $P, Q \in E(\mathbb{F}_{2^k})$， 那么 $\tau(P + Q) = \tau(P) + \tau(Q)$ 成立。

<details><summary>点我展开证明👀</summary>

过程太复杂还没写。大致思路就是 $\tau$ 具有加法和乘法同态，以及以及在 $F_p$ 上恒等映射的性质（系数上会用到），因此能从点加法的公式推出 $\tau(P + Q) = \tau(P) + \tau(Q)$。

</details>

**性质7. 倍点快速算法：** 椭圆曲线 $E(\mathbb{F}_{2^k})$ 上的点 $P$ 满足 $\tau^2(P) + \tau(P) + 2P = O$，其中 $\tau^2(P) = \tau(\tau(P))$。 

证明非常复杂，就不写了。通过这个性质，我们可以得到 $2P = - \tau(P) - \tau^2(P)$。这个公式可以用来加速标量乘法的计算。思路就是计算 $nP$ 时，把 $n$ 拆为 $2a + b$，其中 $b \in \set{0, 1, -1}$，然后我们可以把其中的 2 用这个公式展开，再不断迭代直到 $a = 0$。比如 $2P = - \tau(P) - \tau^2(P)$， $7P = P - \tau(P) - \tau^5(P)$，这样比 Double-And-Add 算法要快。

## 4. 总结

这一讲，我们介绍了有限域 $\mathbb{F}_{2^k}$ 上的椭圆曲线，它可以在硬件上高效计算。我们还介绍了Koblitz 曲线和 Frobenius 映射。
