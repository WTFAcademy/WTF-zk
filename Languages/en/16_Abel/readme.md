---
title: 16. Abelian Group
tags:
  - zk
  - abstract algebra
  - group theory
  - abelian group
---

# WTF zk Tutorial 16: Abelian Group

In this tutorial, we will introduce a type of group commonly used in cryptography: the Abelian group, which satisfies the commutative law.

## 1. Abelian Group

An Abelian group is a group that satisfies the commutative law, in addition to the four basic properties of a group. If a group $(G, 🐔)$ satisfies the following 5 properties, it is called an Abelian group:

1. **Closure**: For any $a, b \in G$, we have $a 🐔 b \in G$.
2. **Associativity**: For any $a, b, c \in G$, we have $(a 🐔 b) 🐔 c = a 🐔 (b 🐔 c)$.
3. **Identity Element**: There exists an element $e \in G$ such that for any $a \in G$, we have $a 🐔 e = e 🐔 a = a$.
4. **Inverse Element**: For any $a \in G$, there exists an element $b \in G$ such that $a 🐔 b = b 🐔 a = e$, where $e$ is the identity element.
5. **Commutative Law**: For any $a, b \in G$, we have $a 🐔 b = b 🐔 a$.

Therefore, an Abelian group is a group that satisfies the commutative law. Many common groups, such as:
1.The group of integer addition $(\mathbb{Z}, +)$,because $a + b = b+a$.

2.The group of non-zero integer multiplication $(\mathbb{Z}, \times)$, because $ab = ba$.

3.The group of integer addition modulo $n$ $(\mathbb{Z}_n, +)$,because $a + b \equiv b+a \pmod{n}$.

4.The group of integer multiplication modulo $n$ $(\mathbb{Z}_n^*, \times)$,because $ab \equiv ba \pmod{n}$.

## 2. Properties of Abelian Groups

In this section, we will discuss some properties of Abelian groups and review the concepts of subgroup, normal subgroup, quotient group, and homomorphism.

**1. A group $(G, 🐔)$ is an Abelian group if and only if for any $a,b \in G$, we have $(a🐔 b)^2 = a^2 🐔 b^2$**

<details><summary>Click to expand the proof👀</summary>

We want to prove that the group $(G, 🐔)$ satisfies the commutative law. For any $a,b \in G$, $(a 🐔 b)^2 = a 🐔 b 🐔 a 🐔 b$

And $(a 🐔 b)^2 = a^2 🐔 b^2$ can be written as $a🐔 b🐔 a🐔 b = a🐔 a🐔b🐔 b$, by canceling the leftmost $a$ and the rightmost $b$, we have $b🐔 a = a🐔 b$, thus the commutative law holds and the group $(G, 🐔)$ is an Abelian group. Proof complete.

</details>

For example, in the group $(\mathbb{Z}, \times)$, we have $(2 \times 3)^2 = 2^2 \times 3^2 = 36$.

**2. A group $(G, 🐔)$ is an Abelian group if for any $a,b \in G$, we have $(a🐔 b)^n = a^n 🐔 b^n$**

<details><summary>Click to expand the proof👀</summary>

$(G, 🐔)$ is an Abelian group, $(a🐔 b)^n = a🐔 b🐔..🐔 a🐔 b = a🐔 a\cdot...🐔 b🐔 b = a^n🐔 b^n$. Proof complete.

</details>

For example, in the group $(\mathbb{Z}, \times)$, we have $(2 \times 3)^n = 2^n \times 3^n$.

**3. Subgroups of an Abelian group are also Abelian groups.**

<details><summary>Click to expand the proof👀</summary>

Let $(G, 🐔)$ be an Abelian group, and let $H$ be a subgroup of $G$. For any $a, b \in H$, we have $a, b \in G$, thus $a 🐔 b = b 🐔 a$. Therefore, the subgroup $H$ is also an Abelian group. Proof complete.

</details>

For example, in the group $(\mathbb{Z}, +)$, the group of even numbers is a subgroup of it, and it is also an Abelian group that satisfies the commutative law.

**4. For an Abelian group $(G, 🐔)$, for any integer $n$, the group $G^n$ consisting of the $n$th powers of each element in $G$ is a subgroup of $G$, $G^n = \{a^n \mid a \in G\}$.**

<details><summary>Click to expand the proof👀</summary>

Let $(G, 🐔)$ be an Abelian group, for any $a, b \in G$, we have $a^n, b^n \in G^n$. We have $a^n (b^n)^{-1} = a^n (b^{-1})^{n} = (ab^{-1})^n$. According to the closure property, $ab^{-1} \in G$, thus $(ab^{-1})^n \in G$. Therefore, the group $G^n$ is a subgroup of $G$. Proof complete.

</details>

For example, in the group $(\mathbb{Z}, \times)$, the group consisting of the squares of all integers $\{1, 4, 9, ...\}$ is a subgroup of it. Similarly, in the group $(\mathbb{Z}_5^*, \times)$, the set of squares of all elements $(\mathbb{Z}_5^*)^2 = \{1^2, 2^2, 3^2, 4^2\} = \{1,4,4,1\} = \{1,4\}$ is a subgroup of it. This property is helpful for us to understand quadratic residues later.

**5. Subgroups of an Abelian group are normal subgroups.**

<details><summary>Click to expand the proof👀</summary>

Let $(G, 🐔)$ be an Abelian group, and let $H$ be any subgroup of $G$. For any $g \in G$ and $h \in H$, we have $hg= gh$, thus $H$ is a normal subgroup. Proof complete.

</details>

The commutative law of an Abelian group can be passed on to subgroups, and the left and right cosets are equal, so all subgroups are normal subgroups and quotient groups can be constructed.

**6. Quotient groups of an Abelian group are also Abelian groups.**

<details><summary>Click to expand the proof👀</summary>

Let $(G, 🐔)$ be an Abelian group, and let $H$ be any subgroup of $G$ that is also a normal subgroup. We can construct the quotient group $G/H$. For any $a, b \in G$ and $h \in H$, according to the commutative law, we have $(ah) (bh) = ahbh = bhah = (bh) (ah)$, thus $(aH)(bH) = (bH)(aH)$. Therefore, quotient groups of an Abelian group are also Abelian groups. Proof complete.

</details>

The commutative law of an Abelian group can be passed on to quotient groups.

## 3. Summary

In this tutorial, we introduced the Abelian group, which satisfies the commutative law, and its properties. Many commonly used groups in cryptography and zero-knowledge proofs are Abelian groups, and we will frequently encounter them in the future.