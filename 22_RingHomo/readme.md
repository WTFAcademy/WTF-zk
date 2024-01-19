---
title: 22. 环同态与同构
tags:
  - zk
  - abstract algebra
  - ring theory
  - homomorphism
  - isomorphism
---

# WTF zk 教程第 22 讲：环同态与同构

在前几讲中，我们学习了环的基本定义、性质，以及理想和商环的概念。这一讲，我们将介绍环同态和同构，这两个概念与群同态/同构类似，有助于我们理解环之间的结构和关系。

## 1. 环同态

环同态类似于群同态，是两个环之间的一种保持结构的映射。设两个环 $(R, +, \cdot)$ 和 $(S, \oplus, \odot )$，它们的零元分别为 $0_R$ 和 $0_S$，乘法单位元为 $1_R$ 和 $1_S$，若映射 $f: R \rightarrow S$ 满足以下条件：

1. 加法同态：对于任意 $a, b \in R$，有 $f(a + b) = f(a) \oplus f(b)$。这条性质和群同态一样。

2. 乘法同态：对于任意 $a, b \in R$，有 $f(a \cdot b) = f(a) \odot f(b)$。

3. 乘法单位元的保持： $f(1_R) = 1_S$。

则称 $f$ 为 $R$ 到 $S$ 的同态。

环同态中的同态核与同态像的定义如下：

- **同态核：** 同态核是同态 $f: R \rightarrow S$ 中所有映射到 $S$ 的零元的元素集合，即 $\text{Ker}(f) = \{ a \in R \mid f(a) = 0_S \}$。

- **同态像：** 同态像是环 $R$ 中所有元素在环 $S$ 中的像的集合，即 $\text{Im}(f) = \{ f(a) \mid a \in R \}$。

### 1.1 环同态的性质

**性质1. 加法单位元的保持： $f(0_R) = 0_S$。** 

<details><summary>点我展开证明👀</summary>

对于任意 $a \in R$，根据加法同态，有 $f(a) = f(a + 0_R) = f(a) \oplus f(0_R)$。因此有 $f(0_R) = 0_S$。证毕。

</details>

**性质2. 加法逆元的保持： $f(-a) = - f(a)$。** 

<details><summary>点我展开证明👀</summary>

对于任意 $a \in R$，根据加法同态，有 $0_S = f(0_R) = f(-a + a) = f(-a)  \oplus f(a)$。因此有 $f(a)$ 和 $f(-a)$ 互为加法逆元 ，即 $f(-a) = - f(a)$。证毕。

</details>

**性质3. 单元（乘法可逆元素）的保持： 如果 $a^{-1}$ 存在，那么 $f(a)^{-1}$ 也存在，并且 $f(a^{-1}) = f(a)^{-1}$。** 

<details><summary>点我展开证明👀</summary>

对于任意 $a \in R$，根据乘法同态，有 $f(a^{-1}) \otimes f(a) = f(a^{-1}a) = f(1_R) = 1_S$。因此有 $f(a) $ 和 $f(a^{-1})$ 互为乘法逆元 ，即 $f(a^{-1}) = f(a)^{-1}$。证毕。

</details>

**性质4. 理想的保持： 如果 $I$ 是 $R$ 的理想，那么 $f(I)$ 是 $S$ 的理想。** 

<details><summary>点我展开证明👀</summary>

**加法子群**

对于任意 $a, b \in I$，有 $f(a), f(b) \in f(I)$。根据加法同态，有 $f(a) - f(b) = f(a - b) \in f(I)$。因此 $f(I)$ 为 $S$ 的加法子群。

**乘法吸收律**

对于任意 $a \in I$ 和 $b \in R$，根据吸收律，有 $ab = a'$，其中 $a' \in I$。因此，对于任意 $f(a) \in f(I)$ 和 $f(b) \in S$，根据乘法同态，有 $f(a)f(b) = f(ab) = f(a') \in f(I)$。因此 $f(I)$ 满足乘法吸收律。

因此 $f(I)$ 是 $S$ 的理想。证毕。

</details>

**性质5. 同态核 $\text{Ker}(f)$ 是 $R$ 的理想。** 

<details><summary>点我展开证明👀</summary>

**加法子群**

对于任意 $a, b \in \text{ker}(f)$，有 $f(a) = f(b) = 0_S$。我们考虑 $a - b$，有 $f(a - b) = f(a) - f(b) = 0_S - 0_S = 0_S$。因此，$a - b \in \text{ker}(f)$。同态核 $\text{Ker}(f)$ 是 $R$ 的加法子群。

**乘法吸收律**

对于任意 $r \in R$ 和 $a \in \text{ker}(f)$，即 $f(a) = 0_S$。我们考虑 $ra$，有 $f(ra) = f(r)f(a) = f(r) \cdot 0_S = 0_S$。因此，$ra$ 属于 $\text{ker}(f)$，满足乘法吸收律。

因此同态核 $\text{Ker}(f)$ 是 $R$ 的理想，证毕。

</details>

**性质6. 同态像 $\text{Im}(f)$ 是 $S$ 的理想。** 

<details><summary>点我展开证明👀</summary>

根据定义 $\text{Im}(f) = f(R)$，又因为环 $R$ 是自身的平凡理想，根据理想的保持，同态像 $\text{Im}(f) = f(R)$ 是环 $S$ 的理想。证毕。

</details>

### 1.2 环同态的例子

考虑两个环 $R$ 和 $S$，其中 $R = \mathbb{Z}$（整数环）和 $S = \mathbb{Z}_n$（整数模 $n$ 环）。定义一个映射 $f: \mathbb{Z} \rightarrow \mathbb{Z}_n$ 计算整数模 $n$ 的余数：

$$
f(a) = a \mod n
$$

这是一个环同态，因为它保持整数的加法和乘法：

1. 加法同态：对于任意整数 $a, b$，有 $f(a + b) = (a + b) \mod n = (a \mod n + b \mod n) \mod n = f(a) + f(b)$。

2. 乘法同态：对于任意整数 $a, b$，有 $f(ab) = (ab) \mod n = (a \mod n)( b \mod n) \mod n = f(a)f(b)$。

3. 乘法单位元的保持： $R$ 和 $S$ 的乘法单位元均为 $1$，且 $1 = 1 \pmod n$。

## 2 环同构

环同构与群同构非常相似。如果环同态 $f: R \rightarrow S$ 既是单射又是满射，那么我们称 $R$ 和 $S$ 是同构的，记作 $R \cong S$。这意味着它们的结构就是相同的，每个元素一一对应，只是名字不同。

## 2.1 第一同构定理

我们在群论介绍了第一同构定理，它将群，子群，陪集，商群，同态，和同构。这个定理可以扩展到环上。

**第一同构定理（环论）：** 若两个环 $R$ 和 $S$，有环同态 $f: R \rightarrow S$，那么我们可以构造环同构 $R/\text{Ker}(f) \cong \text{Im}(f)$，即群 $R$ 模同态核得到的商群与同态像是同构的，同构映射为 $\hat{f}(x + \text{Ker}(f)) = f(x)$。

### 2.2 环同构的例子

用之前的例子：整数环 $\mathbb{Z}$ 和整数模 $n$ 环 $\mathbb{Z}_n$（整数模 $n$ 环），存在同态 $f(a) = a \mod n$，其中同态核为 $n\mathbb{Z}$，同态像为 $\mathbb{Z}_n$。

那么，我们可以构造 $\mathbb{Z}/ n\mathbb{Z}$ 到 $\mathbb{Z}_n$ 的同构 $\hat{f}(a + n\mathbb{Z}) = f(a)$。实际上 $\mathbb{Z}/ n\mathbb{Z}$ 和 $\mathbb{Z}_n$ 代表同样的环，经常在不同地方混用。

## 3. 总结

这一讲，我们介绍了环同态和环同构。环同态提供了一种保持环结构的方式；而环同构则表示两个环在结构上是相同的，只是元素的命名不同。

