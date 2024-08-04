---
title: 25. Polynomial Ring
tags:
  - zk
  - abstract algebra
  - polynomials
  - polynomial ring
---

# WTF zk Tutorial Lesson 25: Polynomial Ring

The polynomial ring is an important algebraic structure in abstract algebra that has extensive applications in cryptography and zero-knowledge proofs. In this chapter, we will introduce the definition, properties, and basic operations of the polynomial ring.

## 1. Polynomial Ring

In the previous chapter, we learned about polynomials, which involve addition and multiplication operations. However, since a group only has one operation, it is not suitable for studying polynomials. On the other hand, a ring encompasses both addition and multiplication, making it well-suited for combining with polynomials.

A polynomial ring is a ring that consists of a collection of polynomials with coefficients from a base ring. A polynomial is defined as:

$$
P(x) = \sum_{j=0}^{n}{a_jx^j} = a_nx^n + a_{n-1}x^{n-1} + \ldots + a_1x + a_0
$$

where $a_j$ are coefficients from the base ring $R$, $n$ is the degree of the polynomial, and $x$ is the variable. The base ring $R$ is called the base ring of $R[x]$.

The addition and multiplication operations in the polynomial ring are the same as those between polynomials. For example, for two polynomials $P(x) = \sum_{j=0}^{n}{a_jx^j}$ and $Q(x) = \sum_{j=0}^{m}{b_jx^j}$, the addition and multiplication operations are defined as follows:

**Polynomial addition:**

$$
P(x) + Q(x) = \sum_{j=0}^{n}{a_jx^j} + \sum_{j=0}^{m}{b_jx^j} = \sum_{j=0}^{\max{(n,m)}}{(a_j+b_j)x^j}
$$

**Polynomial multiplication:**

$$
P(x) \cdot Q(x)  = (\sum_{j=0}^{n}{a_jx^j}) \cdot (\sum_{j=0}^{m}{b_jx^j}) = \sum_{i=0}^{n+m}\sum_{j=0}^{i}{(a_jb_{i-j})x^i}
$$

Since $a_j, b_j \in R$, it can be easily verified that $(a_j+b_j), \sum_{j=0}^{i}{(a_jb_{i-j})} \in R$. Therefore, the set $R[x]$ together with the addition and multiplication operations form a ring.

## 2. Examples of Polynomial Rings

### Polynomial Ring over the Ring of Integers $\mathbb{Z}[x]$

When the base ring $R$ is the ring of integers $\mathbb{Z}$, the polynomial ring $\mathbb{Z}[x]$ consists of polynomials with integer coefficients. For example, the polynomial $f(x) = 2x^2 - 3x + 1$ is an element of $\mathbb{Z}[x]$.

### Polynomial Ring over a Finite Field $\mathbb{Z}_2[x]$

When the base ring $R$ is the ring of integers modulo 2 $\mathbb{Z}_2$ (where the coefficients can only be 0 or 1), the polynomial ring $\mathbb{Z}_2[x]$ consists of polynomials over the binary finite field. For example, the polynomial $g(x) = x^3 + x + 1$ is an element of $\mathbb{Z}_2[x]$.

## 3. Properties of Polynomial Rings

**Property 1:** If the base ring $R$ is a commutative ring, then the polynomial ring $R[x]$ is also a commutative ring.

**Property 2:** If the base ring $R$ is an integral domain, then the polynomial ring $R[x]$ is also an integral domain.

**Property 3:** If the base ring $R$ is a field, then the polynomial ring $R[x]$ is an integral domain, but not necessarily a field.

## 4. Polynomials over a Field

Although the polynomial ring $R[x]$ is not necessarily a field when $R$ is a field, it shares many similarities with the ring of integers $Z$ due to the fact that $R$ supports division (multiplicative inverse), similar to integers.

Before discussing the properties of polynomials over a field, let's introduce the concept of **monic polynomials**: A polynomial $P(x) \in R[x]$ is called monic if its leading coefficient is 1. For example, $x^2 + x + 3$ is a monic polynomial.

**Property 4:** For the polynomial ring $F[x]$ over a field $F$, let $P(x) \in F[x]$ have a leading coefficient $a_n$. Then $Q(x) = a_n^{-1} P(x)$ is a monic polynomial, and they have the same degree $\text{deg}(P(x)) = \text{deg}(Q(x))$.

**Property 5: Euclidean Division of Polynomials over a Field** For the polynomial ring $F[x]$ over a field $F$, let $P(x), G(x) \in F[x]$, where $G(x)$ is not the zero polynomial. Then there exist unique $Q(x), R(x) \in F[x]$ such that

$$
P(x) = Q(x)G(x) + R(x)
$$

where $0 \leq \text{deg}(R(x)) < \text{deg}(G(x))$.

**Property 6: The Properties of Irreducible Polynomials over $F$ Depend on $F$.** Irreducible polynomials in the polynomial ring over a field play a similar role to prime numbers in integers.

**Property 7: Unique Factorization** Non-zero polynomials in the polynomial ring $F[x]$ over a field can be uniquely factored into a product of irreducible polynomials.

**Property 8: Existence of Greatest Common Divisor** For the polynomial ring $F[x]$ over a field, let $P(x), G(x) \in F[x]$ be non-zero polynomials. Their greatest common divisor $\gcd{P(x), G(x)}$ is defined as the polynomial of highest degree that divides both $P(x)$ and $G(x)$.

**Property 9: Existence of Least Common Multiple** For the polynomial ring $F[x]$ over a field, let $P(x), G(x) \in F[x]$ be non-zero polynomials. Their least common multiple $\text{lcm}(P(x), G(x))$ is defined as the polynomial of lowest degree that is divisible by both $P(x)$ and $G(x)$.

## 5. Code Example

We can use the `sympy` package in Python to perform operations on polynomial rings. Here is an example:

```python
from sympy import symbols, Poly, GF, gcd

# Define symbolic variables
x = symbols('x')

# Define polynomials with coefficients in the ring of integers modulo 5
p1 = Poly(2*x**3 + 3*x**2 + x + 1, x, domain=GF(5))
p2 = Poly(x**2 + 4*x + 4, x, domain=GF(5))

# Print the polynomials
print("Polynomial p1:", p1)
print("Polynomial p2:", p2)


# Polynomial addition
add_result = p1 + p2
print("Addition result:", add_result)

# Polynomial subtraction
sub_result = p1 - p2
print("Subtraction result:", sub_result)

# Polynomial multiplication
mul_result = p1 * p2
print("Multiplication result:", mul_result)

# Note: In the ring of integers modulo n, polynomial division is not always possible
# However, modulo operation can be performed
mod_result = p1 % p2
print("Modulo operation:", mod_result)

# Quotient
quotient_result = p1 // p2
print("Quotient:", quotient_result)

# Greatest common divisor
gcd_result = gcd(p1, p2)
print("Greatest common divisor:", gcd_result)

# Substituting values to solve
value_result = p1.subs(x, 2)
print("Result of substituting x = 2 into polynomial p1:", value_result)

## Output Example
# Polynomial p1: Poly(2*x**3 - 2*x**2 + x + 1, x, modulus=5)
# Polynomial p2: Poly(x**2 - x - 1, x, modulus=5)
# Addition result: Poly(2*x**3 - x**2, x, modulus=5)
# Subtraction result: Poly(2*x**3 + 2*x**2 + 2*x + 2, x, modulus=5)
# Multiplication result: Poly(2*x**5 + x**4 + x**3 + 2*x**2 - 2*x - 1, x, modulus=5)
# Modulo operation: Poly(-2*x + 1, x, modulus=5)
# Quotient: Poly(2*x, x, modulus=5)
# Greatest common divisor: Poly(x + 2, x, modulus=5)
# Result of substituting x = 2 into polynomial p1: 1
```

## 6. Summary

In this chapter, we introduced the definition, properties, and polynomial rings over a field. Polynomial rings over a field are frequently used in cryptography and zero-knowledge proofs. They share many similarities with integers, supporting Euclidean division, having irreducible polynomials similar to prime numbers, unique factorization, and the existence of greatest common divisor and least common multiple.