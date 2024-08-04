---
title: 26. Field Extension
tags:
  - zk
  - abstract algebra
  - field
  - field extension
---

# WTF zk Tutorial Lesson 26: Field Extension

In this chapter, we will introduce the concept of field extension, which involves extending and enlarging fields.

## 1. Field Extension

In the context of abstract algebra, a field extension refers to the extension of one field by another field. If a field $F$ is a subfield of another field $K$, we say that $K$ is an extension field of $F$. This is denoted as $F \subseteq K$. The field $F$ is referred to as the base field, and $K/F$ represents the field extension (note that this notation should not be confused with quotient groups).

For example, the rational number field $\mathbb{Q}$ is a subfield of the real number field $\mathbb{R}$, so $\mathbb{R}$ is an extension field of $\mathbb{Q}$.

There are several important concepts related to field extension:

- **Proper Subfield:** If a field $F$ is a subfield of another field $K$, and $F$ is not equal to $K$, then $F$ is called a proper subfield of $K$.

- **Prime Subfield:** A field that does not have any proper subfields is called a prime subfield.

## 2. Algebraic Extension

Algebraic extension is a commonly used method of field extension that involves polynomials.

In a field extension $K/F$, where $K$ is an extension field of $F$, if every element $a \in K$ satisfies a non-zero polynomial $f(x) \in F[x]$ such that $f(a) = 0$, then we say that $K/F$ is an algebraic extension.

We can construct an extension field $K$ from a smaller field $F$ (taking the rational number field $\mathbb{Q}$ as an example) using algebraic extension:

1. Choose a polynomial $P(x)$ from the polynomial ring $F[x]$, such as $P(x) = x^2 - 2 = 0$.

2. Find a root of the polynomial $P(x)$, which is also called an **algebraic element**. For example, $\sqrt{2}$ is a root of $P(x) = x^2 - 2 = 0$, and it does not belong to $\mathbb{Q}$.

3. Add this root to $F$ to form the extension field $K$. In the example above, the extension field $K$ contains all elements of the form $a + b\sqrt{2}$, where $a, b \in \mathbb{Q}$.

4. It can be easily proved that the extension field $K$ is a field and contains all elements of $F$. For example, the elements in the extension field $\{a + b\sqrt{2}\}$ are closed under addition and multiplication, and since $a,b \in \mathbb{Q}$, the extension field contains all rational numbers.

Why is this constructed field an algebraic extension?

Assuming the algebraic element is $\alpha$, which is a root of the polynomial $P(x) = 0$, the elements in the extension field $K$ can be represented as $a + b\alpha$, where $\alpha$ is a root of the polynomial $P(\frac{x-a}{b})$. Therefore, the constructed extension field satisfies the definition of an algebraic extension.

### 2.1 Code Example

In Python, we can construct an algebraic extension using sympy:

```python
from sympy import symbols, QQ, RootOf

# Define symbolic variables
x = symbols('x')

# Construct the algebraic extension QQ/(sqrt(2)) (which is a root of x^2 - 2 = 0) over the rational number field QQ
ext_field = QQ.algebraic_field(RootOf(x**2 - 2, 1))

# Output the extension field and algebraic element
print("Extension Field: ", ext_field)
# QQ<sqrt(2)>
```

## 3. Minimal Polynomial

In the polynomial ring $F[x]$ over the subfield $F$, there is not a unique polynomial with $\alpha$ as its root. Let $J_\alpha = \{P(x) | P(\alpha) = 0\}$ be the set of polynomials that satisfy this condition.

In other words, the minimal polynomial is the polynomial with the smallest degree in the polynomial ring that satisfies $P(\alpha) = 0$.

**Property 1: $J_\alpha$ is a principal ideal of the polynomial ring $F[x]$**

In $J_\alpha$, we can find the monic polynomial $Q(x)$ with the smallest degree, which satisfies $Q(\alpha) = 0$. We call this polynomial the minimal polynomial.

**Property 2: The minimal polynomial $Q(x)$ is unique.**

**Property 3: The minimal polynomial $Q(x)$ is an irreducible polynomial.**

**Property 4: The minimal polynomial $Q(x)$ generates the ideal $J_\alpha$.**

**Property 5: The degree of the minimal polynomial $Q(x)$ determines the degree of the field extension $K/F$.**

For example, for the field extension $\mathbb{Q}(\sqrt{2})/\mathbb{Q}$, the algebraic element is $\sqrt{2}$, and it has a unique minimal polynomial $x^2 - 2 = 0$. The degree of this minimal polynomial is $2$, which indicates that the field extension $\mathbb{Q}(\sqrt{2})/\mathbb{Q}$ is also $2$-dimensional. Each element in this extension field can be represented as $a + b\sqrt{2}$, with $1$ and $\sqrt{2}$ as the two basis dimensions.

## 4. Summary

In this chapter, we learned about field extension, algebraic extension, and minimal polynomials. Field extension is the process of extending a smaller base field to a larger field. In cryptography, algebraic extension is often used to perform field extensions and construct fields with desirable properties.