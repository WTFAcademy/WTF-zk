---
title: 09. Euler's Totient Function
tags:
  - zk
  - basic
  - euler's totient function 
---

# Tutorial 9: Euler's Totient Function

Given an integer $n$, how many positive integers less than or equal to $n$ are coprime with $n$? In this tutorial, we will explore this problem and introduce the concepts of unit set and Euler's totient function.

## 1. Unit Set

If an integer $x \in \mathbb{Z}_n$ is invertible (i.e., it has a multiplicative inverse), we call it a unit of $\mathbb{Z}_n$. The set of all units of $\mathbb{Z}_n$ is called the unit set, denoted as $\mathbb{Z}_n^*$.

From our previous study, we know that $x \in \mathbb{Z}_n$ is invertible if and only if $x$ is coprime with $n$. Therefore, the elements in $\mathbb{Z}_n^*$ are the positive integers in the range $[1, ..., n-1]$ that are coprime with $n$. In congruence theory, this set is also known as the coprime congruence class modulo $n$.

Here are a few examples:

$\mathbb{Z}^*_2 = \{1\}$

$\mathbb{Z}^*_3 = \{1,2\}$

$\mathbb{Z}^*_5 = \{1, 2, 3, 4\}$

$\mathbb{Z}^*_8 = \{1, 3, 5, 7\}$

$\mathbb{Z}^*_9 = \{1, 2, 4, 5, 7,8\}$

$\mathbb{Z}^*_{15} = \{1, 2, 4, 7, 8, 11, 13, 14\}$

## 2. Euler's Totient Function

The Euler's totient function is denoted as $\phi(n) = |\mathbb{Z}_n^*|$, which represents the number of elements in the unit set $\mathbb{Z}_n^*$. In other words, it is the number of positive integers in the range $[1, ..., n-1]$ that are coprime with $n$. Additionally, we define $\phi(1) = 1$.

Here are a few examples: $\phi(2) = 1$, $\phi(3) = 2$, $\phi(5) = 4$, $\phi(8) = 4$, $\phi(9) = 6$, $\phi(15) = 8$.

### 2.1 Properties of Euler's Totient Function

The Euler's totient function has some interesting properties that facilitate the calculation of the number of elements in $\mathbb{Z}_n^*$. The first two properties are applicable when $n$ is a prime number, and the third property is about the multiplicativity of the Euler's totient function, when $n$ is a composite number, then it can be represented as a product of the Euler's totient functions of their prime factors.

#### 1. For prime numbers $p$, we have $\phi(p) = p-1$

Here are a few examples: $\phi(2) = 1$, $\phi(3)=2$, $\phi(13)=12$.

<details><summary>Proof</summary>

Since $p$ is a prime number, every $x \in \mathbb{Z}_p$ is coprime with $p$, which means there are $p-1$ elements in the range $[1, ..., p-1]$ that are coprime with $p$.

</details>

#### 2. For prime numbers $p$ and positive integer $k$, we have $\phi(p^k) = p^k - p ^{k-1}$.

Here are a few examples: 

$$
\phi(8)= \phi(2^3) = 2^3 - 2^2 = 4
$$

$$
\phi(9)=\phi(3^2) = 3^2 - 3^1 = 6
$$

<details><summary>Proof</summary>

There are a total of $p^k$ elements in the range $[1, ..., p^k]$. Since $p$ is a prime number, only the multiples of $p$ in the range $[p, 2p, 3p, ..., p^k -p, p^k]$ can be divided by $p$ and are not coprime with $p$. Therefore, among every $p$ numbers, only one is not coprime with $p$. There are a total of $p^k / p = p^{k-1}$ such numbers. Therefore, there are $p^k - p ^{k-1}$ numbers that are coprime with $p$, and $\phi(p^k) = p^k - p ^{k-1}$.

</details>

#### 3. If $m$ and $n$ are coprime, i.e., $\gcd(m,n)=1$, then $\phi(mn) = \phi(m)\phi(n)$

Here are a few examples: 
    
$$
\phi(15)= \phi(3) \times \phi(5) = 2 \times 4 = 8
$$

$$
\phi(18)= \phi(2) \times \phi(3^2) = 1 \times (3^2 - 3^1) = 6
$$

<details><summary>Proof</summary>

We need to prove that the sets ${\mathbb{Z}_{mn}^*}$ and $\mathbb{Z}_m^* \times \mathbb{Z}_n^*$ have a bijective relationship, which means their elements correspond one-to-one, and therefore, they have the same number of elements. The number of elements in $\mathbb{Z}_{mn}^*$ is $\phi(mn)$, and the number of elements in $\mathbb{Z}_m^* \times \mathbb{Z}_n^*$ is $\phi(m)\phi(n)$, so $\phi(mn) = \phi(m)\phi(n)$.

We can establish a mapping $f: \mathbb{Z}_{mn}^* \to{\mathbb{Z}_m^* \times \mathbb{Z}_n^*}$, which uniquely determines the residues $a, b$ modulo $m$ and modulo $n$, respectively. Therefore, this mapping is well-defined.

**Surjective**: Since $m$ and $n$ are coprime, by the Chinese Remainder Theorem, for any $(a, b) \in \mathbb{Z}_m^* \times \mathbb{Z}_n^*$, consider the system of congruences:

$x \equiv a \pmod{m}$

$x \equiv b \pmod{n}$

there exists a unique solution $x$. Therefore, for any element in $\mathbb{Z}_m^* \times \mathbb{Z}_n^*$, there exists an $x$ such that $f(x) = (a, b)$. Therefore, $f$ is surjective, which means the mapping covers the entire set $\mathbb{Z}_m^* \times \mathbb{Z}_n^*$.

**Injective**: Suppose we have two different elements $x_1$ and $x_2$. We have $f(x_1) = f(x_2)$, which means 

$(x_1 \mod m, x_1 \mod n) = (x_2 \mod m, x_2 \mod n)$

This implies that $x_1 \equiv x_2 \pmod{m}$ and $x_1 \equiv x_2 \pmod{n}$. Therefore, we have $x_1 \equiv x_2 \pmod{mn}$. Thus, $x_1$ and $x_2$ are equal when its mod by $mn$, proving that $f$ is injective.

Since $f$ is both surjective and injective, it is bijective. Therefore, ${\mathbb{Z}_{mn}^*}$ and $\mathbb{Z}_m^* \times \mathbb{Z}_n^*$ have a bijective relationship, and their elements correspond one-to-one, so $\phi(mn) = \phi(m)\phi(n)$.

</details>


Based on these three properties, we can express the Euler's totient function of a large number as a product of the Euler's totient functions of its prime factors: if $n$ has a prime factorization $p_1^{k_1}p_2^{k_2}...p_r^{k_r}$ (where $p_i$ are distinct prime factors and $k_i \ge 1$ is the exponent of each prime factor), then the Euler's totient function at that point is:

$$
\phi(n)= p_1^{k_1-1}p_2^{k_2-1}...p_r^{k_r-1} (p_1 - 1) (p_2 -1)...(p_r-1) 
$$

Alternatively, we can write it as:

$$
\phi(n)= n (1 - 1/p_1) (1 -1/p_2)...(1-1/p_r)
$$

To summarize: since any positive integer greater than $1$ can be factored into the product of prime numbers, let's assume $N=\prod_{i=1}^lp_i^{\alpha_i}$, then $\phi(N)=\prod_{i=1}^lp_i^{\alpha_i-1}(p_i-1)$. In particular, if $N=p^\alpha$, then $\phi(N)=p^{\alpha-1}(p-1)$. Even more specifically, if $N=p$, then $\phi(N)=p-1$.

### 2.2 Implementation in Python:

We can implement the Euler's totient function in Python. The code includes two functions, `prime_factors()`, which factors $n$ into prime factors, and `euler_phi`, which calculates $\phi(n)$ using the formula:

```python
# Prime factorization can be challenging for large integers
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

In this tutorial, we introduced the concepts of unit set and Euler's totient function, which can be used to calculate the number of positive integers less than or equal to $n$ that are coprime with $n$. In the next tutorial, we will explore Euler's theorem, which utilizes the Euler's totient function.
