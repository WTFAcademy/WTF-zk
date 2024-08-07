---
title: 28. Quadratic Residue
tags:
  - zk
  - abstract algebra
  - field
  - number theory
  - quadratic residue
---

# WTF zk Tutorial Lesson 28: Quadratic Residue

In this chapter, we will explore quadratic residues in the finite field $F_p$. Quadratic residues involve the concept of squares and square roots of numbers, and they are widely used in cryptography and zero-knowledge proofs.

## 1. Quadratic Residue

A **quadratic residue** is a concept related to modular arithmetic. For an integer $a$ and a positive integer $n$, if there exists an integer $x$ such that $x^2 \equiv a \pmod{n}$, then $a$ is called a quadratic residue modulo $n$. If no such $x$ exists, then $a$ is called a quadratic non-residue modulo $n$.

In this tutorial, we will focus on the case where $n$ is an odd prime number $p$.

Let's consider an example with $n = 7$ to illustrate quadratic residues in the multiplicative group $Z_7^*$ (excluding 0):

$1^2 \equiv 1 \pmod{7}$

$2^2 \equiv 4 \pmod{7}$

$3^2 \equiv 2 \pmod{7}$

$4^2 \equiv 2 \pmod{7}$

$5^2 \equiv 4 \pmod{7}$

$6^2 \equiv 1 \pmod{7}$

Therefore, the group $Z_7^*$ has a total of 6 elements. The quadratic residues are $\{1, 2, 4\}$, and the quadratic non-residues are $\{3, 5, 6\}$, each comprising half of the group.

**Property 1:** There are $\frac{p-1}{2}$ quadratic residues modulo $p$.

<details><summary>Click to expand the proof👀</summary>

For an odd prime number $p$, the residue classes modulo $p$ are $1, 2, \ldots, p-1$, and there are $p-1$ elements. Considering an element $x$ and a quadratic residue $a$, we have $x^2 \equiv a \pmod{p}$ and $(-x)^2 \equiv a \pmod{p}$. In other words, if $a$ is a quadratic residue of $x$, then $a$ is also a quadratic residue of $-x$, and they are opposites of each other. Therefore, in the residue classes $Z_p$, each quadratic residue corresponds to two elements, resulting in a total of $\frac{p-1}{2}$ quadratic residues. Proof completed.

</details>

## 2. Legendre Symbol

The Legendre symbol $\left(\frac{a}{p}\right)$ is a symbolic representation of quadratic residues. It is defined as follows:

$$
\left(\frac{a}{p}\right) = \begin{cases} 
1 & \text{if } a \text{ is a quadratic residue modulo } p \\
-1 & \text{if } a \text{ is a quadratic non-residue modulo } p \\
0 & \text{if } a \equiv 0 \pmod{p}
\end{cases}
$$

The Legendre symbol provides a convenient symbolic representation for quadratic residue problems. For example, in $Z_7$, we have $(\frac{0}{7}) = 0$, $(\frac{1}{7}) = 1$, $(\frac{2}{7}) = 1$, $(\frac{3}{7}) = -1$, $(\frac{4}{7}) = 1$, $(\frac{5}{7}) = -1$, $(\frac{6}{7}) = 1$.

## 3. Euler's Criterion

Euler's criterion is an important theorem about quadratic residues modulo $p$. If $p$ is an odd prime number and $a$ is an integer coprime to $p$, then

$$
a^{\frac{p-1}{2}} \equiv \left(\frac{a}{p}\right) \pmod{p}
$$

This criterion is very useful for determining whether a number is a quadratic residue or not.

<details><summary>Click to expand the proof👀</summary>

If $a = 0 \pmod{p}$, then $a^{\frac{p-1}{2}} = 0^{\frac{p-1}{2}} = 0$.

Now let's discuss the case where $a$ and $p$ are coprime.

According to Fermat's little theorem, we have $a^{p-1} -1 \equiv 0 \pmod{p}$. Since $p$ is an odd prime number, we can factorize it as $(a^\frac{p-1}{2} -1)(a^\frac{p-1}{2} + 1) = 0 \pmod{p}$. This means that $a^\frac{p-1}{2} = \pm 1$.

If $a$ is a quadratic residue, then there exists $b \in Z_p^*$ such that $a = b^2$. Raising both sides of the equation to the power of $\frac{p-1}{2}$, we have $a^\frac{p-1}{2} \equiv b^{p-1} \pmod{p}$. According to Fermat's little theorem, we have $b^{p-1} \equiv 1 \pmod{p}$, so we have $a^\frac{p-1}{2} \equiv 1 \pmod{p}$.

The group $Z_p^*$ has $p-1$ elements, each of which corresponds to $\frac{p-1}{2}$ quadratic residues. According to Lagrange's theorem, the polynomial $a^\frac{p-1}{2} - 1 =0$ has at most $\frac{p-1}{2}$ roots, which are exactly filled by $\frac{p-1}{2}$ quadratic residues $a$. Therefore, the remaining $\frac{p-1}{2}$ quadratic non-residues must satisfy $a^\frac{p-1}{2} + 1 =0$, which means $a^\frac{p-1}{2} = -1 \pmod{p}$.

</details>

Taking $Z_7^*$ as an example, $0^3 = 0$, $1^3 = 1$, $2^3 = 1$, $3^3 = -1$, $4^3 = 1$, $5^3 = -1$, $6^3 = -1$. The quadratic residues are $\{1,2,4\}$, which aligns with the previous calculation.

## 4. Code Example

We can use Euler's criterion in Python to determine whether an element is a quadratic residue.

```python
def legendre_symbol(a, p):
    """Calculate the Legendre symbol (a/p)"""
    legendre = pow(a, (p - 1) // 2, p)
    return -1 if legendre == p - 1 else legendre

def is_quadratic_residue(a, p):
    """Check if a is a quadratic residue modulo p"""
    legendre = legendre_symbol(a, p)
    return legendre == 1

# Example
p = 7
for a in range(p):
    if is_quadratic_residue(a, p):
        print(f"{a} is a quadratic residue modulo {p}")
    else:
        print(f"{a} is not a quadratic residue modulo {p}")

## Output Example        
# 0 is not a quadratic residue modulo 7
# 1 is a quadratic residue modulo 7
# 2 is a quadratic residue modulo 7
# 3 is not a quadratic residue modulo 7
# 4 is a quadratic residue modulo 7
# 5 is not a quadratic residue modulo 7
# 6 is not a quadratic residue modulo 7
```

## 5. Modular Square Root Problem

Finding modular square roots becomes as challenging as factoring large numbers when $n$ is a large composite number. This characteristic is frequently utilized in constructing encryption algorithms and zero-knowledge proof algorithms, such as the [Rabin cryptosystem](https://en.wikipedia.org/wiki/Rabin_cryptosystem) and the [Goldwasser–Micali cryptosystem](https://en.wikipedia.org/wiki/Goldwasser%E2%80%93Micali_cryptosystem).

## 6. Summary

In this chapter, we learned about quadratic residues, Legendre symbols, and Euler's criterion. Quadratic residues are commonly employed in the field of cryptography for constructing encryption algorithms.