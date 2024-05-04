---
title: 10. Euler's Theorem
tags:
  - zk
  - basic
  - euler's theorem
---

# WTF zk Tutorial Lesson 10: Euler's Theorem

Euler's theorem is a fundamental theorem in number theory, stating that in modular arithmetic, for any integer coprime to the modulus, raising the integer to the power of Euler's totient function is congruent to 1 modulo the modulus. It provides the mathematical foundation for encryption algorithms such as RSA. In this lecture, we will introduce the discrete logarithm problem, the order of a unit, and Euler's theorem.

## 1. Discrete Logarithm Problem

The Discrete Logarithm Problem (DLP) is a classic difficult problem in mathematics and cryptography, which essentially means that taking logarithms in modular arithmetic is extremely hard.

Given a prime number $p$, and integers $g, h \in \mathbb{Z}_n^*$, the goal is to find an integer $x$ such that:

$$
g^x \equiv h \pmod{p}
$$

For example, given $(p, g, h) = (7, 3, 6)$, find $x$ that satisfies the equation $3^x \equiv 6 \pmod{7}$. We can try to solve it by exhaustive search:

$$
3^1 \equiv 3 \pmod{7}
$$

$$
3^2 \equiv 2 \pmod{7}
$$

$$
3^3 \equiv 6 \pmod{7}
$$

Therefore, $x = 3$ satisfies the condition.

However, for larger primes, computing discrete logarithms is extremely difficult. For instance, $(p, g, h) = (104729, 5, 3375)$ is very challenging. The security of RSA encryption and elliptic curve cryptography is ensured by the discrete logarithm problem, and they choose even larger and harder-to-compute parameters.

## 2. Order of a Unit

Let $a \in \mathbb{Z}_n$, the smallest positive integer $k$ that makes $a^k \equiv 1 \pmod{n}$ is called the order of the unit $a$.

For example:

When the modulus $n = 5$, and $a = 2$, we have:

$$
2^1 = 2 \pmod{5}
$$

$$
2^2 = 4 \pmod{5}
$$

$$
2^3 = 8 = 3 \pmod{5}
$$

$$
2^4 = 16 = 1 \pmod{5}
$$

Therefore, the order of $a$ is $4$. The order of a unit is important because it characterizes the cyclic nature of the unit group. We can see that $2^5 = 2 \cdot 2^4 = 2 \cdot 1 = 2 \pmod{5}$, falling into the next $\set{2, 4, 3, 1}$ cycle.

### 2.1 Properties of Order

In number theory, order is an important concept, representing the cyclic property between an element and the modulus. Here are some important properties of order in number theory:

#### 1. If the order of $a$ is $k$, then $a^j \equiv 1 \pmod{n}$ if and only if $k$ divides $j$.

Continuing with the previous example, $a=2, n =5$, the order of $a$ is $4$, and we have $2^8 \equiv 256 \equiv 1 \pmod{5}$, where $4$ divides $8$.

<details><summary>Click to expand the proof 👀</summary>

First, let's express $j$ using $k$. According to Euclidean division, we have

$$
j = qk + r
$$

where $0 \le r < k$. Then substitute it into the original equation, we get

$$
a^j = a^{qk+r} = a^{qk}a^r = (a^{k})^qa^r \equiv 1 \pmod{n}
$$

Since $a^k \equiv 1 \pmod{n}$, we have $(a^{k})^q\equiv 1 \pmod{n}$, and the above equation can be simplified to

$$
a^r \equiv 1 \pmod{n}
$$

According to the definition of order, $k$ is the smallest positive integer that makes $a^k \equiv 1 \pmod{n}$, and since $0 \le r < k$, we have $r = 0$, leading to:

$$
j = qk
$$

Therefore, $k$ divides $j$, and the proof is complete.
</details>

#### 2. If $a$ is coprime to the modulus $n$, then the order $k$ of $a$ divides $\phi(n)$, where $\phi(n)$ is Euler's totient function.

<details><summary>Click to expand the proof 👀</summary>

This property involves Euler's theorem, which we will introduce in the next section.

According to Euler's theorem, we have $a^{\phi(n)} \equiv 1 \pmod{n}$. Based on the first property: if the order of $a$ is $k$, then $a^j \equiv 1 \pmod{n}$ if and only if $k$ divides $j$. We have $k$ divides $\phi(n)$, and the proof is complete.
</details>

## 3. Euler's Theorem

Euler's theorem connects Euler's totient function and the cyclic property of exponentiation.

**Theorem:** If integer $a$ and positive integer $n$ are coprime (i.e., $\gcd(a,n)=1$), then $a^{\phi(n)} \equiv 1 \pmod{n}$.

Here, $\phi(n)$ is Euler's totient function, which represents the count of integers in $[1, ..., n-1]$ that are coprime to $n$.

Continuing with the previous example, $a=2, n =5$, we first calculate $\phi(5)=5-1=4$, and we have $2^4 \equiv 16 \equiv 1 \pmod{5}$, which agrees with Euler's theorem.

Let's take another example, $a = 3, n = 7$, we first calculate $\phi(7) = 7-1 =6$, then apply Euler's theorem to get $3^6 \equiv 1 \pmod{7}$. Checking $3^6 = 729$, the remainder when divided by $7$ is $1$, confirming Euler's theorem.

<details><summary>Click to expand the proof 👀</summary>

Consider the set $S = Z_n^* = \set{1 \le x \le n | \gcd(x,n) = 1}$. We know that $S$ has $\phi(n)$ elements, denoted as $\set{x_1, x_2, ..., x_{\phi(n)}}$.

Now consider another set $S'$, whose elements are the elements of $S$ multiplied by $a$, which can be represented as:

$S' = aS = \set{ax_1, ax_2, ..., ax_{\phi(n)}}$

**Lemma 1:** $\gcd(ax_i,n) = 1$.

Proof: Since $\gcd(a, n) = 1$ and $\gcd(x_i,n) = 1$, we have $\gcd(ax_i,n) = 1$.

**Lemma 2:** Taking any two elements from set $S'$, they are not congruent modulo $n$.

Proof: Suppose there exist two elements $ax_i$ and $ax_j$ in $S'$ that are congruent, i.e., $ax_i \equiv ax_j \pmod{n}$, then we have $a(x_i- x_j) \equiv 0 \pmod{n}$, which means $n$ divides $a(x_i- x_j)$, i.e., $n|a(x_i- x_j)$. Since $\gcd(a, n) = 1$, we have $n|(x_i- x_j)$, that is, $x_i- x_j = kn$. Moreover, because $1 \le x_i, x_j \le n$, we have $x_i - x_j = 0$, i.e., $x_i = x_j$. Therefore, $x_i$ and $x_j$ are congruent if and only if $i=j$, and the proof is complete.

According to Lemma 1 and 2, we know that $S'$ consists of $\phi(n)$ elements that are coprime to $n$, and they are pairwise incongruent. In other words, $S' = Z_n^*$, containing the same elements as $S$ (possibly in a different order).

Next, we multiply all elements in $S$ and $S'$ respectively, and they should be congruent, i.e.:

$(ax_1)(ax_2)...(ax_{\phi(n)}) \equiv x_1x_2...x_{\phi(n)} \pmod{n}$

Extracting all $a$'s, a total of $\phi(n)$, we have:

$a^{\phi(n)} x_1x_2...x_{\phi(n)}  \equiv x_1x_2...x_{\phi(n)} \pmod{n}$

Let $X = x_1x_2...x_{\phi(n)}$, we have $\gcd(X,n) = 1$, so the original equation can be simplified to:

$a^{\phi(n)} X  \equiv X \pmod{n}$

Since $X^{-1}$ exists, we multiply both sides by $X^{-1}$ and simplify to get:

$a^{\phi(n)}  \equiv 1 \pmod{n}$

The proof is complete!
</details>

### 3.1 Relationship with Fermat's Little Theorem

We can easily use Euler's theorem to prove Fermat's little theorem.

According to Euler's theorem: If integer $a$ and positive integer $n$ are coprime (i.e., $\gcd(a,n)=1$), then $a^{\phi(n)} \equiv 1 \pmod{n}$.

When $n$ is prime, $\phi(n)=n-1$. Substituting into the original equation, we have $a^{n-1} \equiv 1 \pmod{n}$, which is equivalent to $a^{n} \equiv a \pmod{n}$. Thus, we have proved Fermat's little theorem, which can be considered as a special case of Euler's theorem when $n$ is prime.

### 3.2 Code Implementation

You can verify Euler's theorem in Python:

```python
def gcd(a, b):
    while b:
        a, b = b, a % b
    return a

def euler_phi(n):
    count = 0
    for i in range(1, n + 1):
        if gcd(n, i) == 1:
            count += 1
    return count

def euler_theorem(a, n):
    if gcd(a, n) != 1:
        raise ValueError("a and n must be coprime for Euler's theorem.")
    
    result = pow(a, euler_phi(n), n)
    return result

# Example
n = 15
print(f"Euler's totient function phi({n}): {euler_phi(n)}")
# Euler's totient function phi(15): 8

a = 7
result = euler_theorem(a, n)
print(f"Euler's theorem: {a}^phi({n}) mod {n} = {result}")
# Euler's theorem: 7^phi(15) mod 15 = 1
```

## 4. Summary

In this lecture, we introduced Euler's theorem and its relationship with Fermat's little theorem. Euler's theorem is the mathematical foundation of the RSA encryption algorithm and is of great importance. Everyone should have a good grasp of it.
