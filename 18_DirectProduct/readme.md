---
title: 18. 群的直积
tags:
  - zk
  - abstract algebra
  - group theory
  - direct product
---

# WTF zk 教程第 18 讲：群的直积

这一讲，我们介绍群的直积，它可以用简单的群生成复杂群。并且，我们将通过它重温中国剩余定理，并证明中国剩余映射。

## 1. 群的直积

群的直积是两个或多个群的运算的组合，可以用来生成新的群。

**定义：** 给定两个群 $(G, 🐔)$ 和 $(H, 🦆)$，它们的直积 $G \times H$ 是一个新群，由所有可能的有序对 $(g, h)$ 组成，其中 $g \in G$ 且 $h \in H$。$G \times H$ 的运算为 $🐶$，对于任意 $g_1, g_2 \in G$ 和 $h_1, h_2 \in H$，

$$
(g_1, h_1) 🐶 (g_2, h_2) = (g_1 🐔 g_1, h_1 🦆 h_2)
$$

$(G \times H, 🐶)$ 满足群的 4 条基本性质：

1. **封闭性（Closure）：** 任意元素 $(g_1, h_1), (g_2, h_2)$ 属于 $G \times H$， $(g_1, h_1) 🐶 (g_2, h_2) = (g_1 🐔 g_1, h_1 🦆 h_2)$ 仍属于 $G \times H$。

2. **结合律（Associativity）：** 继承于群 $G$ 和 $H$。

3. **存在单位元（Identity Element）：** $G \times H$ 的单位元为 $(e_g, e_h)$。

4. **存在逆元（Inverse Element）：** 对于群中的每个元素 $(g, h)$，存在逆元素 $(g, h)^{-1} = (g^{-1}, h^{-1})$，有 $(g, h) 🐶 (g^{-1}, h^{-1}) = (e_g, e_h)$。

举个例子，两个整数加法群的直积 $\mathbb{Z}^2$ 是所有整数向量 $(x,y)$ 形成的加法群。运算符和向量加法，有 $(x_1, y_1) + (x_2, y_2) = (x_1 + x_2, y_1 + y_2)$。

再举个例子， $\mathbb{Z}_3$ 和 $\mathbb{Z}_5$ 的直积 $\mathbb{Z}_3 \times \mathbb{Z}_5$ 是所有所有可能的有序对 $(x, y)$ 的集合，其中 $x \in \mathbb{Z}_3$， $y \in \mathbb{Z}_5$。这个直积群的阶（元素个数）是 $15$，正好等于 $3 \times 5$。

## 2. 直积的性质

**性质 1. 两个群直积的阶等于它们阶的乘积。** 即 $|G \times H| = |G||H|$。

<details><summary>点我展开证明👀</summary>

根据定义，直积 $G \times H$ 由所有可能的有序对 $(g, h)$ 组成，其中 $g \in G$ 且 $h \in H$。对于每个 $G$ 中的元素，我们都可以在 $G \times H$ 中构造 $|H|$ 个不同的元素。群 $G$ 共有 $|G|$ 个不同元素。因此 $G \times H$ 中有 $|G||H|$ 个元素，即 $|G \times H| = |G||H|$。证毕。

</details>

$|\mathbb{Z}_3| = 3$， $|\mathbb{Z}_5| = 5$，有 $|\mathbb{Z}_3 \times \mathbb{Z}_5| = 15$。

**性质 2. 直积 $G \times H$ 中元素 $(g, h)$ 的阶是 $|g|$ 和 $|h|$ 的最小公倍数。** 即 $|(g,h)| = \text{lcm}(|g|,|h|)$。特别的，如果 $|g|$ 和 $|h|$ 互质，那么 $(g, h)$ 的阶就是 $|g||h|$

<details><summary>点我展开证明👀</summary>

设存在最小整数 $k = |(g,h)|$ 使得 $(g,h)^k = (e_g, e_h)$。因为 $(g,h)^k = (g^k, h^k)$，因此 $g^k = e_g$, $h^k = e_h$。因此 $k$ 被 $|g|$ 和 $|h|$ 整除，又因为 $k$ 为满足条件的最小整数，因此 $k = \text{lcm}(|g|,|h|)$。证毕。

若 $|g|$ 和 $|h|$ 互质，那么 $\text{lcm}(|g|,|h|) = |g||h|$。证毕。

</details>

在 $\mathbb{Z}_3$ 中，元素 1 的阶 $|1|= 3$；在 $\mathbb{Z}_5$ 中，元素 1 的阶 $|1|= 5$。由于 $\gcd(3,5)=1$，因此在 $\mathbb{Z}_3 \times \mathbb{Z}_5$ 中，元素 1 的阶 $|1|= 3 \times 5 = 15$。

**性质 3. 若群 $G$ 和 $H$ 是循环群，它们的阶分别为 $|G|$ 和 $|H|$。直积 $G \times H$ 是循环群，当且仅当 $|G|$ 和 $|H|$ 互质。**

<details><summary>点我展开证明👀</summary>

**必要性**

群 $G = \left \langle \, x \, \right \rangle$ 和 $H = \left \langle \, y \, \right \rangle$ 是循环群，它们的阶 $|G| = m$ 和 $|H| = n$，且 $m$ 和 $n$ 互质。设 $|(x, y)| = k$，那么有 $(x,y)^k = (x^k, y^k) = (e_G, e_H)$。

所以有 $x^k = e_G$ 和 $y^k = e_H$，根据元素的阶的性质，有 $m|k$ 且 $n|k$。又因为 $\gcd(m,n) = 1$，所以有 $mn|k$。

又因为 $(x,y)^{mn} = (x^k, y^k) = (e_G, e_H)$，有 $k|mn$。因此元素的阶 $|(x, y)| = k = mn$。根据性质 1，有 $|G \times H| = |G||H| = mn$。因此，元素 $(x,y)$ 可以生成整个群， $G \times H$ 为循环群。证毕。

**充分性**

$|G| = m$ 和 $|H| = n$。假设 $G \times H = \left \langle \, (x,y) \, \right \rangle$ 是循环群。根据性质 1，有 $|G \times H| = |G||H| = mn$。因为循环群的阶和生成元的阶相等，所以 $|(x,y)| = mn$。根据性质 2，有 $|(x,y)| = \text{lcm}(|x|, |y|)$。因此 $\text{lcm}(|x|, |y|) = mn$。

根据最大公约数和最小公倍数的关系，有 $|x||y| = \gcd(|x||y|) \text{lcm}(|x|, |y|) =  \gcd(|x||y|) mn $。又因为 $|x| \leq m$ 且 $|y| \leq n$，所以 $|x||y| \leq mn$。因此，当且仅当 $\gcd(|x||y|) = 1$ 时，等式成立，也就意味着 $m$ 与 $n$ 互质。证毕。

</details>

直积 $\mathbb{Z}_3 \times \mathbb{Z}_5$ 是循环群，生成元为 $(1,1)$，阶为 $15$。

## 3. 重温中国剩余定理

在数论基础中，我们介绍了中国剩余定理，它可以用于解同余方程组。我们简单复习一下：

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

现在我们可以通过群同构和直积更好地理解中国剩余定理：

如果 $m_i$ 两两互质，那么映射 $f: x \mod M \to (x \mod m_1,..., x \mod m_n)$ 定义了一个 $Z_M$ 到 $Z_{m_1} \times ... \times Z_{m_n}$ 的群同构。这个映射也被称为中国剩余映射。

<details><summary>点我展开证明👀</summary>

**同态**

首先，我们证明 $f$ 是群同态。对于任意 $a, b \in \mathbb{Z}_M$，有 $f(a+b) = a+b \mod M =  (a+b \mod m_1,..., a+b \mod m_n) = (a \mod m_1,..., a \mod m_n) + (b \mod m_1,..., b \mod m_n) = f(a) + f(b)$。因此 $f$ 为群同态。证毕。

**同构**

$m_i$ 两两互质， $Z_{m_i}$ 皆为循环群，且 $Z_{m_i}$ 的阶为 $m_i$。我们很容易将直积的性质 3 推广至 $n$ 个群的情况，得到结论 $Z_{m_1} \times ... \times Z_{m_n}$ 为循环群，它的阶为 $M = m_1 \cdot m_2 \cdot... \cdot m_n$。运用循环群的同构性质，任意 $M$ 阶有限循环群都同构于整数模 $M$ 加法群 $Z_M$。因此 $Z_M$ 与 $Z_{m_1} \times ... \times Z_{m_n}$ 同构。证毕。

</details>

由于 $Z_M$ 和 $Z_{m_1} \times ... \times Z_{m_n}$ 同构，它们之间的元素一一对应，因此同余方程组存在模 M 下的唯一解。

## 4. 总结

这一讲，我们介绍了群的直积，它是一种通过几个简单的群生成一个复杂的群的方法。利用群直积的性质，我们重温了中国剩余定理，从群论的角度理解了为什么模数互质的同余方程组存在唯一解。
