---
title: 19. Discrete Logarithm Problem
tags:
  - zk
  - abstract algebra
  - group theory
  - primitive root
  - DLP
  - discrete logarithm problem
---

# Introduction to Discrete Logarithm Problem

In this lecture, we will explore the concept of primitive roots and the discrete logarithm problem. The discrete logarithm problem is a fundamental concept in cryptography and serves as the basis for many cryptographic algorithms.

### 1. Multiplicative Order

We often discuss primitive roots in the context of the multiplicative group $Z_n^*$ modulo $n$. Before we dive into the definition of primitive roots, let's first understand the concept of multiplicative order.

**Definition of multiplicative order:** In the group $Z_n^*$, the multiplicative order of an element $a$ is the smallest positive integer $k$ such that $a^k \equiv 1 \mod n$. The multiplicative order is denoted as $\text{ord}_n(a)$.

In simpler terms, the multiplicative order is the minimum number of times an element needs to be multiplied by itself to obtain the identity element of the group.

For example, in the multiplicative group $Z_5^* = \{1,2,3,4\}$, we can observe that the multiplicative order of $4$ is $2$:

- $4^1 \equiv 4 \mod 5$
- $4^2 \equiv 1 \mod 5$

## 2. Primitive Roots

Now, let's move on to the concept of primitive roots.

**Definition of primitive roots:** In the multiplicative group $Z_n^*$, an element $g$ is called a primitive root if all powers of $g$ can generate all elements in the group $Z_n^*$.

In other words, for every $a \in Z_n^*$, there exists an integer $k$ such that $g^k \equiv a \mod n$.

The concept of primitive roots is closely related to the generator of a cyclic group. While the multiplicative group modulo $n$ may not always be a cyclic group, when it is a cyclic group, the primitive root serves as its generator. Therefore, the properties of generators can also be applied to primitive roots. The multiplicative order of a primitive root is equal to the order of $Z_n^*$, which is denoted as $\phi(n)$.

For example, consider the multiplicative group $Z_7^* = \{1, 2, 3, 4, 5, 6\}$. We can observe that $3$ is a primitive root:

- $3^1 \equiv 3 \mod 7$
- $3^2 \equiv 2 \mod 7$
- $3^3 \equiv 6 \mod 7$
- $3^4 \equiv 4 \mod 7$
- $3^5 \equiv 5 \mod 7$
- $3^6 \equiv 1 \mod 7$

In this example, the powers of $3$ generate all elements in the group $Z_7^*$.

Let's consider another example: the multiplicative group $Z_8^* = \{1, 3, 5, 7\}$. If we calculate the powers of the elements：

- $1^1 \equiv 1 \mod 8$
- $3^1 \equiv 3 \mod 8$，$3^2 \equiv 1 \mod 8$
- $5^1 \equiv 5 \mod 8$，$5^2 \equiv 1 \mod 8$
- $7^1 \equiv 7 \mod 8$，$7^2 \equiv 1 \mod 8$
 we can see that no power of any element can generate the entire group. Therefore, $Z_8^*$ does not have a primitive root and is not a cyclic group.

### 2.1 Properties of Primitive Roots

**Property 1: Existence of primitive roots:** A primitive root exists in $Z_n^*$ if and only if $n$ is of the form $2, 4, p^k, 2p^k$, where $p$ is an odd prime number and $k$ is a positive integer.

The proof of this property is complex and beyond the scope of this tutorial. It is sufficient to remember the conclusion.

Here are a few examples: $Z_5^*$ has a primitive root, such as $2$; $Z_7^*$ also has a primitive root, such as $3$. Both of them are cyclic groups. On the other hand, $Z_8^*$ does not have a primitive root and is not a cyclic group because $8 = 2^3$, which does not fit the form $n = 2, 4, p^k, 2p^k$.

**Property 2: Number of primitive roots:** When $Z_n^*$ has a primitive root (i.e., $n = 2, 4, p^k, 2p^k$), the number of primitive roots is $\phi(\phi(n))$.

<details><summary>Click to expand the proof👀</summary>

Assume that $g$ is a primitive root of $Z_n^*$ and its order is equal to the order of the group $Z_n^*$, which is $\phi(n)$. According to Property 5 of the order of a cyclic group, the number of generators is $\phi(\phi(n))$. Proof completed.

</details>

Here are a few examples: $Z_5^*$ has $\phi(\phi(5)) = \phi(4) = 2^2-2$ generators.

**Property 3: Corollary of the number of primitive roots:** When $p$ is a prime number, the number of primitive roots in $Z_p^*$ is $\phi(p-1)$.

<details><summary>Click to expand the proof👀</summary>

When $p$ is a prime number, $\phi(p) = p-1$. According to the previous property, the number of primitive roots in $Z_p^*$ is $\phi(p-1)$.

</details>

**Property 4: Relationship between multiplicative order and Euler's totient function:** For $a \in Z_n^*$, we have $\text{ord}_n(a)|\phi(n)$.

<details><summary>Click to expand the proof👀</summary>

The order of $Z_n^*$ is $\phi(n)$. According to Property 6 of the order of a cyclic group, the order of the element $a$ divides the order of the group, i.e., $\text{ord}_n(a)|\phi(n)$. Proof completed.

</details>

## 3. Discrete Logarithm

The discrete logarithm is usually discussed in the multiplicative group $Z^*_n$ modulo $n$. When $n = 2, 4, p^k, 2p^k$, $Z^*_n$ is a cyclic group and has a primitive root.

For the group $Z^*_n$, with the primitive root $g$ and the element $a$, the discrete logarithm $\log_gb$ is the value of $x$ that satisfies $g^x \equiv a$, denoted as $x = \log_gb$.

### 3.1 Properties of Discrete Logarithm

**Property 1: Relationship between discrete logarithm and Euler's totient function:** For the group $Z^*_n$, if $\gcd(g,n) = 1$, then $a \equiv g^r \pmod{n}$ if and only if $\log_ga=r \pmod{\phi(n)}$, which means the discrete logarithm is congruent to $r$ modulo $\phi(n)$.

<details><summary>Click to expand the proof👀</summary>

**Necessity**

Let $x = \log_ga$. According to $a \equiv g^r \pmod{n}$, we have $g^x \equiv g^r \pmod{n}$. According to Euler's theorem: if the integer $a$ and the positive integer $n$ are coprime (i.e., $\gcd(g,n)=1$), then $g^{\phi(n)} \equiv 1 \pmod{n}$. In other words, we can multiply $g^{\phi(n)}$ anywhere in the equation, and the congruence relationship still holds. For any integer $k$, we have $g^x \equiv g^r g^{k\phi(n)} \equiv g^{r +k\phi(n)}\pmod{n}$, which means $x = r +k\phi(n)$, i.e., $x \equiv r \pmod{\phi(n)}$. Proof completed.

**Sufficiency**

If $x \equiv r \pmod{\phi(n)}$, i.e., $x = r + k\phi(n)$, we have $g^x \equiv g^{r + k\phi(n)} \equiv g^{r} g^{k\phi(n)} \pmod{n}$ holds. According to Euler's theorem, $g^{\phi(n)} = 1$, so $g^x \equiv g^r \pmod{n}$.

</details>

For example, in $Z^*_5$, with the primitive root $2$,Euler's totient function is $\phi(5) = 4$, we have $4 \equiv 2^2 \pmod{5}$. Therefore, $4 \equiv 2^6 \pmod{5}$ and $4 \equiv 2^{10} \pmod{5}$ also hold. You can add or subtract multiples of $\phi(n)$ to the exponent, and the congruence relationship still holds modulo $n$.

This property can be used to simplify the calculation of modular exponentiation. For $Z^*_7$, with the primitive root $3$, we have $\phi(7) = 6$. Therefore, $3^{100} \equiv 3^{100 \pmod{6}} \equiv 3^{4 \pmod{6}} \equiv 81 \equiv 4 \pmod{7}$.

## 4. Discrete Logarithm Problem

The Discrete Logarithm Problem (DLP) involves finding the discrete logarithm $x$ such that $a \equiv g^x \pmod{p}$, where $p$ is a prime number in the group $Z^*_p$, given the generator $g$ and the element $a$. This problem is computationally difficult, and no efficient algorithm is currently known to solve it in polynomial time.

### 4.1 Difficulty of the Problem

Forward calculation is easy: Given $a$ and $x$, calculating $a^x$ is straightforward, and efficient algorithms exist for this.

Reverse calculation is difficult: Given $a$ and $b$, calculating $x = \log_a{b}$ is challenging due to the following reasons:

1. Non-linearity: The multiplication operation in the group is usually non-linear, and finding the exponent that satisfies the condition often requires traversing the entire group.

2. No efficient algorithm: When $p$ is a large prime number, no algorithm has been discovered that can solve the problem in polynomial time.

3. Large search space: The difficulty of the discrete logarithm problem also depends on the existence of primitive roots. When the modulus $n$ has a primitive root, the discrete logarithm problem is usually difficult because the powers of the primitive root form a complete residue system modulo $n$. Conversely, if there is no primitive root, the solution to the discrete logarithm problem may be easier to find.

Let's start with a simple example: for $Z^*_5$, find the integer $x$ that satisfies $3^x \equiv 2 \pmod{5}$. By iterating through the powers of $3$, we find:

- $3^2 \equiv 4 \pmod{5}$
- $3^3 \equiv 2 \pmod{5}$

Therefore, in $Z^*_5$, $3 = \log_3{2}$.

Here's a more challenging example: for $Z^*_{31}$, find the integer $x$ that satisfies $13^x \equiv 17 \pmod{31}$. You can try it out. As $n$ grows larger, the difficulty of the problem increases.

### 4.2 Applications in Cryptography

The discrete logarithm problem has widespread applications in cryptography, particularly in public key cryptography. Here are some examples:

1. **RSA encryption algorithm:** We introduced the [RSA algorithm](https://github.com/WTFAcademy/WTF-zk/blob/main/MS01_RSA/readme.md) in a previous course on number theory. It is an asymmetric encryption algorithm based on the difficulty of factoring large integers and the discrete logarithm problem.

2. **Diffie-Hellman key exchange:** The Diffie-Hellman key exchange protocol is a method of securely negotiating keys over an insecure channel. It is based on the discrete logarithm problem. In this protocol, two parties choose a large prime number and a generator, each selects a private key, and calculates the public key through the discrete logarithm operation on the generator. Finally, they can compute a shared secret key. The difficulty of the discrete logarithm problem ensures that even if an attacker intercepts the public information, it is difficult to deduce the private key.

3. **ElGamal encryption algorithm:** The ElGamal encryption algorithm is a public key encryption algorithm based on the discrete logarithm problem. In ElGamal encryption, the encryptor chooses a generator and a private key, and generates the public key through the discrete logarithm operation on the generator. The decryptor uses their private key to decrypt. The difficulty of the discrete logarithm problem ensures the security of the algorithm.

4. **Elliptic curve cryptography:** Elliptic curve cryptography utilizes points on an elliptic curve for encryption and digital signatures. The elliptic curve discrete logarithm problem (ECDLP) is the challenging problem of finding points on an elliptic curve. Elliptic curve cryptography provides more efficient encryption algorithms compared to traditional RSA, while maintaining the same or higher level of security.

## 5. Conclusion

In this lecture, we introduced the concept of primitive roots and the discrete logarithm problem. Primitive roots play a significant role in number theory, while the discrete logarithm problem is a challenging problem in cryptography that guarantees the security of many encryption algorithms.

With this, we conclude the content of the group theory section in the WTF zk tutorial. Next, we will delve into ring theory and field theory!