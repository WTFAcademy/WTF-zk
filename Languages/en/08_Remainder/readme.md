---
title: 08. Chinese Remainder Theorem
tags:
  - zk
  - basic
  - chinese remainder theorem
---

# WTF zk Tutorial 8: Chinese Remainder Theorem

In this tutorial, we will introduce residue classes and the famous Chinese Remainder Theorem, which can be used to solve system of congruence equations.

## 1. The Unknown Number Problem

The book "Sunzi Suanjing" from the Northern and Southern Dynasties period (420 AD - 589 AD) records a problem known as the "Unknown Number" problem, and the warrior who solves this problem can receive the Bitcoin (BTC) held by Sunzi (balance: 0).

> There is an unknown number, which leaves a remainder of 2 when counted by 3, a remainder of 3 when counted by 5, and a remainder of 2 when counted by 7. What is the number?

Translated into Modern Language: There is an unknown number $x$, which leaves a remainder of 2 when divided by 3, a remainder of 3 when divided by 5, and a remainder of 2 when divided by 7. Find the value of $x$.

In fact, this is a problem of solving a system of linear congruence equations, that is, finding $x$ that satisfies the following system of equations:

$$
x \equiv 2 \pmod{3}
$$

$$
x \equiv 3 \pmod{5}
$$

$$
x \equiv 2 \pmod{7}
$$

The Chinese Remainder Theorem, which we will introduce next, is used to solve this problem.

## 2. Residue Classes

In Tutorial 5, we briefly introduced the concept of residue classes, and now let's do a more systemetic explanation.

A residue class is an equivalence relation used to partition integers into congruence sets, defined as follows:

> Given an integer $m$, we define the residue class of an integer $a$ modulo $m$ to be the set of all integers that are congruent to $a$ modulo $m$. This set is usually denoted as $[a]_m$ and can be expressed as:

$$
[a]_m = \{ b \in \mathbb{Z} \mid a \equiv b \pmod{m} \}
$$

where $\equiv$ denotes the congruence relation.

For example, for modulo $m = 5$, the residue classes are $[0]_5, [1]_5, [2]_5, [3]_5, [4]_5$, etc.:

$$
[0]_5 = \{..., -10, -5, 0, 5, 10, ... \}
$$

$$
[1]_5 = \{..., -9, -4, 1, 6, 11, ... \}
$$

$$
[2]_5 = \{..., -8, -3, 2, 7, 12, ... \}
$$

$$
[3]_5 = \{..., -7, -2, 3, 8, 13, ... \}
$$

$$
[4]_5 = \{..., -6, -1, 4, 9, 14, ... \}
$$

Residue classes are not unique. For example, $[5]_5, [6]_5, [7]_5, [8]_5, [9]_5$ are also residue classes modulo 5, but we usually choose the smallest non-negative integer to represent the residue class, which is called the representative of the residue class. For example, the representative of the residue classes modulo 5 is $\{0_5, 1_5, 2_5, 3_5, 4_5\}$, and in cases where the semantics are clear, the subscript can be omitted, and it can be written as $\{0, 1, 2, 3, 4\}$ or $\mathbb{Z}_5$.

### 2.1. Properties

Residue classes form a partition of the set of integers, and they satisfy the three properties of an equivalence relation:

- **Reflexive:** Any integer $a$ is congruent to itself, $a \equiv a \pmod{m}$, so $[a]_m$ is not empty.

- **Symmetric:** If $a \equiv b \pmod{m}$, then $b \equiv a \pmod{m}$, which can also be written as $[a]_m = [b]_m$.

- **Transitive:** If $a \equiv b \pmod{m}$ and $b \equiv c \pmod{m}$, then $a \equiv c \pmod{m}$, which can also be written as $[a]_m = [b]_m = [c]_m$.

### 2.2 Operations on Residue Classes

Since residue classes are a way of partitioning integers into congruence sets, they can be seen as an abstraction and generalization of congruence relations, so their operations are the same as congruences.

For example, for two residue classes $[a]_m$ and $[b]_m$, we have:

$$
[a]_m + [b]_m = [a + b]_m
$$

$$
[a]_m \cdot [b]_m = [a \cdot b]_m
$$

## 3. System of Congruence Equations

### 3.1 Congruences

Congruences are an important class of equations in number theory, of the form $ax \equiv b \pmod{m}$. Solving congruences involves concepts such as modular arithmetic and modular inverses.

Example: $4x \equiv 2 \pmod{6}$

First, we notice that both sides of the equation have 2, and $\gcd(2, 6) = 2$, so we can divide both sides and the modulus by 2:

$$
2x \equiv 1 \pmod{3}
$$

Since 2 and 3 are coprime, $2^{-1} \pmod{3}$ exists. We can rewrite the equation as:

$$
x \equiv 2^{-1} \pmod{3}
$$

We can find $2^{-1} \equiv 2 \pmod{3}$ by exhaustive search, so the solution is:

$$
x = [2]_3
$$

### 3.2 Systems of Congruences

A system of congruences is a set of equations composed of multiple congruences, each involving modular arithmetic.

Let's start with an example that contains only two equations:

$$
x \equiv 2 \pmod{3}
$$

$$
x \equiv 3 \pmod{5}
$$

By observation, we know that if $y$ is a solution to the system of equations, then $y+15$ is also a solution. By exhaustive search, we easily find that $y=8$ is a solution, so the general solution to the system of equations is $[8]_{15}$, which can be expressed as:

$$
x = 8 + 15k
$$

where $k \in \mathbb{Z}$.

## 4. Chinese Remainder Theorem

The Chinese Remainder Theorem provides the conditions for the existence and solution of a system of linear congruences of one variable.

### 4.1 Simple Form

Let's start with a system of congruences that contains only two equations, and then generalize it to $n$ equations.

Integers $p$ and $q$ are coprime, and the system of equations is as follows:

$$
x \equiv a \pmod{p}
$$

$$
x \equiv b \pmod{q}
$$

According to the Chinese Remainder Theorem, the system of equations has a unique solution:

$$
x \equiv aqq_1+bpp_1 \pmod{pq}
$$

where $p_1 = p^{-1} \pmod{q}$ and $q_1 = q^{-1} \pmod{p}$.

<details><summary>Click to expand proof👀</summary>

Taking the equation and mod it by $p$, we have $x \equiv aqq_1 \pmod{p}$, because $bpp_1$ is divisible by $p$. Since $qq_1\pmod{p} = 1$, we have $x \equiv a \pmod{p}$, which satisfies the condition.

Similarly, taking the equation and mod it by $q$, we have $x \equiv b \pmod{q}$, which satisfies the condition.

Therefore, $x \equiv aqq_1+bpp_1 \pmod{pq}$ is a solution to the system of equations.

Next, we prove that the solution is unique:

Assume that there is another solution $y$ that satisfies the system of equations.

1. Since $y \equiv a \pmod{p}$, we have $p|y-x$.

2. Since $y \equiv b \pmod{q}$, we have $q|y-x$.

3. Because $p$ and $q$ are coprime, we have $pq|y-x$, so $y \equiv x \pmod{pq}$, and the solution is unique.

</details>

#### Example

Let's use the Chinese Remainder Theorem to solve the example in 3.2:

$$
x \equiv 2 \pmod{3}
$$

$$
x \equiv 3 \pmod{5}
$$

We have  $pq = 15$, where $3^{-1} = p_1 \pmod{5}$, therefore $p_1 = 2$, also $5^{-1}  = q_1 \pmod{3}$, therefore $q_1 = 2$. At last, we have:
$$
x \equiv 2 \times 5 \times 2 + 3 \times 3 \times 2 \equiv 38 \equiv 8 \pmod{15}
$$

This is the same as the answer we obtained with exhaustive search.

### 4.2 General Solution

Next, we will introduce the general solution form of the Chinese Remainder Theorem.

Integers $m_1, m_2,...,m_n$ are pairwise coprime (for $i 
e j$, $\gcd(m_i,m_j) = 1$), and the system of equations contains $n$ equations:
$$
x \equiv a_1 \pmod{m_1}
$$

$$
x \equiv a_2 \pmod{m_1}
$$

$$
...
$$


$$
x \equiv a_n \pmod{m_n}
$$

The system of equations has a unique solution modulo $M=m_1 \cdot m_2 \cdot... \cdot m_n$:

$$
x \equiv \sum_{i=1}^{n}{a_ib_ib_i'} \pmod{M}
$$

where $b_i = M/m_i$ (the product of all modulus numbers except $m_i$) and $b_i'=b_i^{-1} \pmod{m_i}$ (the modular inverse of $b_i$ modulo $m_i$).

<details><summary>Click to expand proof👀</summary>

Taking the general solution modulo $m_i$, we have $x \equiv a_ib_ib_i' \pmod{m_i}$, because except for the $i$-th term, all other terms can be divided by $m_i$. Since $b_ib_i' \equiv 1 \pmod{m_i}$, we have $x \equiv a_i \pmod{m_i}$, which satisfies the condition and is a solution to the system of equations.

</details>

### 4.3 Solving the Unknown Number Problem

With the Chinese Remainder Theorem, we can easily solve the Unknown Number problem:

$$
x \equiv 2 \pmod{3}
$$

$$
x \equiv 3 \pmod{5}
$$

$$
x \equiv 2 \pmod{7}
$$

First, we calculate the modulus $M = 3 \times 5 \times 7 = 105$.

Next, we calculate $a_i, b_i, b_i'$ for each equation.

$a_1 = 2, b_1 = 35, b_1' \equiv 35^{-1} \equiv 2\pmod{3}$

$a_2 = 3, b_2 = 21, b_2' \equiv 21^{-1} \equiv 1\pmod{5}$

$a_3 = 2, b_3 = 15, b_3' \equiv 15^{-1} \equiv 1\pmod{7}$

Therefore, the solution to the system of equations is $x \equiv 2 \times 35 \times 2 + 3 \times 21 \times 1 + 2 \times 15 \times 1 \equiv 233 \equiv 23 \pmod{105}$.

Let's check by substituting the solution into the equations. 23 leaves a remainder of 2 when divided by 3, a remainder of 3 when divided by 5, and a remainder of 2 when divided by 7, which satisfies the conditions.

### 4.4 Code Implementation

We can implement the Chinese Remainder Theorem in Python:

```python
def extended_gcd(a, b):
    if b == 0:
        return a, 1, 0
    else:
        d, x, y = extended_gcd(b, a % b)
        return d, y, x - (a // b) * y

def chinese_remainder_theorem(congruences):
    """
    Function to solve the Chinese Remainder Theorem

    :param congruences: A list of linear congruence equations in the format [(a1, m1), (a2, m2), ..., (an, mn)], representing the equation x ≡ ai (mod mi)
    :return: The solution x to the system of congruence equations
    """
    # Calculate the product of the modulus numbers M
    M = 1
    for _, mi in congruences:
        M *= mi

    # Calculate Mi and the modular inverse of Mi
    M_values = [M // mi for _, mi in congruences]
    Mi_values = [extended_gcd(Mi, mi)[1] for Mi, (_, mi) in zip(M_values, congruences)]

    # Calculate the solution x
    x = sum(ai * Mi * mi for (ai, _), Mi, mi in zip(congruences, Mi_values, M_values)) % M

    return x

# Example: Solve x ≡ 2 (mod 3), x ≡ 3 (mod 5), x ≡ 2 (mod 7)
congruences = [(2, 3), (3, 5), (2, 7)]
solution = chinese_remainder_theorem(congruences)
print(f"The solution to the system of congruence equations is x ≡ {solution} (mod {congruences[0][1] * congruences[1][1] * congruences[2][1]})")
# The solution to the system of congruence equations is x ≡ 23 (mod 105)
```

### 4.5 Reverse Application

The Chinese Remainder Theorem can be used in reverse to decompose the solution $X$ of an equation into multiple congruence equations. For example, in the Unknown Number problem, the solution $x \equiv 23 \pmod{105}$ can be decomposed into 3 equations:

$$
x \equiv 2 \pmod{3}
$$

$$
x \equiv 3 \pmod{5}
$$

$$
x \equiv 2 \pmod{7}
$$

In this way, we can break down the problem into smaller problems, which is very important in zero-knowledge proofs.

## 5. Summary

In this tutorial, we learned about residue classes, systems of congruences, and the Chinese Remainder Theorem. The Chinese Remainder Theorem can not only solve systems of congruences, but also be used in reverse to decompose a problem into smaller problems, which is very important in zero-knowledge proofs.