print(f"Euler's function phi({n}): {euler_phi(n)}")
# Euler's function phi(15): 8

## Summary

In this lesson, we introduced the concept of unit set and Euler's function, which can be used to calculate the number of positive integers less than or equal to $n$ that are coprime to $n$. In the next lesson, we will discuss Euler's theorem, which utilizes Euler's function.
# WTF zk Tutorial Lesson 9: Euler's Totient Function

Given an integer $n$, how many positive integers less than or equal to $n$ are relatively prime to $n$? In this tutorial, we will study this problem, including the concepts of unit set and Euler's totient function.

## 1. Unit Set

If $x \in \mathbb{Z}_n$ is invertible (i.e., has a multiplicative inverse), we call $x$ a unit of $\mathbb{Z}_n$. The set of all units of $\mathbb{Z}_n$ is called the unit set and is denoted as $\mathbb{Z}_n^*$.

From our previous study, we know that $x \in \mathbb{Z}_n$ is invertible if and only if $x$ is relatively prime to $n$. Therefore, the elements in $\mathbb{Z}_n^*$ are the positive integers in the range $[1, ..., n-1]$ that are relatively prime to $n$. In congruence theory, this set is also known as the set of coprime residues modulo $n$.

Here are some examples:

$\mathbb{Z}^*_2 = \{1\}$

$\mathbb{Z}^*_3 = \{1,2\}$

$\mathbb{Z}^*_5 = \{1, 2, 3, 4\}$

$\mathbb{Z}^*_8 = \{1, 3, 5, 7\}$

$\mathbb{Z}^*_9 = \{1, 2, 4, 5, 7,8\}$

$\mathbb{Z}^*_{15} = \{1, 2, 4, 7, 8, 11, 13, 14\}$

## 2. Euler's Totient Function

Euler's totient function, denoted as $\phi(n) = |\mathbb{Z}_n^*|$, calculates the number of elements in the unit set $\mathbb{Z}_n^*$. In other words, it counts the number of positive integers in the range $[1, ..., n-1]$ that are relatively prime to $n$. Additionally, we define $\phi(1) = 1$.

Here are some examples: $\phi(2) = 1$, $\phi(3) = 2$, $\phi(5) = 4$, $\phi(8) = 4$, $\phi(9) = 6$, $\phi(15) = 8$.

### 2.1 Properties of Euler's Totient Function

Euler's totient function has some magical properties that make it easy to calculate the number of elements in $\mathbb{Z}_n^*$. The first two properties apply when $n$ is a prime number. The third property is the multiplicativity property of Euler's totient function, which allows us to express the totient function of a composite number as a product of the totient functions of its prime factors.

#### 1. For a prime number $p$, we have $\phi(p) = p-1$

Here are some examples: $\phi(2) = 1$, $\phi(3)=2$, $\phi(13)=12$.

Proof:

Since $p$ is a prime number, any $x \in \mathbb{Z}_p$ is relatively prime to $p$, which means $[1, ..., p-1]$ contains $(p-1)$ elements.

#### 2. For a prime number $p$ and a positive integer $k$, we have $\phi(p^k) = p^k - p^{k-1}$

Here are some examples:

$$
\phi(8)=\phi(2^3) = 2^3 - 2^2 = 4
$$

$$
\phi(9)=\phi(3^2) = 3^2 - 3^1 = 6
$$

Proof:

In the range $[1, ..., p^k]$, there are a total of $p^k$ elements. Since $p$ is a prime number, only the multiples of $p$, which are $[p, 2p, 3p, ..., p^k -p, p^k]$, are not relatively prime to $p$. Therefore, among every $p$ numbers, only $1$ number is not relatively prime to $p$, and there are a total of $p^k / p = p^{k-1}$ such sets of $p$ numbers. Thus, the number of elements that are relatively prime to $p^k$ is $p^k - p ^{k-1}$, which is equal to $\phi(p^k) = p^k - p ^{k-1}$.

#### 3. If $m$ and $n$ are relatively prime (i.e., $\gcd(m,n)=1$), we have $\phi(mn) = \phi(m)\phi(n)$

Here are some examples: 

$$
\phi(15)=\phi(3) \times \phi(5) = 2 \times 4 = 8
$$

$$
\phi(18)=\phi(2) \times \phi(3^2) = 1 \times (3^2 - 3^1) = 6
$$

Proof:

We need to show that there is a bijection between ${\mathbb{Z}_{mn}^*}$ and $\mathbb{Z}_m^* \times \mathbb{Z}_n^*$, meaning that they have the same number of elements. The number of elements in $\mathbb{Z}_{mn}^*$ is $\phi(mn)$, and the number of elements in $\mathbb{Z}_m^* \times \mathbb{Z}_n^*$ is $\phi(m)\phi(n)$. Therefore, we want to prove that $\phi(mn) = \phi(m)\phi(n)$.

We establish a mapping $f: \mathbb{Z}_{mn}^* \rightarrow \mathbb{Z}_m^* \times \mathbb{Z}_n^*$, which uniquely determines the residues $a, b$ modulo $m$ and modulo $n$, respectively. Thus, this mapping is well-defined.

**Surjective**: Since $m$ and $n$ are relatively prime, by the Chinese Remainder Theorem, for any $(a, b) \in \mathbb{Z}_m^* \times \mathbb{Z}_n^*$, consider the congruence system:

$x \equiv a \pmod{m}$

$x \equiv b \pmod{n}$

It has a unique solution $x$. Therefore, for any element in $\mathbb{Z}_m^* \times \mathbb{Z}_n^*$, there exists an $x$ such that $f(x) = (a, b)$. Thus, $f$ is surjective, meaning that the mapping covers the entire set $\mathbb{Z}_m^* \times \mathbb{Z}_n^*$.

**Injective**: Suppose we have two different elements $x_1$ and $x_2$. Then, we have $f(x_1) = f(x_2)$, which means

$(x_1 \mod m, x_1 \mod n) = (x_2 \mod m, x_2 \mod n)$

This implies $x_1 \equiv x_2 \pmod{m}$ and $x_1 \equiv x_2 \pmod{n}$. Therefore, we have $x_1 \equiv x_2 \pmod{mn}$. Thus, $x_1$ and $x_2$ are equal modulo $mn$, proving that $f$ is injective.

Since $f$ is both surjective and injective, it is a bijection. Therefore, ${\mathbb{Z}_{mn}^*}$ and $\mathbb{Z}_m^* \times \mathbb{Z}_n^*$ are in a bijective relationship, and they have the same number of elements, $\phi(mn) = \phi(m)\phi(n)$.

Based on these three properties, we can express the totient function of a large number as the product of the totient functions of its prime factorization: If $n$ has a prime factorization $p_1^{k_1}p_2^{k_2}...p_r^{k_r}$ (where $p_i$ are distinct prime factors and $k_i \geq 1$ is the exponent of $p_i$), then the value of the totient function at that point is:

$$
\phi(n) = p_1^{k_1-1}p_2^{k_2-1}...p_r^{k_r-1} (p_1 - 1)(p_2 -1)...(p_r-1) 
$$

It can also be equivalently written as:

$$
\phi(n) = n (1 - 1/p_1)(1 -1/p_2)...(1-1/p_r) 
$$

In general, since any positive integer greater than $1$ can be decomposed into the product of prime numbers, let's assume $N=\prod_{i=1}^lp_i^{\alpha_i}$, then $\varphi(N)=\prod_{i=1}^lp_i^{\alpha_i-1}(p_i-1)$. Specifically, if $N=p^\alpha$, then $\varphi(N)=p^{\alpha-1}(p-1)$. More specifically, if $N=p$, then $\varphi(N)=p-1$.

### 2.2 Code Implementation:

We can implement the Euler's totient function in Python. The code includes two functions: `prime_factors()` for prime factorization of $n$, and `euler_phi()` for calculating $\phi(n)$ using the formula:

```python
# Prime factorization is currently a challenge for large integers
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
```
