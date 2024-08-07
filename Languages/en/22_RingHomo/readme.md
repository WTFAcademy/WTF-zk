---
title: 22. Homomorphism and Isomorphism of Rings
tags:
  - zk
  - abstract algebra
  - ring theory
  - homomorphism
  - isomorphism
---

# WTF zk Tutorial Lesson 22: Homomorphism and Isomorphism of Rings

In the previous chapters, we learned about the basic definitions and properties of rings, as well as the concepts of ideals and quotient rings. In this chapter, we will introduce the concepts of ring homomorphisms and isomorphisms, which are similar to group homomorphisms/isomorphisms and help us understand the structure and relationships between rings.

## 1. Ring Homomorphism

A ring homomorphism is a mapping between two rings that preserves the ring structure, similar to a group homomorphism. Let $(R, +, \cdot)$ and $(S, \oplus, \odot)$ be two rings, with zero elements $0_R$ and $0_S$, and multiplicative identities $1_R$ and $1_S$, respectively. A mapping $f: R \rightarrow S$ is called a homomorphism from $R$ to $S$ if it satisfies the following conditions:

1. Additive Homomorphism: For any $a, b \in R$, we have $f(a + b) = f(a) \oplus f(b)$. This property is similar to that of a group homomorphism.

2. Multiplicative Homomorphism: For any $a, b \in R$, we have $f(a \cdot b) = f(a) \odot f(b)$.

3. Preservation of Multiplicative Identity: $f(1_R) = 1_S$.

The set of elements in $R$ that map to the zero element in $S$ is called the kernel of the homomorphism, denoted as $\text{Ker}(f) = \{ a \in R \mid f(a) = 0_S \}$. The set of images of elements in $R$ in the ring $S$ is called the image of the homomorphism, denoted as $\text{Im}(f) = \{ f(a) \mid a \in R \}$.

### 1.1 Properties of Ring Homomorphisms

**Property 1. Preservation of Additive Identity: $f(0_R) = 0_S$** 

<details><summary>Proof</summary>

For any $a \in R$, according to the additive homomorphism, we have $f(a) = f(a + 0_R) = f(a) \oplus f(0_R)$. Therefore, $f(0_R) = 0_S$. Proof complete.

</details>

**Property 2. Preservation of Additive Inverse: $f(-a) = - f(a)$** 

<details><summary>Proof</summary>

For any $a \in R$, according to the additive homomorphism, we have $0_S = f(0_R) = f(-a + a) = f(-a)  \oplus f(a)$. Therefore, $f(a)$ and $f(-a)$ are additive inverses of each other, i.e., $f(-a) = - f(a)$. Proof complete.

</details>

**Property 3. Preservation of Units (Multiplicative Inverses): If $a^{-1}$ exists, then $f(a)^{-1}$ also exists and $f(a^{-1}) = f(a)^{-1}$.** 

<details><summary>Proof</summary>

For any $a \in R$, according to the multiplicative homomorphism, we have $f(a^{-1}) \odot f(a) = f(a^{-1}a) = f(1_R) = 1_S$. Therefore, $f(a)$ and $f(a^{-1})$ are multiplicative inverses of each other, i.e., $f(a^{-1}) = f(a)^{-1}$. Proof complete.

</details>

**Property 4. Preservation of Ideals: If $I$ is an ideal of $R$, then $f(I)$ is an ideal of $S$.** 

<details><summary>Proof</summary>

**Additive Subgroup**

For any $a, b \in I$, we have $f(a), f(b) \in f(I)$. According to the additive homomorphism, we have $f(a) - f(b) = f(a - b) \in f(I)$. Therefore, $f(I)$ is an additive subgroup of $S$.

**Multiplicative Absorption Property**

For any $a \in I$ and $b \in R$, according to the absorption property, we have $ab = a'$, where $a' \in I$. Therefore, for any $f(a) \in f(I)$ and $f(b) \in S$, according to the multiplicative homomorphism, we have $f(a)f(b) = f(ab) = f(a') \in f(I)$. Therefore, $f(I)$ satisfies the multiplicative absorption property.

Therefore, $f(I)$ is an ideal of $S$. Proof complete.

</details>

**Property 5. The Kernel of a Homomorphism $\text{Ker}(f)$ is an Ideal of $R$.** 

<details><summary>Proof</summary>

**Additive Subgroup**

For any $a, b \in \text{ker}(f)$, we have $f(a) = f(b) = 0_S$. Let's consider $a - b$, we have $f(a - b) = f(a) - f(b) = 0_S - 0_S = 0_S$. Therefore, $a - b \in \text{ker}(f)$. The kernel of a homomorphism $\text{Ker}(f)$ is an additive subgroup of $R$.

**Multiplicative Absorption Property**

For any $r \in R$ and $a \in \text{ker}(f)$, i.e., $f(a) = 0_S$. Let's consider $ra$, we have $f(ra) = f(r)f(a) = f(r) \cdot 0_S = 0_S$. Therefore, $ra$ belongs to $\text{ker}(f)$ and satisfies the multiplicative absorption property.

Therefore, the kernel of a homomorphism $\text{Ker}(f)$ is an ideal of $R$. Proof complete.

</details>

**Property 6. The Image of a Homomorphism $\text{Im}(f)$ is an Ideal of $S$.** 

<details><summary>Proof</summary>

According to the definition $\text{Im}(f) = f(R)$, and since the ring $R$ is a trivial ideal of itself, according to the preservation of ideals, the image of a homomorphism $\text{Im}(f) = f(R)$ is an ideal of the ring $S$. Proof complete.

</details>

### 1.2 Examples of Ring Homomorphisms

Consider two rings $R$ and $S$, where $R = \mathbb{Z}$ (the ring of integers) and $S = \mathbb{Z}_n$ (the ring of integers modulo $n$). Define a mapping $f: \mathbb{Z} \rightarrow \mathbb{Z}_n$ that calculates the remainder of an integer modulo $n$:

$$
f(a) = a \mod n
$$

This is a ring homomorphism, as it preserves the addition and multiplication of integers:

1. Additive Homomorphism: For any integers $a, b$, we have $f(a + b) = (a + b) \mod n = (a \mod n + b \mod n) \mod n = f(a) + f(b)$.

2. Multiplicative Homomorphism: For any integers $a, b$, we have $f(ab) = (ab) \mod n = (a \mod n)( b \mod n) \mod n = f(a)f(b)$.

3. Preservation of Multiplicative Identity: Both $R$ and $S$ have a multiplicative identity of $1$, and $1 = 1 \pmod n$.

## 2. Ring Isomorphism

Ring isomorphism is a concept similar to group isomorphism. If a ring homomorphism $f: R \rightarrow S$ is both injective and surjective, we say that $R$ and $S$ are isomorphic, denoted as $R \cong S$. This means that they have the same structure, and each element corresponds to one another, just with different names.

## 2.1 First Isomorphism Theorem

We introduced the First Isomorphism Theorem in group theory, which connects groups, subgroups, cosets, quotient groups, homomorphisms, and isomorphisms. This theorem can be extended to rings.

**First Isomorphism Theorem (Ring Theory):** If there are two rings $R$ and $S$ with a ring homomorphism $f: R \rightarrow S$, then we can construct a ring isomorphism $R/\text{Ker}(f) \cong \text{Im}(f)$, i.e., the quotient group of $R$ modulo the kernel of the homomorphism is isomorphic to the image of the homomorphism. The isomorphism mapping is given by $\hat{f}(x + \text{Ker}(f)) = f(x)$.

### 2.2 Examples of Ring Isomorphisms

Using the previous example: the ring of integers $\mathbb{Z}$ and the ring of integers modulo $n$ $\mathbb{Z}_n$, there exists a homomorphism $f(a) = a \mod n$, where the kernel of the homomorphism is $n\mathbb{Z}$ and the image of the homomorphism is $\mathbb{Z}_n$.

Therefore, we can construct an isomorphism between $\mathbb{Z}/ n\mathbb{Z}$ and $\mathbb{Z}_n$ as $\hat{f}(a + n\mathbb{Z}) = f(a)$. In fact, $\mathbb{Z}/ n\mathbb{Z}$ and $\mathbb{Z}_n$ represent the same ring and are often used interchangeably in different contexts.

## 3. Ring Endomorphisms and Automorphisms

Ring endomorphisms are mappings from a ring $R$ to itself that preserve the ring structure. If a mapping $f: R \rightarrow R$ satisfies the following conditions:

1. **Additive Endomorphism:** For any $a, b \in R$, we have $f(a + b) = f(a) + f(b)$.

2. **Multiplicative Endomorphism:** For any $a, b \in R$, we have $f(a \cdot b) = f(a) \cdot f(b)$.

3. **Preservation of Multiplicative Identity:** $f(1_R) = 1_R$.

Then $f$ is called an endomorphism of the ring $R$. Ring endomorphisms are useful in studying the internal structure and properties of rings.

### 3.1 Ring Automorphisms

Ring automorphisms are a special case of ring endomorphisms, where the mapping $f$ is not only a homomorphism but also a bijection (i.e., one-to-one and onto). If the mapping $f$ from a ring $R$ to itself is an endomorphism and a bijection, then we call $f$ an automorphism of the ring $R$.

Ring automorphisms imply that the ring $R$ can be mapped to itself in a way that preserves all its algebraic structures. This demonstrates a kind of symmetry or stability of the internal structure of the ring. For example, the rotational symmetry of complex number multiplication can be described using automorphisms.

### 3.2 Properties of Ring Endomorphisms and Automorphisms

Ring endomorphisms and automorphisms inherit all properties of ring homomorphisms and have some unique properties:

- **Identity Mapping:** Every ring $R$ has an endomorphism, namely the identity mapping $id: R \rightarrow R$, where $id(a) = a$ for all $a \in R$.

- **Existence of Inverses:** If $f$ is an automorphism of a ring, then its inverse mapping $f^{-1}$ is also an automorphism of the ring. This means that automorphisms are reversible, and the inverse mapping also preserves the ring structure.

- **Closure under Composition:** The set of all automorphisms of a ring $R$ is closed under composition of mappings. That is, if $f$ and $g$ are automorphisms of $R$, then $f \circ g$ (apply $g$ first, then apply $f$) is also an automorphism of $R$.

### 3.3 Examples of Ring Automorphisms

Consider the ring of integers $\mathbb{Z}$. The only nontrivial automorphism of $\mathbb{Z}$ is the identity mapping $id$, because the addition and multiplication structures of the ring of integers are very strict, and no other mapping can preserve this structure.

On the other hand, the ring of complex numbers $\mathbb{C}$ has nontrivial automorphisms. For example, the rotational symmetry around the origin can be described as an automorphism of $\mathbb{C}$, which is achieved by multiplying by a unit complex number (e.g., $e^{i\theta}$), where $\theta$ is the angle of rotation.

## 4. Summary

In this chapter, we introduced the concepts of ring homomorphisms and isomorphisms. Ring homomorphisms provide a way to preserve the structure of rings, while ring isomorphisms indicate that two rings have the same structure, with elements corresponding to each other, just with different names.