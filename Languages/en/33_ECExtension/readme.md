---
title: 33. Elliptic Curves over Extension Fields
tags:
  - zk
  - abstract algebra
  - elliptic curve
  - group theory
  - finite field
---

# WTF zk Tutorial Lesson 33: Elliptic Curves over Extension Fields

In the previous lessons, we introduced elliptic curves over finite fields $\mathbb{F}_p$. In this lesson, we will discuss elliptic curves over $\mathbb{F}_{2^k}$, including their definitions, properties, and applications in cryptography.

## 1. Elliptic Curves over $\mathbb{F}_2$

Computers perform calculations using binary, and performing modulo 2 operations is very efficient. In this section, we will explore elliptic curves over modulo 2. The finite field $\mathbb{F}_2$, also known as the binary field, is a finite field that contains two elements, usually represented as $\{0, 1\}$. In this field, addition and multiplication follow modulo 2 operations, which are:

- Addition (XOR operation): $0 + 0 = 0$, $0 + 1 = 1$, $1 + 0 = 1$, $1 + 1 = 0$.
- Multiplication: $0 \times 0 = 0$, $0 \times 1 = 0$, $1 \times 0 = 0$, $1 \times 1 = 1$.

However, if we define elliptic curves over the finite field $\mathbb{F}_2$ as $y^2 \equiv x^3 + ax + b$, there will be a problem. The discriminant of the curve, $\Delta = -16(4a^3 + 27b^2) \mod 2$, is always 0 modulo 2 regardless of the values of $a$ and $b$. This means that the elliptic curve is singular and does not have good properties.

Therefore, we need to use other forms of elliptic curves. Generally, we use Koblitz curves over modulo 2. The form of Koblitz curves is $y^2 + xy \equiv x^3 + ax + 1$, which adds an extra term $xy$ on the left side of the equation. In modulo 2, the discriminant $\Delta = 1$ is non-zero, and the curve is non-singular.

However, the elliptic curve $E(\mathbb{F}_2)$ over $\mathbb{F}_2$ only has 5 points, which is too few. We need to find other finite fields that satisfy $2 = 0$.

## 2. Elliptic Curves over $\mathbb{F}_{2^k}$

Another finite field that satisfies $2 = 0$ is $\mathbb{F}_{2^k}$ ($k$ is a positive integer). It is an extension field of $\mathbb{F}_2$, consisting of all polynomials in the polynomial ring $F[x]$ with degree less than $n$, with a total of $2^k$ elements.

$\mathbb{F}_{2^k}$ is suitable for computer operations because its elements can be naturally represented as $k$-bit binary numbers. For example, an element of the finite field $F_{2^4}$, $t^3 + t^2 + t + 1$, can be represented as $1111$. Addition and multiplication operations on $F_{2^k}$ are simply addition and multiplication operations on polynomials modulo 2.

Elliptic curves over the finite field $\mathbb{F}_{2^k}$ can be represented by the following equation:

$$
y^2 + xy = x^3 + ax^2 + 1
$$

where $a, b$ are elements in the field $F_{2^k}$, and the curve is non-singular. The coordinates of points $(x, y)$ on the curve also belong to $F_{2^k}$.

## 2.1 Point Operations

Points on Koblitz curves also form a group and satisfy the following rules:

1. Inverse: The inverse of a point $P(x, y)$ is $-P(x, -y-x)$.

2. Identity element: The identity element is the point at infinity, denoted as $O$.

3. Point addition formula: For points $P(x_1, y_1)$ and $Q(x_2, y_2)$ on the elliptic curve, let $Q(x_3, y_3) = P + Q$, then $x_3 = \lambda^2 + \lambda -a -x_1 - x_2$ and $y_3 =  \lambda(x_1-x_3) - y_1 - x_3$, where $\lambda = \frac{y_2 - y_1}{x_2 - x_1}$.

4. Point doubling formula: $x(2P) = \lambda^2 + \lambda -a - 2x - x$ and $y(2P)= \lambda(x-x(2P)) - y - x(2P)$, where $\lambda = \frac{3x^2 + 2ax - y}{x+2y}$.

The algebraic formulas for point operations on Koblitz curves are more complex than those on standard Weierstrass curves. 

## 3. Frobenius Map

The Frobenius map can accelerate point operations on elliptic curves $E(\mathbb{F}_{2^k})$. In this section, we will introduce it.

### 3.1 Frobenius Endomorphism

In abstract algebra, the Frobenius endomorphism is a special endomorphism of an Abel ring $R_p$ with characteristic $p$. Its homomorphism (Frobenius map) $\tau$ maps each element in the ring to its $p$-th power:

$$
\tau: x \to x^p
$$

For $\alpha , \beta \in R_p$, the following properties hold:

**Property 1. Additive Homomorphism:** $\tau(\alpha + \beta) = \tau(\alpha) + \tau(\beta)$

**Property 2. Multiplicative Homomorphism:** $\tau(\alpha \cdot \beta) = \tau(\alpha) \cdot \tau(\beta)$

**Property 3. Iterative Property:** Frobenius map can be applied iteratively, resulting in $\tau^n(a) = a^{p^n}$.

**Property 4. Identity Map over Finite Field $F_p$:** When $p$ is a prime number, the Frobenius endomorphism is the identity map over $F_p$, i.e., for any $\alpha \in F_p$, we have $\tau(\alpha) = \alpha^p = \alpha$.

The Frobenius endomorphism over the finite field $F_{p^k}$ has more interesting properties: the characteristic of $F_{p^k}$ is also $p$, and the Frobenius endomorphism is not an identity map.

### 3.2 Frobenius Map on Elliptic Curves

For an elliptic curve $E(\mathbb{F}_{2^k})$ defined over the field $\mathbb{F}_{2^k}$, the Frobenius map can be used to efficiently compute point doubling and scalar multiplication.

Consider an elliptic curve $E$ defined over the extension field $\mathbb{F}_{2^k}$. For simplicity, let the equation be $y^2 + xy = x^3 + ax^2 + 1$. On such a curve, the Frobenius map $\tau$ acts on a point $P = (x, y)$ as follows:

$$
\tau(P) = \phi(x, y) = (x^2, y^2)
$$

Since the characteristic of the field is 2, the Frobenius map simplifies to squaring the coordinates. It has the following properties:

**Property 5. Closure on the Elliptic Curve:** Let $P \in E(\mathbb{F}_{2^k})$, then the Frobenius map of $P$, denoted as $\tau(P)$, is also in $E(\mathbb{F}_{2^k})$.

**Property 6. Preservation of Point Addition on the Elliptic Curve:** Let $P, Q \in E(\mathbb{F}_{2^k})$, then $\tau(P + Q) = \tau(P) + \tau(Q)$.

**Property 7. Fast Doubling Algorithm:** For a point $P$ on the elliptic curve $E(\mathbb{F}_{2^k})$, we have $\tau^2(P) + \tau(P) + 2P = O$, where $\tau^2(P) = \tau(\tau(P))$.

The Frobenius map offers efficient methods for point doubling and scalar multiplication on elliptic curves defined over extension fields.

## 4. Summary

In this lesson, we introduced elliptic curves over finite fields $\mathbb{F}_{2^k}$, which can be efficiently computed in hardware. We also introduced Koblitz curves and the Frobenius map.