---
title: 24. Polynomial Basics
tags:
  - zk
  - abstract algebra
  - polynomials
---

# WTF zk Tutorial Lesson 24: Polynomial Basics

In this tutorial, we will learn the basics of polynomials, which are essential for studying polynomial rings. Polynomials play a crucial role in cryptography and zero-knowledge proofs.

## 1. Polynomial Basics

In algebra, a polynomial is an expression that combines variables and coefficients through addition, multiplication, and exponentiation operations using non-negative whole number exponents. An $n$-th degree polynomial $P(x)$ can be written as:

$$
P(x) = \sum_{j=0}^{n}{a_jx^j} = a_nx^n + a_{n-1}x^{n-1} + ... + a_1x + a_0
$$

Here, $a_n, a_{n-1}, \ldots, a_1, a_0$ are the coefficients of the polynomial, $x$ is the variable, and the exponent is a non-negative whole number. The coefficients can be integers, real numbers, complex numbers, or elements from other number fields. However, for simplicity, we will focus on integer coefficients for now.

Some important concepts related to polynomials are:

1. Degree: The degree of a polynomial refers to the exponent of the highest power, which is $n$ (where $a_n \neq 0$). For example, the degree of $P(x) = 3x^4 - 2x^2 + 5$ is 4. We often denote the degree of the polynomial $P(x)$ as $\deg(P)$.

2. Leading Coefficient: The coefficient $a_n$ of the term with the highest power is called the leading coefficient and is denoted as $Lc(P) = a_n$.

3. Zero Polynomial: A polynomial in which all coefficients are zero. It is represented as $P(x) = 0$.

4. Constant Polynomial (Zero-degree Polynomial): A polynomial in which all coefficients except the constant term are zero. It is represented as $P(x) = a_0$, where $a_0 \neq 0$. The zero polynomial and the constant polynomial are both examples of constant polynomials.

## 2. Polynomial Operations

Polynomial addition and multiplication follow the standard rules of algebra.

**1. Polynomial Addition:** To add two polynomials, simply add the coefficients of the corresponding terms. For two polynomials

$$
P(x) = \sum_{j=0}^{n}{a_jx^j}
$$

and

$$
Q(x) = \sum_{j=0}^{m}{b_jx^j}
$$

their sum is given by

$$
P(x) + Q(x) = \sum_{j=0}^{\max{(n,m)}}{(a_j+b_j)x^j}
$$

For example, $(3x^4 - 2x^2 + 5) + (3x^2 + x) = 3x^4 + x^2 + x + 5$.

**2. Polynomial Multiplication:** To multiply two polynomials, expand using the distributive law and then combine like terms. For two polynomials $P(x)$ and $Q(x)$, their product is given by

$$
P(x) \cdot Q(x)  = \sum_{i=0}^{n+m}\sum_{j=0}^{i}{(a_jb_{i-j})x^i}
$$

For example, $(3x^4 - 2x^2 + 5) \cdot (3x^2 + x) = 9x^6 + 3x^5 -6x^4 -2x^3 +15x^2 +5x$.

**3. Polynomial Subtraction:** The inverse operation of polynomial addition:

$$
P(x) - Q(x) = \sum_{j=0}^{\max{(n,m)}}{(a_j-b_j)x^j}
$$

For example, $(3x^4 - 2x^2 + 5) - (3x^2 + x) = 3x^4 -5 x^2 - x + 5$.

In polynomial addition and multiplication, the degrees of the resulting polynomials satisfy the following relationships:

- **Degree of the Product:** The degree of the product is equal to the sum of the degrees, i.e., $\text{deg}(P \cdot Q) = \text{deg}(P) + \text{deg}(Q)$.

- **Degree of the Sum:** The degree of the sum is less than or equal to the maximum degree of the two polynomials, i.e., $\text{deg}(P + Q) \leq \max(\text{deg}(P), \text{deg}(Q))$.

## 3. Euclidean Division of Polynomials

Similar to integers, Euclidean division is a method used to find the quotient and remainder of two polynomials. Given two polynomials $A(x)$ and $B(x)$, where $B(x)$ is not the zero polynomial, Euclidean division can be represented as:

$$
A(x) = Q(x) \cdot B(x) + R(x)
$$

Here, $Q(x)$ is the quotient polynomial, $R(x)$ is the remainder polynomial, and the degree of $R(x)$ is less than the degree of $B(x)$.

If $R(x) = 0$, we say that the polynomial $B(x)$ divides $A(x)$, denoted as $B|A$. In this case, $B$ is also called a factor of $A$, similar to the concept of factors in integers.

When calculating the Euclidean division of polynomials, the most commonly used method is polynomial long division, which is similar to long division for integers. The process of dividing $x^3 -12x -42$ by $x-3$ is shown below, with the result being $x^2 -9x -27$ with a remainder of $-123$:

![](./img/23-1.svg)

The greatest common divisor (GCD) is the highest degree factor shared by two polynomials. Using the Euclidean division, we can find the greatest common divisor of two polynomials.

## 4. Prime Factorization of Polynomials

Polynomials can be factored into the product of multiple polynomial factors, a process known as factorization, similar to the factorization of integers. Factorization helps in understanding the properties of polynomials, such as the distribution of roots.

For example, $3x^4 - 2x^2 - 5$ can be factored as $(x^2+1)(3x^2-5)$.

If a polynomial cannot be expressed as the product of lower-degree non-zero polynomials, it is called an **irreducible polynomial**, similar to the concept of prime numbers in integers. The goal of prime factorization is to decompose a polynomial $P$ into irreducible polynomials $F_1, F_2, ..., F_k$:

$$
P = F_1 \cdot F_2 \cdot ... \cdot F_k
$$

Here, $F_1, F_2, ..., F_k$ are also known as the prime factors of the polynomial $P$.

We can use the sympy package in Python to perform prime factorization:

```python
from sympy import symbols, factor

x = symbols('x')
polynomial = x**3 -4*x**2 - 11*x + 30

factored_polynomial = factor(polynomial)

print("Original Polynomial:", polynomial)
print("Prime Factorization:", factored_polynomial)

# Output
# Original Polynomial: x**3 - 10*x**2 + 31*x - 30
# Prime Factorization: (x - 5)*(x - 3)*(x - 2)
```

In this program, we factorize $x^3 -10x^2 + 31x - 30$ as $(x - 5)(x - 3)(x - 2)$.

## 5. Roots of Polynomials

The value of a polynomial $P(x)$ at $x=b$ is given by $P(b) = \sum_{j=0}^{n}{a_jb^j}$. For example, if $P(X) = x^3 -10x^2 + 31x - 30$, then $P(1) = 1 - 10 + 31 - 30 = -8$.

If $P(b) = 0$, then we say that $b$ is a root of the polynomial $P$, i.e., a root is a value of $b$ that makes $P(b) = 0$. An $n$-th degree polynomial can have at most $n$ roots.

We often use factorization to find the roots of a polynomial. For example, if we factorize $P(x)  = \sum_{j=0}^{n}{a_jx^j}$ as $(x - 5)(x - 3)(x - 2)$, then $x = 5, 3, 2$ are the roots of the polynomial $P(x)$. Finding the roots is usually a computationally difficult problem with no efficient algorithm.

## 6. Lagrange Interpolation Method

Lagrange interpolation is a method of constructing an interpolating polynomial from known points. For a given set of $n+1$ points $(x_0, y_0), (x_1, y_1), \ldots, (x_n, y_n)$, the Lagrange interpolation polynomial can be expressed as:

$$
P(x) = \sum_{i=0}^{n} y_i \cdot \prod_{j=0, j\neq i}^{n} \frac{x - x_j}{x_i - x_j}
$$

This polynomial is called the Lagrange polynomial, and it satisfies $P(x_i) = y_i$, i.e., it passes through the known points. Given $n+1$ points, there is only one Lagrange polynomial of degree at most $n$ that passes through these points.

The function $l(x) = \prod_{j=0, j\neq i}^{n} \frac{x - x_j}{x_i - x_j}$ is called the basis function. It has the property of being $1$ at $x = x_i$ and $0$ at $x = x_j$ for $j \neq i$. It can be easily verified that the value of the Lagrange polynomial at $x = x_i$ is $y_j$, where $0 \leq j \leq n$.

We can use the sympy package in Python to perform Lagrange interpolation:

```python
# Lagrange Interpolation
from sympy import symbols
from sympy.abc import x
from sympy.polys.polyfuncs import interpolating_poly

# Given interpolation points and their corresponding function values
data = [(1, 2), (2, 3), (3, 8)]

if isinstance(data[0], tuple):
    X, Y = list(zip(*data))
else:
    X = list(range(1, n + 1))
    Y = list(data)

# Use the interpolating_poly function to construct the Lagrange interpolation polynomial
interpolation_polynomial = interpolating_poly(len(data), x, X, Y)

# Output the interpolation polynomial
print("Lagrange Polynomial:", interpolation_polynomial)
print("Simplified Polynomial:", interpolation_polynomial.expand())
# Calculate the value at x=4 using the interpolation polynomial
result = interpolation_polynomial.subs(x, 3)
print("Value at x=4:", result)

# Sample Output
# Lagrange Polynomial: (x - 3)*(x - 2) - 3*(x - 3)*(x - 1) + 4*(x - 2)*(x - 1)
# Simplified Polynomial: 2*x**2 - 5*x + 5
# Value at x=4: 8
```

In the provided program, we have given 3 points $(1,2), (2,3), (3,8)$, and the Lagrange interpolation gives us the polynomial $2x^2 - 5x + 5$. You can verify if it passes through these 3 points.

## 7. Summary

Polynomial mathematics is a powerful tool in cryptography and zero-knowledge proofs. This tutorial has introduced the basic definitions, operations, prime factorization, and Lagrange interpolation method of polynomials, preparing for the study of polynomial rings.