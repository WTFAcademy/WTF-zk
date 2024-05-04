---
title: 16. Abel Group
tags:
  - zk
  - abstract algebra
  - group theory
  - abelian group
---

# WTF zk Tutorial Lesson 16: Abel Group

In this lecture, we will introduce a type of group commonly used in cryptography: the Abel Group, which is characterized by the commutative property.

## 1. Abel Group

In addition to satisfying the four basic properties of a group, an Abel Group also needs to satisfy the commutative property. If a group $(G, 🐔)$ satisfies the following five properties, then we call $G$ an Abel Group:

1. **Closure:** For any $a, b \in G$, $a 🐔 b \in G$.
2. **Associativity:** For any $a, b, c \in G$, $(a 🐔 b) 🐔 c = a 🐔 (b 🐔 c)$.
3. **Identity Element:** There exists an element $e \in G$ such that for any $a \in G$, $a 🐔 e = e 🐔 a = a$.
4. **Inverse Element:** For any $a \in G$, there exists an element $b \in G$ such that $a 🐔 b = b 🐔 a = e$, where $e$ is the identity element.
5. **Commutative Property:** For any $a, b \in G$, $a 🐔 b = b 🐔 a$.

Therefore, Abel Group refers to a group that satisfies the commutative property. Since addition and multiplication operations both satisfy the commutative property, many common groups belong to the Abel Group, including:

1. Integers under addition $(\mathbb{Z}, +)$, because $a + b = b + a$.

2. Non-zero integers under multiplication $(\mathbb{Z}, \times)$, because $ab = ba$.

3. Integers modulo n under addition $(\mathbb{Z}_n, +)$, because $a + b \equiv b + a \pmod{n}$.

4. Non-zero integers modulo n under multiplication $(\mathbb{Z}_n^*, \times)$, because $ab \equiv ba \pmod{n}$.

## 2. Properties of Abel Group

In this section, we will discuss some properties of the Abel Group and review the concepts of subgroup, normal subgroup, quotient group, and homomorphism.

**1. A group $(G, 🐔)$ is an Abel Group if and only if for any $a, b \in G$, $(a🐔b)^2 = a^2🐔b^2$.**

<details><summary>Click to expand proof👀</summary>

We want to prove that the group $(G, 🐔)$ satisfies the commutative property. For any $a, b \in G$, $(a🐔b)^2 = a🐔b🐔a🐔b$

And $(a🐔b)^2 = a^2🐔b^2$ can be written as $a🐔b🐔a🐔b = a🐔a🐔b🐔b$, by canceling the leftmost $a$ and the rightmost $b$, we have $b🐔a = a🐔b$, thus the commutative property holds and the group $(G, 🐔)$ is an Abel Group. QED.

</details>

Taking $(\mathbb{Z}, \times)$ as an example, we have $(2 \times 3)^2 = 2^2 \times 3^2 = 36$.

**2. A group $(G, 🐔)$ is an Abel Group if for any $a, b \in G$, $(a🐔b)^n = a^n🐔b^n$.**

<details><summary>Click to expand proof👀</summary>

$(G, 🐔)$ is an Abel Group, $(a🐔b)^n = a🐔b🐔...🐔a🐔b = a🐔a🐔...🐔b🐔b = a^n🐔b^n$. QED.

</details>

Taking $(\mathbb{Z}, \times)$ as an example, we have $(2 \times 3)^n = 2^n \times 3^n$.

**3. Subgroups of an Abel Group are also Abel Groups.**

<details><summary>Click to expand proof👀</summary>

Let $(G, 🐔)$ be an Abel Group, and let $H$ be a subgroup of $G$. For any $a, b \in H$, we have $a, b \in G$, therefore $a 🐔 b = b 🐔 a$. Thus, the subgroup $H$ is also an Abel Group. QED.

</details>

Taking $(\mathbb{Z}, +)$ as an example, the even additive group is a subgroup of it, and it is also an Abel Group, satisfying the commutative property.

**4. For an Abel Group $(G, 🐔)$, for any integer $n$, the group $G$ raised to the power of $n$ forms a subgroup of $G$, denoted as $G^n = \set{a^n \mid a \in G}$.**

<details><summary>Click to expand proof👀</summary>

Let $(G, 🐔)$ be an Abel Group, and let $a, b \in G$, we have $a^n, b^n \in G^n$. We have $a^n (b^n)^{-1} = a^n (b^{-1})^{n} = (ab^{-1})^n$. Based on closure, $ab^{-1} \in G$, therefore $(ab^{-1})^n \in G$, thus the group $G^n$ is a subgroup of $G$. QED.

</details>

Taking $(\mathbb{Z}, \times)$ as an example, the group composed of all squares of integers, $\set{1, 4, 9, ...}$, is a subgroup of it. Taking $(\mathbb{Z}_5^*, \times)$ as an example, the set of squares of all elements $(\mathbb{Z}_5^*)^2 = \set{1^2, 2^2, 3^2, 4^2} = \set{1,4,4,1} = \set{1,4}$ is a subgroup of it. This property is helpful for us to understand quadratic residues later on.

**5. Subgroups of an Abel Group are all normal subgroups.**

<details><summary>Click to expand proof👀</summary>

Let $(G, 🐔)$ be an Abel Group, and let $H$ be any subgroup of $G$. For any $g \in G$ and $h \in H$, we have $hg= gh$. Therefore, $H$ is a normal subgroup. QED.

</details>

The commutative property of the Abel Group can be passed down to subgroups, where left and right cosets are equal, so all subgroups are normal subgroups and quotient groups can be constructed.

**6. Quotient groups of an Abel Group are also Abel Groups.**

<details><summary>Click to expand proof👀</summary>

Let $(G, 🐔)$ be an Abel Group, and let $H$ be any subgroup of $G$. Since $H$ is a normal subgroup, we can construct the quotient group $G/H$. For any $a, b \in G$ and $h \in H$, according to the commutative property, we have $(ah) (bh) = ahbh = bhah = (bh) (ah)$. Therefore, $(aH)(bH) = (bH)(aH)$. Thus, quotient groups of an Abel Group are also Abel Groups. QED.

</details>

The commutative property of the Abel Group can be passed down to quotient groups.

## 3. Summary

In this lecture, we introduced the Abel Group, which has the commutative property, and its properties. Abel Groups are commonly used in cryptography and zero-knowledge proofs, and we will encounter them frequently in the future.
