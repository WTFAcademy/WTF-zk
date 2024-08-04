---
title: 23. Field
tags:
  - zk
  - abstract algebra
  - field theory
  - field
---

# WTF zk Tutorial Lesson 23: Field

In this tutorial, we will introduce fields, which are a special type of ring that supports addition, subtraction, multiplication, and division operations. Fields play a crucial role in various cryptographic protocols.

## 1. Field

In the previous tutorials, we learned about groups and rings. Let's compare fields with these two concepts:

- Group: Supports addition and subtraction (the inverse operation of addition).

- Ring: Supports addition, subtraction, and multiplication.

- Field: Supports addition, subtraction, multiplication, and division (the inverse operation of multiplication).

A field $F$ is defined as a commutative ring where the set of non-zero elements $F-\{0\}$ forms an abelian group under multiplication. In other words, a field $(F, +, \cdot)$ satisfies the following properties:

1. The set $F$ and the addition operation $(F, +)$ form an abelian group.

2. The set $F$ without the zero element and the multiplication operation $(F-\{0\}, \cdot)$ form an abelian group.

3. Addition and multiplication satisfy the distributive law: for any $a, b, c \in F$, we have

    - $a \cdot (b + c) = a \cdot b + a \cdot c$
    - $(a + b) \cdot c = a \cdot c + b \cdot c$.

In other words, compared to a commutative ring, a field requires that every non-zero element $a \in F$ has a multiplicative inverse $a^{-1}$, which can also be denoted as $\frac{1}{a}$.

Common examples of fields include the field of rational numbers $\mathbb{Q}$, the field of real numbers $\mathbb{R}$, and the integer modulo $p$ field $Z_p$ (where $p$ is a prime number).

The ring of integers $\mathbb{Z}$ cannot form a field because, except for $1$ and $-1$, no other elements have a multiplicative inverse. For example, $2 \cdot \frac{1}{2} = 1$, but $\frac{1}{2}$ is not an integer.

When $n$ is a composite number, the integer modulo $n$ ring $Z_n$ cannot form a field because elements that are not coprime with $n$ do not have inverses. For example, the elements $2$ and $3$ in $Z_6$ do not have inverses, so they cannot form a field. However, when $n$ is a prime number, the integer modulo $n$ ring $Z_n$ does form a field. For example, $Z_5$ can form a field.

## 2. Properties of Fields

In addition to having all the properties of rings, fields also have some special properties.

**Property 1:** Every field $F$ has at least $2$ elements, namely the additive identity (zero element) $0$ and the multiplicative identity $1$.

<details><summary>Click to expand proof👀</summary>

By definition, fields have $0$ and $1$, and we need to prove that $0 \neq 1$. If $0 = 1$, then $F - \{0\}$ is an empty set, which cannot form a multiplicative group. Therefore, $0 \neq 1$, and every field $F$ has at least $2$ elements. Proof completed.

</details>

**Property 2:** For elements $a, b$ from a field $F$, and if neither $a$ nor $b$ is the zero element, then

$$
\frac{1}{a \cdot b} = \frac{1}{a} \cdot \frac{1}{b}
$$

<details><summary>Click to expand proof👀</summary>

To prove this proposition, we need to show that $a \cdot b$ and $\frac{1}{a} \cdot \frac{1}{b}$ are inverses of each other. According to the commutative law of multiplication, we have $a b \cdot \frac{1}{a} \cdot \frac{1}{b} = a \cdot \frac{1}{a} \cdot b \cdot \frac{1}{b} = 1 \cdot 1 = 1$. Therefore, $a \cdot b$ and $\frac{1}{a} \cdot \frac{1}{b}$ are inverses of each other. Proof completed.

</details>

**Property 3: Field has no zero divisors (Field is an integral domain):** If $a, b \in F$ and $ab = 0$, then either $a = 0$ or $b = 0$.

<details><summary>Click to expand proof👀</summary>

To prove this proposition, we assume that $a, b \in F$ and $ab = 0$. We need to show that either $a = 0$ or $b = 0$.

Suppose $a \neq 0$. Since $a$ is non-zero, it has a multiplicative inverse $a^{-1}$. Multiply both sides of the equation $ab = 0$ by $a^{-1}$ to get $a^{-1}(ab) = a^{-1} \cdot 0$. By the associative law of multiplication, we have $(a^{-1}a)b = 0$. Using the fact that $a^{-1}a = 1$, we have $1b = 0$. This implies that $b = 0$. 

Similarly, if $b \neq 0$, we can multiply both sides of the equation $ab = 0$ by $b^{-1}$ to obtain $a(b^{-1}b) = 0$. Using the fact that $b^{-1}b = 1$, we have $a1 = 0$, which implies that $a = 0$.

Therefore, either $a = 0$ or $b = 0$. Proof completed.

</details>

**Property 4: Characteristic of a Field:** If there exists a positive integer $n$ such that $0 = n \cdot 1 = 1 + 1 + ... + 1$ (with $n$ ones), then the smallest such $n$ is called the **characteristic** of the field. The characteristic of a field is either a prime number $p$ or $0$ (which means such an $n$ does not exist).

<details><summary>Click to expand proof👀</summary>

Assume that $n$ is a composite number, so there exist $a, b \in F$ such that $n = ab$. According to the definition of characteristic, we have $n \cdot 1 = 0$, which means $ab \cdot 1 = 0$. Therefore, we have $ab = 0$. According to Property 3 (field has no zero divisors), we have $a = 0$ or $b = 0$. This implies $n = ab = 0$, which contradicts the assumption. Therefore, $n$ cannot be a composite number.

When $n$ is a prime number $p$, the characteristic is $p$, such as $Z_5$.

For infinite fields, such as the field of rational numbers $R$, the characteristic does not exist, and $n = 0$.

</details>

**Property 5:** A commutative ring is a field if and only if it has only itself and the zero ideal.

<details><summary>Click to expand proof👀</summary>

**Sufficiency**

Let $R$ be a field and $I$ be an ideal of $R$, where $I$ is not equal to $\{0\}$. We need to prove that $I = R$.

First, we prove that the multiplicative identity $1$ of the field is in $I$. Since $I \neq \{0\}$, there exists an element $a \in I$ such that $a \neq 0$. Its inverse $a^{-1}$ exists and is in the field $R$. According to the absorption law of ideals, we have $aa^{-1} = 1 \in I$. Therefore, $1 \in I$.

Next, for any $b \in R$, according to the absorption law, we have $1 \cdot b = b \in I$, which means $R \subseteq I$. According to the definition of ideals, we have $I \subseteq R$. Therefore, $I = R$. Proof completed.

**Necessity**

Let $R$ be a commutative ring, and for every non-zero ideal $I$ of $R$, we have $I = R$. Consider a non-zero element $a$ in $R$. We will prove that there exists $a^{-1} \in R$ such that $a \cdot a^{-1} = a^{-1} \cdot a = 1$.

For any element $a$ in $R$, we consider the principal ideal generated by $a$: $I = (a) = \{ra \mid r \in R\}$. Since $I$ is not the zero ideal and $I = R$, there exists $b \in R$ such that $ab = 1$, which means $a^{-1} = b \in R$. Therefore, any element in the commutative ring $R$ has an inverse, and $R$ is a field. Proof completed.

</details>

## 3. Subfields

For a field $F$ and a subset $K$, if $K \subseteq F$ and $K$ forms a field with the addition and multiplication operations inherited from $F$, then we call $K$ a **subfield** of $F$, and $F$ is an **extension field** of $K$.

This condition is equivalent to:

1. $K \subseteq F$
2. $1_K = 1_F$
3. $K$ is closed under addition and multiplication operations in the field $F$.
4. Elements in $K$ have additive and multiplicative inverses.

For example, the field of rational numbers $\mathbb{Q}$ is a subfield of the field of real numbers $\mathbb{R}$, and they share the same zero element $0$ and multiplicative identity $1$.

Here are a few counterexamples: the set of integers is not a subfield of the field of real numbers $\mathbb{R}$. Although the set of integers is a subset of the real numbers, it cannot form a field. Similarly, the integer modulo $2$ field $Z_2$ is not a subfield of the integer modulo $5$ field $Z_5$. Although $Z_2 \subseteq Z_5$, their operations are addition and multiplication modulo $2$ and modulo $5$, respectively, and $Z_2$ is not closed under the addition operation modulo $5$, such as $1+1 \equiv 2 \pmod{5} \notin Z_2$.

In the upcoming tutorials, we will delve deeper into the concept of extension fields.

## 4. Summary

In this tutorial, we introduced fields and their properties. Fields are a special type of ring that support addition, subtraction, multiplication, and division operations. Many cryptographic and zero-knowledge proof algorithms are built upon fields.