---
title: 20. Rings
tags:
  - zk
  - abstract algebra
  - ring theory
  - ring
---

# WTF zk Tutorial Lesson 20: Rings

In abstract algebra, a ring is an algebraic structure more complex than a group. A ring comprises two binary operations, usually denoted as addition and multiplication. In this tutorial, we will introduce the definition, classification, and properties of rings.

## 1. Definition of a Ring

A group possesses one operation on a set, whereas a ring possesses two binary operations on a set. It satisfies properties similar to those of integer addition and multiplication. Elements of a ring can be numeric, such as integers or complex numbers, but they can also be non-numeric objects like polynomials, functions, and power series.

**Definition of a Ring:** A ring $(R, +, \cdot)$ consists of a non-empty set $R$ and two binary operations $+$ (addition) and $\cdot$ (multiplication), satisfying the following three properties:

1. $(R, +)$ forms an Abelian group (commutative group), i.e., it satisfies:
   - **Closure under addition:** For any $a, b \in R$, $a + b \in R$.
   - **Associativity of addition:** For any $a, b, c \in R$, $(a + b) + c = a + (b + c)$.
   - **Additive identity:** There exists an element $0 \in R$ such that for any $a \in R$, $a + 0 = 0 + a = a$.
   - **Additive inverses:** For any $a \in R$, there exists an element $-a \in R$ such that $a + (-a) = (-a) + a = 0$.
   - **Commutativity of addition:** For any $a,b \in R$, $a + b = b + a$.
2. $(R, \cdot)$ forms a monoid, i.e., it satisfies:
   - **Closure under multiplication:** For any $a, b \in R$, $a \cdot b \in R$.
   - **Associativity of multiplication:** For any $a, b, c \in R$, $(a \cdot b) \cdot c = a \cdot (b \cdot c)$.
   - **Multiplicative identity:** There exists an element $1 \in R$ such that for any $a \in R$, $a \cdot 1 = 1 \cdot a = a$.
     > Some textbooks do not require a multiplicative identity for a ring, which differs from our definition. We call structures without a multiplicative identity [rngs](<https://en.wikipedia.org/wiki/Rng_(algebra)>).
3. Multiplication distributes over addition, i.e., for any $a, b, c \in R$, we have:
   - $a \cdot (b + c) = a \cdot b + a \cdot c$
   - $(a + b) \cdot c = a \cdot c + b \cdot c$.

In summary, rings have stricter requirements for the additive group, which must form an Abelian group (four basic properties of a group + commutativity). The requirements for the multiplicative group are lower; it only needs to satisfy the three basic properties of a group, without requiring every element to have a multiplicative inverse. Additionally, both addition and multiplication must satisfy distributive properties.

> Due to rings being more specific than groups, in rings, we use addition $+$ and multiplication $\cdot$ to represent operations, rather than abstract symbols like 🐔 and 🦆; the additive identity is denoted as $0$; sometimes we may omit the multiplication symbol, writing $a \cdot b$ as $ab$.

Below are commonly used symbols in rings:

| Symbol                 | Meaning                                       |
| ---------------------- | --------------------------------------------- |
| $0$                    | Additive identity, also known as zero element |
| $-a$                   | Additive inverse of element $a$               |
| $a-b$                  | $a + (-b)$                                    |
| $1$ or $e$             | Multiplicative identity                       |
| $a^{-1}$               | Multiplicative inverse of element $a$         |
| $ab$                   | $a \cdot b$                                   |
| $\frac{a}{b}$ or $a/b$ | $a \cdot b^{-1}$                              |

## 2. Examples of Rings

Let's familiarize ourselves with rings using the examples of the ring of integers and the ring of integers modulo $n$.

### 2.1 Ring of Integers $\mathbb{Z}$

The most familiar ring is the ring of integers, which consists of the set of all integers $\mathbb{Z}$ along with integer addition and multiplication.

$$
...,-5,-4,-3,-2,-1,0,1,2,3,4,5,...
$$

We verify if it satisfies the basic properties of a ring:

1. $(\mathbb{Z}, +)$ forms an Abelian group.
2. $(\mathbb{Z}, \cdot)$ has a unit element $1$, closure, and satisfies associativity.
3. Integer addition and multiplication satisfy distributive properties.

Therefore, the ring of integers $(\mathbb{Z}, +, \cdot)$ satisfies the basic properties of a ring.

### 2.2 Ring of Integers Modulo $n$ $\mathbb{Z}_n$

The ring of integers modulo $n$ is also commonly used in cryptography. It consists of residue classes modulo $n$ along with modulo addition and multiplication.

$$
0,1,2,...,n-1
$$

We verify if it satisfies the basic properties of a ring:

1. $(\mathbb{Z}_n, +)$ forms an Abelian group.
2. $(\mathbb{Z}_n, \cdot)$ has a unit element $1$, closure, and satisfies associativity.
3. Modulo addition and multiplication satisfy distributive properties.

Therefore, the ring of integers modulo $n$ $(\mathbb{Z}_n, +, \cdot)$ satisfies the basic properties of a ring.

## 3. Classification of Rings

### 3.1 Zero Ring

If a ring $(R, +, \cdot)$ contains only one element, according to the basic properties of a ring, this element is the additive identity $0$. Such a ring is denoted as $(0, +, \cdot)$, and we call it the **zero ring**.

The zero ring is also referred to as the trivial ring, while rings other than the zero ring are called non-trivial rings.

### 3.2 Commutative Ring

If the multiplication in a ring $(R, +, \cdot)$ also satisfies the commutative property, i.e., for any $a, b \in R$, $ab = ba$, then the ring is called a **commutative ring**.

In cryptography, the rings commonly used are almost always commutative rings, such as the ring of integers $(\mathbb{Z}, +, \cdot)$ and the ring of integers modulo $n$ $(\mathbb{Z}_n, +, \cdot)$. Therefore, in this tutorial, unless otherwise specified, "ring" refers to a commutative ring.

### 3.3 Integral Domain

First, let's introduce zero divisors. For a ring $R$, if there exist non-zero elements $a, b \in R$ such that $ab = 0$, then $a$ and $b$ are called zero divisors. For example, in the ring of integers modulo $6$, we have $2 \cdot 3 \equiv 0 \pmod{6}$, so $2$ and $3$ are zero divisors in $\mathbb{Z}_6$.

If a commutative ring $R$ does not have zero divisors, then we call $R$ an integral domain. For example, $\mathbb{Z}_5$ is an integral domain, as the product of any two non-zero elements is not equal to zero.

### 3.4 Field

A field is a special type of ring. If the multiplicative group of a commutative ring $(R, +, \cdot)$ after removing the zero element $(R-\{0\}, \cdot)$ forms an Abelian group, then we call $R$ a field. For example, when we remove the zero element from $\mathbb{Z}_5$, we get $\mathbb{Z}_5^* $, and $(\mathbb{Z}_5^*, \cdot)$ satisfies the properties of an Abelian group, so $\mathbb{Z}_5$ is a field.

Fields are very important in cryptography and zero-knowledge proofs, and we will have a lecture dedicated to them later.

## 4. Basic Properties of Rings

Now, let's introduce some basic properties of rings.

**Property 1: The additive identity $0$ is unique.**

<details><summary>Proof👀</summary>

Let $0'$ be another element satisfying the properties of an additive identity. Then:

$0 + 0' = 0'$

$0 + 0' = 0$

Thus, $0 = 0'$, proving the uniqueness of the additive identity.

</details>

**Property 2: The additive inverse of an element is unique.**

<details><summary>Proof👀</summary>

For any element $a$, let $b$ and $c$ be its additive inverses. Then:

$a + b = 0$

$a + c = 0$

Subtracting the two equations yields $b - c = 0$, which implies $b = c$. Therefore, the additive inverse of $a$ is unique.

</details>

**Property 3: The multiplicative identity $1$ is unique.**

**Property 4: Property of zero multiplication:** For any element $a$, we have $a \cdot 0 = 0 \cdot a = 0$, i.e., $0$ is the absorbing element for multiplication.

<details><summary>Proof👀</summary>

For the zero element, we have $0 = 0 + 0$. Thus, for any element $a$, we have $a \cdot 0 = a \cdot (0+0) = a \cdot 0 + a \cdot 0$, subtracting both sides yields $a \cdot 0 = 0$.

$0 \cdot a = 0$ can be proved in the same way. Proof complete.

</details>

**Property 5: In a non-trivial ring, the additive identity and the multiplicative identity are distinct, i.e., $0 \neq 1$.**

<details><summary>Proof👀</summary>

Assume the additive identity and the multiplicative identity are equal. Then, for any element $a$ in the ring, we have $a = a \cdot 1 = a \cdot 0 = 0$, meaning every element equals $0$. This contradicts the definition of a non-trivial ring. Therefore, in a non-trivial ring, $0 \neq 1$. Proof complete.

</details>

**Property 6: For elements $a$ and $b$ in ring $R$, we have $(-a)b = -(ab) = a(-b)$.**

<details><summary>Proof👀</summary>

First, let's prove $(-a)b = -(ab)$, which is essentially proving that $ab$ and $(-a)b$ are inverses. By the distributive property, we have $(-a)b + ab = (-a + a)b = 0b = 0$, thus $ab$ and $(-a)b$ are inverses, which implies $(-a)b = -(ab)$.

We can use the same method to prove $ab$ and $a(-b)$ are inverses, so $-(ab) = a(-b)$.

Therefore, $(-a)b = -(ab) = a(-b)$. Proof complete.

</details>

**Property 7: For elements $a$ and $b$ in ring $R$, we have $(-a)b = -(ab) = a(-b) = - (-a)(-b)$.**

<details><summary>Proof👀</summary>

First, let's prove $(-a)b = -(ab)$. By the distributive property, we have $(-a)b + ab = (-a + a)b = 0b = 0$, thus $ab$ and $(-a)b$ are inverses, which implies $(-a)b = -(ab)$.

We can use the same method to prove $ab$ and $a(-b)$ are inverses, so $-(ab) = a(-b)$.

Next, let's prove $-(ab) = - (-a)(-b)$. By the distributive property, we have $-(ab) + (-a)(-b) = -(ab - ab) = -0 = 0$, thus $-(ab)$ and $(-a)(-b)$ are inverses, which implies $-(ab) = - (-a)(-b)$.

Therefore, $(-a)b = -(ab) = a(-b) = - (-a)(-b)$. Proof complete.

</details>

You can understand these properties using the examples of the ring of integers and the ring of integers modulo $n$.

## 5. Subrings

For a ring $(R, +, \cdot)$, if $S$ is a non-empty subset of $R$ and $S, +, \cdot$ also form a ring, then we call $S$ a **subring** of $R$.

We can determine if $S$ is a subring of $R$ using the following conditions:

1. **Closure under addition:** For any $a, b \in S$, $a+b \in S$.
2. **Preservation of zero:** The zero element of $R$ is also in $S$, i.e., $0_R = 0_S$.
3. **Existence of additive inverses:** For any $a \in S$, $-a \in S$.
4. **Closure under multiplication:** For any $a,b \in S$, $ab \in S$.
5. **Existence of (Multiplicative) identity:** $S$ has a multiplicative identity.

Or equivalently:

1. **Closure under subtraction (Condition for being a subgroup):** For any $a, b \in S$, $a+b \in S$.
2. **Closure under multiplication:** For any $a, b \in S$, $ab \in S$.
3. **Existence of (Multiplicative) identity:** $S$ has a multiplicative identity.

## 6. Conclusion

In this tutorial, we introduced the basic definition and properties of rings, as well as some examples. Rings are an important concept in abstract algebra, providing a foundation for further study.
