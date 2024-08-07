---
title: 21. Ideal and Quotient Ring
tags:
  - zk
  - abstract algebra
  - ring theory
  - ideal
  - quotient ring
---

# WTF zk Tutorial Lesson 21: Ideal and Quotient Ring

In the previous chapter, we introduced the basic concepts and properties of rings. In this chapter, we will delve into the concepts of ideal and quotient ring in a ring, which can be analogized to normal subgroups and quotient groups in group theory.

## 1. Ideal

Ideals are defined to construct quotient rings, just as normal subgroups are defined to construct quotient groups. Therefore, before introducing the concept of ideals, let's first review normal subgroups.

A quotient group is a group formed by cosets. For a group $G$ and a subgroup $H$, the operation between the cosets $aH$ and $bH$ should be well-defined. We need $(aH)(bH) = abH$, which means the subgroup $H$ satisfies $aH = Ha$. This is the definition of a normal subgroup.

In ring theory, a quotient ring is a ring formed by cosets, which includes two operations, addition and multiplication. For a ring $R$ and its ideal $I$, the operations between the cosets $aI$ and $bI$ should be well-defined:

1. Well-defined addition: $(a + I) + (b+ I) = a+b + I$

2. Well-defined multiplication: $(a + I) (b+ I) = ab + I$

Since $(R, +)$ forms an Abelian group, its subgroup $(I, +)$ is a normal subgroup, satisfying $(a + I) + (b+ I) = a +b + I + I = a+b +I$. Therefore, addition is always well-defined. To ensure that multiplication is well-defined, for any $a,b \in R$, we need $(a + I) (b+ I) = ab + aI + Ib + II = ab + I$, which means $aI$ and $bI$ are subsets of $I$. In other words, when an element in a ring is multiplied by an element in an ideal, the result still lies in the ideal.

Therefore, ideals need to satisfy the absorption law, that is, for any $r \in R$ and $i \in I$, we have $ri \in I$ (since we only study commutative rings in this tutorial, $ri \in I$ also means $ir \in I$, otherwise left and right ideals need to be defined separately).

### 1.1 Definition of Ideal

In a (commutative) ring $R$, if a subset $I$ satisfies the following properties, then $I$ is called an ideal of $R$:

1. Forms a subgroup under addition: $(I, +)$ is a subgroup of $(R, +)$.
2. Absorption law of multiplication: For any $r \in R$ and $i \in I$, we have $ri \in I$.

Sometimes, the first condition can also be replaced by the necessary and sufficient condition for a subgroup: For any $a, b \in I$, we have $a - b \in I$.

For example, for any integer $m$, $m\mathbb{Z}$ is an ideal of the ring of integers $\mathbb{Z}$. This is because:

- Addition: $(m\mathbb{Z}, +)$ is a subgroup of $(\mathbb{Z}, +)$.
- Multiplication: For any $a \in m\mathbb{Z}$ and $z \in \mathbb{Z}$, we have $az \in m\mathbb{Z}$ (az is a multiple of m), which satisfies the absorption law of multiplication.

Another example is for any integer $m$, $m\mathbb{Z}_n$ is an ideal of the ring of integers modulo n, $\mathbb{Z}_n$. This is because:

- Addition: $(m\mathbb{Z}_n, +)$ is a subgroup of $(\mathbb{Z}_n, +)$.
- Multiplication: For any $a \in m\mathbb{Z}_n$ and $z \in \mathbb{Z}_n$, let $a = mk$ (k is an integer), then we have $az = mkz = m(kz) \in m\mathbb{Z}$, which satisfies the absorption law of multiplication.

### 1.2 Properties of Ideals


**Property 1. Zero Ideal: $\{0\}$ is an ideal of any ring, called the zero ideal.** 

<details><summary>Click to expand proof</summary>

$\{0\}$ is a zero ring and satisfies the definition of a ring. $\{0\} \subseteq R$ and any element in the ring $R$ multiplied by $0$ equals $0$.

</details>

**Property 2. The ring $R$ is an ideal of itself.**

<details><summary>Click to expand proof</summary>

$R \subseteq R$. Due to closure, the product of elements in the ring $R$ still belongs to the ring $R$, so it satisfies the absorption law of multiplication and is an ideal of itself.

</details>

> $\{0\}$ and $R$ itself are also called the trivial ideals of the ring $R$; ideals other than these two are called non-trivial ideals.

**Property 3. If an ideal $I$ of the ring $R$ contains the multiplicative identity $1$, then $I = R$.**

<details><summary>Click to expand proof</summary>

Since $1 \in I$, for any $r \in R$, we have $r \cdot 1= r \in I$, so $I = R$.

</details>

**Property 4. An ideal $I$ contains the zero element $0$, but may not contain the multiplicative identity $1$, therefore it may not form a ring.**

<details><summary>Click to expand proof</summary>

$0 \in R$, and for any $i \in I$, we have $0i = 0 \in I$, so the ideal $I$ contains the zero element $0$.

For example, $m\mathbb{Z}_n$ is an ideal of the ring of integers modulo n, $\mathbb{Z}_n$, but it does not contain $1$. Therefore, ideals may not contain the multiplicative identity $1$.

Ideals satisfy all the properties of a ring except for containing the multiplicative identity, so they are rngs.

</details>

**Property 5. Principal Ideal: Given a ring $R$ and an element $a \in R$, $aR$ is an ideal. We call $aR$ the principal ideal generated by $a$, denoted as $(a)$.**

<details><summary>Click to expand proof</summary>

We verify whether $(a) = \{ra | r \in R\}$ satisfies the properties of an ideal:

1. According to the closure of multiplication in a ring, for any $r \in R$, we have $ra \in R$, so $(a) \subseteq R$. 

2. Forms a subgroup under addition: For any $ra, r'a \in (a)$, we have $ra - r'a = (r-r')a \in (a)$, so $((a), +)$ forms a subgroup of $(R, +)$.

3. Absorption law of multiplication: For any $ra \in (a)$ and $r' \in R$, we have $r'ra = (r'r)a \in (a)$, so $(a)$ satisfies the absorption law of multiplication.

Therefore, $(a)$ is an ideal of $R$.

</details>

Principal ideals are the simplest way to construct ideals. For example, given $m \in \mathbb{Z}$, $m\mathbb{Z}$ is the principal ideal generated by $m$ in the ring of integers $\mathbb{Z}$.

## 2. Quotient Ring

Similar to quotient groups, quotient rings define an equivalence relation in a ring. Let's first look at its definition:

Let $R$ be a ring and $I$ be an ideal of $R$. We call $R/I = \{a + I | a \in R\}$ the quotient ring of $R$ with respect to the ideal $I$.

According to the definition of ideals, addition and multiplication in quotient rings are well-defined.

- Addition operation: For $a,b \in R$, we have $(a + I) + (b + I) = (a + b) + I \in R/I$.

- Multiplication operation: For $a,b \in R$, we have $(a + I) \cdot (b + I) = ab + I \in R/I$.

We can easily verify that quotient rings satisfy the basic properties of rings. The zero element of the quotient ring $R/I$ is $0 + I$, and the multiplicative identity is $1 + I$.

Let's consider an example, the ring of integers $\mathbb{Z}$ and its ideal $n\mathbb{Z}$ (all multiples of $n$). The quotient ring is denoted as $\mathbb{Z}/n\mathbb{Z}$, which is also equivalent to $\mathbb{Z}_n$, the ring of residues modulo $n$. Each equivalence class consists of a set of integers that are congruent modulo $n$, with $0$ as the zero element and $1$ as the multiplicative identity.

### 2.1 Congruence Relation in Quotient Rings

Similar to quotient groups, we can define a congruence relation (equivalence relation) in the quotient ring $R/I$: For $a, b \in R$, if $a - b \in I$, we say that $a$ and $b$ are congruent modulo $I$, denoted as $a \equiv b \mod{I}$.

This means that elements in $I$ are considered equal under modulo operations. We can consider the elements in $R/I$ as equivalence classes of elements in $R$ that are equivalent under the congruence relation. These equivalence classes form the quotient ring $R/I$. For example, the equivalence class formed by the element $a$ is $[a] = \{b \in R | b \equiv a \mod{I}\} = a + I$, which represents the set of elements in $R$ that are congruent to $a$.

Taking the quotient ring $\mathbb{Z}/n\mathbb{Z}$ as an example, it consists of $\{[0], [1], ... , [n-1]\}$, where each element represents the set of integers congruent to $0, 1, ..., n-1$.

## 3. Summary

In this chapter, we introduced the concepts of ideal and quotient ring. They play a role in ring theory similar to normal subgroups and quotient groups in group theory, providing powerful tools for studying the structure of rings.