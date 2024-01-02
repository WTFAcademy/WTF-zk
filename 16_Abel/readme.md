---
title: 16. Abel群
tags:
  - zk
  - abstract algebra
  - group theory
  - abelian group
---

# WTF zk教程第16讲：Abel群

这一讲，我们将介绍一类在密码学中常用的群：Abel群，它的特点就是满足交换律。

## 1. Abel 群

Abel群除了满足4条群的基本性质之外，还需要满足交换律。若群 $(G, 🐔)$ 满足下列 5 个性质，则我们称 $G$ 为 Abel群：

1. **封闭性：** 对于任意 $a, b \in G$，有 $a 🐔 b \in G$。
2. **结合律：** 对于任意 $a, b, c \in G$，有 $(a 🐔 b) 🐔 c = a 🐔 (b 🐔 c)$。
3. **单位元：** 存在一个元素 $e \in G$，对于任意 $a \in G$，有 $a 🐔 e = e 🐔 a = a$。
4. **逆元：** 对于任意 $a \in G$，存在一个元素 $b \in G$，使得 $a 🐔 b = b 🐔 a = e$，其中 $e$ 是单位元。
5. **交换律：** 对于任意 $a, b \in G$，有 $a 🐔 b = b 🐔 a$。

因此，Abel就是满足交换律的群。由于加法、乘法运算都满足交换律，所以很多常见群都属于Abel群，包括：

1. 整数加法群 $(\mathbb{Z}, +)$，因为 $a + b = b+a$。

2. 整数去0乘法群 $(\mathbb{Z}, \times)$，因为 $ab = ba$。

3. 整数模n加法群 $(\mathbb{Z}_n, +)$，因为 $a + b \equiv b+a \pmod{n}$。

4. 整数模n乘法群 $(\mathbb{Z}_n^*, \times)$，因为 $ab \equiv ba \pmod{n}$。

## 2. Abel 群的性质

这一节，我们介绍Abel群的一些性质，并且将子群、正规子群、商群、同态的知识点复习一遍。

**1. 群 $(G, 🐔)$ 为Abel群，当且仅当对于任意 $a,b \in G$，有 $(a🐔b)^2 = a^2🐔b^2$**

<details><summary>点我展开证明👀</summary>

我们要证明群 $(G, 🐔)$ 满足交换律。对于任意 $a,b \in G$， $(a🐔b)^2 = a🐔b🐔a🐔b$

而 $(a🐔b)^2 = a^2🐔b^2$ 可以写成 $a🐔b🐔a🐔b = a🐔a🐔b🐔b$，两边分别消去最左边的 $a$ 和最右边的 $b$，有 $b🐔a = a🐔b$，因此交换律成立，群 $(G, 🐔)$ 是Abel群。证毕。

</details>

以 $(\mathbb{Z}, \times)$ 为例，有 $(2 \times 3)^2 = 2^2 \times 3^2 = 36$

**2. 群 $(G, 🐔)$ 为Abel群，对于任意 $a,b \in G$，有 $(a🐔b)^n = a^n🐔b^n$**

<details><summary>点我展开证明👀</summary>

$(G, 🐔)$ 为Abel群，$(a🐔b)^n = a🐔b🐔...🐔a🐔b = a🐔a🐔...🐔b🐔b = a^n🐔b^n$。证毕。

</details>

以 $(\mathbb{Z}, \times)$ 为例，有 $(2 \times 3)^n = 2^n \times 3^n$

**3. Abel群的子群也是Abel群。**

<details><summary>点我展开证明👀</summary>

设 $(G, 🐔)$ 为Abel群，群 $H$ 为 $G$ 的子群。对于任意 $a, b \in H$，有 $a, b \in G$，因此有有 $a 🐔 b = b 🐔 a$。所以群 $H$ 也是Abel群。证毕。

</details>

以 $(\mathbb{Z}, +)$ 为例，偶数加法群是它的子群，并且它也是Abel群，满足交换律。

**4. 群 $(G, 🐔)$ 为Abel群，对于整数n， $G$ 中每个元素的 $n$ 次方构成的群 $G^n$ 是 $G$ 的子群， $G^n = \set{a^n \mid a \in G}$。**

<details><summary>点我展开证明👀</summary>

设 $(G, 🐔)$ 为Abel群，对于任意 $a, b \in G$，有 $a^n, b^n \in G^n$。有 $a^n (b^n)^{-1} = a^n (b^{-1})^{n} = (ab^{-1})^n$。根据封闭性， $ab^{-1} \in G$，因此 $(ab^{-1})^n \in G$，因此群 $G^n$ 是 $G$ 的子群。证毕。

</details>

以 $(\mathbb{Z}, \times)$ 为例，所有整数的平方构成的群 $\set{1, 4, 9, ...}$ 是它的子群。再以 $(\mathbb{Z}_5^*, \times)$ 为例，所有元素的平方构成的集合 $(\mathbb{Z}_5^*)^2 = \set{1^2, 2^2, 3^2, 4^2} = \set{1,4,4,1} = \set{1,4}$ 是它的子群。这个性质对于我们之后理解二次方剩余很有帮助。

**5. Abel群的子群均是正规子群。**

<details><summary>点我展开证明👀</summary>

设群 $(G, 🐔)$ 为Abel群，它的任意子群为 $H$，对于任意 $g \in G$ 和 $h \in H$，有 $hg= gh$，因此 $H$ 为正规子群。证毕。

</details>

Abel群的交换律可以传递到子群，左右陪集相等，所以所有子群都是正规子群，可以构造商群。

**6. Abel群的商群均是Abel群。**

<details><summary>点我展开证明👀</summary>

设群 $(G, 🐔)$ 为Abel群，它的任意子群 $H$ 均是正规子群，可以构建商群 $G/H$。对于任意 $a, b \in G$ 和 $h \in H$，根据交换律，有 $(ah) (bh) = ahbh = bhah = (bh) (ah)$，因此有 $(aH)(bH) = (bH)(aH)$。因此，Abel群的商群均是Abel群。证毕。

</details>

Abel群的交换律可以传递到商群。

## 3. 总结

这一讲很轻松，我们介绍了具有交换律的Abel群及其性质。密码学和零知识证明中的常用群都是Abel群，之后我们还会经常见到它。