First, we calculate $M = 3 \times 5 \times 7 = 105$.

Next, we calculate $a_i, b_i, b_i'$.

$a_1 = 2, b_1 = 35, b_1' \equiv 35^{-1} = 2\pmod{3}$

$a_2 = 3, b_2 = 21, b_2' \equiv 21^{-1} = 1\pmod{5}$

$a_3 = 2, b_3 = 15, b_3' \equiv 15^{-1} = 1\pmod{7}$

Therefore, the solution of the system of equations is $x \equiv 2 \times 35 \times 2 + 3 \times 21 \times 1 + 2 \times 15 \times 1 \equiv 233 \equiv 23 \pmod{105}$.

Let's try substituting the solution into the equations. 23 is congruent to 2 modulo 3, 3 modulo 5, and 2 modulo 7, which satisfies the conditions.

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

    :param congruences: The system of linear congruences, in the format [(a1, m1), (a2, m2), ..., (an, mn)], representing the equations as x ≡ ai (mod mi)
    :return: The solution x of the system of equations
    """
    # Calculate the product of moduli M
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
print(f"The solution to the system of congruences is x ≡ {solution} (mod {congruences[0][1] * congruences[1][1] * congruences[2][1]})")
# The solution to the system of congruences is x ≡ 23 (mod 105)
```

### 4.5 Reverse Use

The Chinese Remainder Theorem can be used in reverse, decomposing the solution $X$ of an equation into multiple congruence equations. For example, in the problem of unknown numbers, if we obtain the solution $x \equiv 23 \pmod{105}$, we can decompose it into 3 equations:

$$
x \equiv 2 \pmod{3}
$$

$$
x \equiv 3 \pmod{5}
$$

$$
x \equiv 2 \pmod{7}
$$

In this way, we can break down the "big problem" into "small problems", which is very important in zero-knowledge proofs.

## 5. Summary

In this lesson, we learned about residue classes, systems of congruences, and the Chinese Remainder Theorem. The Chinese Remainder Theorem not only solves systems of congruences but also allows for reverse use, decomposing a big problem into smaller problems, which is crucial in zero-knowledge proofs.
# WTF zk Tutorial Lesson 8: Chinese Remainder Theorem

In this tutorial, we will introduce the concept of residue classes and the famous Chinese Remainder Theorem, which can be used to solve systems of congruences.

## 1. The Problem of Unknown Number

In the "Sunzi Suanjing" of the Northern and Southern Dynasties in China (420-589 AD), there is a problem known as the "Problem of Unknown Number". The warrior who solves this problem will receive BTC (Balance: 0) held by Sunzi.

> There is an unknown number, when divided by 3, the remainder is 2; when divided by 5, the remainder is 3; when divided by 7, the remainder is 2. What is the number?

Translated into ancient Chinese: There is an unknown number $x$, when divided by 3, the remainder is 2; when divided by 5, the remainder is 3; when divided by 7, the remainder is 2. Find the value of $x$.

In fact, this is a problem of solving a system of linear congruences, that is, finding $x$ that satisfies the following system of equations:

$$
x \equiv 2 \pmod{3}
$$

$$
x \equiv 3 \pmod{5}
$$

$$
x \equiv 2 \pmod{7}
$$

The Chinese Remainder Theorem we are about to introduce is used to solve this problem.

## 2. Residue Classes

In Lesson 5, we briefly learned about the concept of residue classes in modular arithmetic. Now we need to introduce it more systematically.

Residue classes are a type of equivalence relation used to divide integers into sets that are congruent. They are defined as follows:

> Given an integer $m$, we define the residue class of an integer $a$ modulo $m$ as the set of all integers congruent to $a$ modulo $m$. This set is usually denoted by $[a]_m$ and can be expressed as:

$$
[a]_m = \{ b \in \mathbb{Z} \mid a \equiv b \pmod{m} \}
$$

Here, $\equiv$ denotes the congruence relation.

For example, for modulo $m = 5$, there are residue classes $[0]_5, [1]_5, [2]_5, [3]_5, [4]_5$, etc:

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

Residue classes are not unique; for example, $[5]_5, [6]_5, [7]_5, [8]_5, [9]_5$ are also residue classes modulo 5. But we usually choose the smallest non-negative integers as representatives of the residue classes, and they are called the representative elements of the residue classes. For example, the representative elements of the residue classes modulo 5 are $\{0_5, 1_5, 2_5, 3_5, 4_5\}$ or simply $\{0, 1, 2, 3, 4\}$, which can also be written as $Z_5$.

### 2.1. Properties

Residue classes form a partition of the set of integers and satisfy the three properties of an equivalence relation:

- **Reflexivity:** Any integer $a$ is congruent to itself, $a \equiv a \pmod{m}$, so $[a]_m$ is not empty.

- **Symmetry:** If $a \equiv b \pmod{m}$, then $b \equiv a \pmod{m}$, which can also be written as $[a]_m = [b]_m$.

- **Transitivity:** If $a \equiv b \pmod{m}$ and $b \equiv c \pmod{m}$, then $a \equiv c \pmod{m}$, which can also be written as $[a]_m = [b]_m = [c]_m$.

### 2.2 Operations on Residue Classes

Since residue classes divide integers into congruent sets, they can be seen as an abstraction and generalization of congruence relations, so their operations are the same as those of congruences.

For example, for two residue classes $[a]_m$ and $[b]_m$, we have:

$$
[a]_m + [b]_m = [a + b]_m
$$

$$
[a]_m \cdot [b]_m = [a \cdot b]_m
$$

## 3. Systems of Congruences

### 3.1 Congruence Equations

Congruence equations are an important type of equations in number theory, of the form $ax \equiv b \pmod{m}$. Solving congruence equations involves concepts such as modular arithmetic and modular inverses.

Example: $4x \equiv 2 \pmod{6}$

First, we notice that both sides of the equation have 2, and $\gcd(2, 6) = 2$. Therefore, we can divide both sides of the equation by 2 and the modulus, getting:

$$
2x \equiv 1 \pmod{3}
$$

Since 2 and 3 are coprime, $2^{-1} \pmod{3}$ exists. We can write the equation as:

$$
x \equiv 2^{-1} \pmod{3}
$$

By exhaustive search, we find that $2^{-1} \pmod{3} \equiv 2$, so the solution is:

$$
x = [2]_3
$$

### 3.2 Systems of Congruences

A system of congruences is a set of equations composed of multiple congruence equations, each involving modular arithmetic.

Let's first look at an example with only two equations:

$$
x \equiv 2 \pmod{3}
$$

$$
x \equiv 3 \pmod{5}
$$

By observation, we know that if $y$ is a solution, so is $y+15$. By exhaustive search, we easily find $y = 8$ is a solution, so the general solution of the system is $[8]_{15}$, which is:

$$
x = 8 + 15k
$$

where $k \in \mathbb{Z}$.

## 4. Chinese Remainder Theorem

The Chinese Remainder Theorem provides conditions for the existence and methods for solving a system of linear congruences.

### 4.1 Simple Form

Let's first look at a system of congruences with only two equations, and then generalize to $n$ equations.

Let integers $p$ and $q$ be coprime, and the system of equations is as follows:

$$
x \equiv a \pmod{p}
$$

$$
x \equiv b \pmod{q}
$$

According to the Chinese Remainder Theorem, this system of equations has a unique solution:

$$
x \equiv aqq_1+bpp_1 \pmod{pq}
$$

where $p_1 = p^{-1} \pmod{q}$, and $q_1 = q^{-1} \pmod{p}$.

<details><summary>Click to expand proof👀</summary>

Taking modulo $p$ of the above equation, we have $x \equiv aqq_1 \pmod{p}$, because $bpp_1$ is divisible by $p$. Also, since $qq_1\pmod{p} = 1$, we have $x \equiv a \pmod{p}$, which satisfies the condition.

Similarly, taking modulo $q$ of the above equation, we have $x \equiv b \pmod{q}$, which satisfies the condition.

Thus, $x \equiv aqq_1+bpp_1 \pmod{pq}$ is a solution of the system of equations.

Next, we prove the uniqueness of the solution:

Assume there is another solution $y$ that satisfies the system of equations.

1. Since $y \equiv a \pmod{p}$, we have $p|y-x$.

2. Since $y \equiv b \pmod{q}$, we have $q|y-x$.

3. Because $p$ and $q$ are coprime, we have $pq|y-x$, hence $y \equiv x \pmod{pq}$, and the solution is unique.

</details>

#### Example

Let's use the Chinese Remainder Theorem to solve the example in 3.2:

$$
x \equiv 2 \pmod{3}
$$

$$
x \equiv 3 \pmod{5}
$$

Here, $pq = 15$, $p_1= 3^{-1} = 2 \pmod{5}$, $q_1 = 5^{-1}  = 2\pmod{3}$. Therefore:

$$
x \equiv 2 \times 5 \times 2 + 3 \times 3 \times 2 \equiv 38 \equiv 8 \pmod{15}
$$

This matches the result we obtained earlier using exhaustive search.

### 4.2 General Solution

Now, let's introduce the general form of the Chinese Remainder Theorem.

Let $m_1, m_2, ..., m_n$ be pairwise coprime (for $i \ne j$, we have $\gcd(m_i,m_j) = 1$), and consider a system of equations with $n$ congruence equations:

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

The system of equations has a unique solution modulo $M = m_1 \cdot m_2 \cdot ... \cdot m_n$:

$$
x \equiv \sum_{i=1}^{n}{a_ib_ib_i'} \pmod{M}
$$

where $b_i = M/m_i$ (i.e., the product of all moduli except $m_i$), and $b_i'=b_i^{-1} \pmod{m_i}$ (i.e., the inverse of $b_i$ modulo $m_i$).

<details><summary>Click to expand proof👀</summary>

Taking the general solution modulo $m_i$, we get $x \equiv a_ib_ib_i' \pmod{m_i}$, because except for the $i$-th term, the rest can be divided by $m_i$. Moreover, because $b_ib_i' \equiv 1 \pmod{m_i}$, we have $x \equiv a_i \pmod{m_i}$, which satisfies the condition and is a solution of the system of equations.

</details>

### 4.3 Solving the Problem of Unknown Number

With the Chinese Remainder Theorem, we can easily solve the problem of the unknown number:

$$
x \equiv 2 \pmod{3}
$$

$$
x \equiv 3 \pmod{5}
$$

$$
x \equiv 2 \pmod{7}
$$
