---
title: 09. Euler's Totient Function
tags:
  - zk
  - basic
  - euler's totient function 
---

# WTF zk Tutorial 09: Euler's Totient Function

Given an integer $n$, how many positive integers less than or equal to $n$ are coprime to $n$? In this tutorial, we will explore this problem and introduce the concepts of unit sets and Euler's totient function.

## 1. Unit Sets

If $x \in \mathbb{Z}_n$ is invertible (i.e. has a multiplicative inverse), we call $x$ a unit of $\mathbb{Z}_n$. The set of all units of $\mathbb{Z}_n$ is called the unit set, denoted as $\mathbb{Z}_n^*$.

As we have learned before, $x \in \mathbb{Z}_n$ is invertible if and only if $x$ is coprime to $n$. Therefore, the elements of $\mathbb{Z}_n^*$ are the positive integers in the range $[1, ..., n-1]$ that are coprime to $n$. In the theory of congruences, this set is also known as the coprime residue class modulo $n$.

Here are a few examples:

$\mathbb{Z}^*_2 = \{1\}$

$\mathbb{Z}^*_3 = \{1,2\}$

$\mathbb{Z}^*_5 = \{1, 2, 3, 4\}$

$\mathbb{Z}^*_8 = \{1, 3, 5, 7\}$

$\mathbb{Z}^*_9 = \{1, 2, 4, 5, 7, 8\}$

$\mathbb{Z}^*_{15} = \{1, 2, 4, 7, 8, 11, 13, 14\}$

## 2. Euler's Totient Function

The Euler's totient function, denoted as $\phi(n)$, represents the number of elements in the unit set $\mathbb{Z}_n^*$. In other words, it counts the number of positive integers in the range $[1, ..., n-1]$ that are coprime to $n$. Additionally, we define $\phi(1) = 1$.

Here are a few examples: $\phi(2) = 1$, $\phi(3) = 2$, $\phi(5) = 4$, $\phi(8) = 4$, $\phi(9) = 6$, $\phi(15) = 8$.

### 2.1 Properties of Euler's Totient Function

Euler's totient function has some remarkable properties that make it easy to calculate the number of elements in $\mathbb{Z}_n^*$. The first two properties apply to prime numbers $p$, while the third property is the multiplicative property of Euler's totient function, which allows us to calculate it for composite numbers by expressing them as products of their prime factors' Euler's totient functions.

#### 1. For a prime number $p$, we have $\phi(p) = p-1$

Here are a few examples: $\phi(2) = 1$, $\phi(3) = 2$, $\phi(13) = 12$.

<details><summary>Click to expand the proof👀</summary>

Since $p$ is a prime number, every $x \in \mathbb{Z}_p$ is coprime to $p$, which means the set $[1, ..., p-1]$ has a total of $p-1$ elements.

</details>

#### 2. For a prime number $p$ and a positive integer $k$, we have $\phi(p^k) = p^k - p^{k-1}$.

Here are a few examples:

$$
\phi(8) = \phi(2^3) = 2^3 - 2^2 = 4
$$

$$
\phi(9) = \phi(3^2) = 3^2 - 3^1 = 6
$$

<details><summary>Click to expand the proof👀</summary>

In the range $[1, ..., p^k]$, there are a total of $p^k$ elements. Since $p$ is a prime number, only the multiples of $p$ in this range, i.e. $[p, 2p, 3p, ..., p^k - p, p^k]$, are divisible by $p$ and not coprime to $p$. Therefore, out of every $p$ numbers, only $1$ number is not coprime to $p$. There are a total of $p^k / p = p^{k-1}$ such groups of $p$ numbers. Thus, the number of numbers coprime to $p$ is $p^k - p^{k-1}$, and $\phi(p^k) = p^k - p^{k-1}$.

</details>

#### 3. If $m$ and $n$ are coprime, i.e. $\gcd(m,n)=1$, we have $\phi(mn) = \phi(m)\phi(n)$.

Here are a few examples:

$$
\phi(15) = \phi(3) \times \phi(5) = 2 \times 4 = 8
$$

$$
\phi(18) = \phi(2) \times \phi(3^2) = 1 \times (3^2 - 3^1) = 6
$$

<details><summary>Click to expand the proof👀</summary>

To prove that there is a bijective relationship between $\mathbb{Z}_{mn}^*$ and $\mathbb{Z}_m^* \times \mathbb{Z}_n^*$, we need to establish a mapping relationship $f: \mathbb{Z}_{mn}^* \to{\mathbb{Z}_m^* \times \mathbb{Z}_n^*}$, which uniquely determines the residues $a$ and $b$ modulo $m$ and $n$ respectively.

**Surjection**: Since $m$ and $n$ are coprime, the Chinese Remainder Theorem tells us that for any $(a, b) \in \mathbb{Z}_m^* \times \mathbb{Z}_n^*$, considering the system of congruences:

$x \equiv a \pmod{m}$

$x \equiv b \pmod{n}$

there exists a unique solution $x$. Therefore, for any element in $\mathbb{Z}_m^* \times \mathbb{Z}_n^*$, there exists an $x$ such that $f(x) = (a, b)$. Thus, $f$ is surjective, covering the entire set $\mathbb{Z}_m^* \times \mathbb{Z}_n^*$.

**Injection**: Assuming there are two different elements $x_1$ and $x_2$, we have $f(x_1) = f(x_2)$, which means 

$(x_1 \mod m, x_1 \mod n) = (x_2 \mod m, x_2 \mod n)$

This implies that $x_1 \equiv x_2 \pmod{m}$ and $x_1 \equiv x_2 \pmod{n}$. Therefore, we have $x_1 \equiv x_2 \pmod{mn}$. Thus, $x_1$ and $x_2$ are congruent modulo $mn$, proving that $f$ is injective.

Since $f$ is both surjective and injective, $f$ is bijective. Therefore, there exists a bijective relationship between $\mathbb{Z}_{mn}^*$ and $\mathbb{Z}_m^* \times \mathbb{Z}_n^*$, and their number of elements are equal, i.e. $\phi(mn) = \phi(m)\phi(n)$.

</details>


Based on these three properties, we can transform the Euler's totient function of a large number into the product of the Euler's totient functions of its prime factors. If $n$ has a prime factorization of $p_1^{k_1}p_2^{k_2}...p_r^{k_r}$ (where the $p_{i}$ are distinct prime factors and $k_i \ge 1$ is the exponent of $p_i$), then the value of the Euler's totient function at that point is:

$$
\phi(n) = p_1^{k_1-1}p_2^{k_2-1}...p_r^{k_r-1} (p_1 - 1) (p_2 -1)...(p_r-1) 
$$

Alternatively, it can be written as:

$$
\phi(n) = n (1 - 1/p_1) (1 -1/p_2)...(1-1/p_r) 
$$

In summary: since any positive integer greater than $1$ can be factored into the product of prime numbers, let's assume $N=\prod_{i=1}^lp_i^{\alpha_i}$. Then, $\varphi(N)=\prod_{i=1}^lp_i^{\alpha_i-1}(p_i-1)$. In particular, if $N=p^\alpha$, then $\varphi(N)=p^{\alpha-1}(p-1)$. More specifically, if $N=p$, then $\varphi(N)=p-1$.

### 2.2 Code Implementation:

We can implement the Euler's totient function in Python. The code includes two functions: `prime_factors()`, which factorizes $n$ into prime numbers, and `euler_phi()`, which calculates $\phi(n)$ using the formula:

```python
# Factoring large integers is currently a difficult task
def prime_factors(n):
    factors = []
    p = 2
    while p * p <= n:
        while n % p == 0:
            factors.append(p)
            n //= p
        p += 1
    if n > 1:
        factors.append(n)
    return factors

def euler_phi(n):
    result = n
    factors = prime_factors(n)

    for p in set(factors):
        result -= result // p

    return result

# Example
n = 15
print(f"Euler's totient function phi({n}): {euler_phi(n)}")
# Euler's totient function phi(15): 8
```

## Summary

In this tutorial, we introduced the concepts of unit sets and Euler's totient function, which can be used to calculate the number of positive integers less than or equal to $n$ that are coprime to $n$. In the next tutorial, we will introduce Euler's theorem, which utilizes the Euler's totient function.
```