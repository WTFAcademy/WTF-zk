---
title: 03. Greatest Common Divisor and Euclidean Algorithm
tags:
  - zk
  - basic
  - euclidean
---

# WTF zk Tutorial Lesson 03: Greatest Common Divisor and Euclidean Algorithm

In this tutorial, we will learn about the concept of the greatest common divisor (GCD) and how to calculate it using the Euclidean Algorithm. Understanding these concepts is essential in cryptography.

## 1. Greatest Common Divisor

### 1.1 Definition

The greatest common divisor (GCD) is the largest positive integer that divides two integers without leaving a remainder. For example, the GCD of 10 and 15 is 5, which can be written as:

$$
\gcd(10, 15) = 5
$$

### 1.2 Properties of GCD

The GCD of two natural numbers a and b (assuming a > b) has the following properties:

1. Commutative property: $\gcd(a, b) = \gcd(b, a)$

2. The GCD of a and b is also the GCD of b and the remainder when a is divided by b: $\gcd(a, b) = \gcd(b, a \mod b)$

3. The GCD of a and 0 is equal to a: $\gcd(a, 0) = a$

4. If b divides a (denoted as $b \mid a$), then $\gcd(a, b) = b$

You can try to prove these properties yourself.

### 1.3 How to Calculate GCD

There are two commonly used methods to calculate the GCD: prime factorization and the Euclidean Algorithm. Let's first introduce the prime factorization method, which consists of three steps:

1. Prime factorization: Perform prime factorization on the given integers a and b.

2. Find common prime factors: Compare the prime factors of both numbers and find the common factors.

3. Multiply to obtain the GCD: Multiply the common prime factors to obtain the GCD.

For example, let's calculate the GCD of a = 30 and b = 24. First, perform prime factorization:

$$
30 = 2 \cdot 3 \cdot 5
$$

$$
24 = 2^3 \cdot 3
$$

The common factors are 2 and 3, so the GCD of a and b is 6.

However, prime factorization of large numbers can be difficult. The Euclidean Algorithm provides a more efficient method for calculating the GCD.

## 2. Euclidean Algorithm

The Euclidean Algorithm (also known as the division algorithm) is a commonly used algorithm for calculating the GCD of two integers.

### 2.1 Basic Idea

Let's assume we have two integers a and b, where a ≥ b. Using the Euclidean division, we can express a as:

$$
a = bq + r
$$

where q and r are natural numbers, and $0 \leq r \lt |b|$.

According to the properties of the GCD (mentioned in section 1.2, property 2), we have $\gcd(a, b) = \gcd(b, r)$. Since $r < b \leq a$, we can transform the problem of finding the GCD between two large numbers into finding the GCD between two smaller numbers. When r ≠ 0, we can repeatedly replace a with b and b with r using the Euclidean division:

$$
b = rq_1 + r_1
$$

$$
...
$$

$$
r_{i-2} = r_{i-1}q_i + r_i
$$

$$
...
$$

$$
r_{n-2} = r_{n-1}q_n + r_n
$$

During the iteration, the GCD has the following relationship:

$$
\gcd(a, b) = \gcd(b, r) = ... = \gcd(r_{n-2}, r_{n-1}) = \gcd(r_{n-1}, r_n)
$$

Since $0 \leq r_n < r_{n-1} < r$, the value of r decreases with each iteration until r_n = 0.

When r_n = 0, according to the properties of the GCD (mentioned in section 1.2, property 3), we have:

$$
\gcd(r_{n-1}, r_n) = \gcd(r_{n-1}, 0) = r_{n-1}
$$

Therefore, the GCD $\gcd(a, b) = r_{n-1}$.

### 2.2 Algorithm Steps

The Euclidean Algorithm can be implemented with the following steps:

1. Let r be the remainder when a is divided by b, i.e., $r = a \mod b$.
2. If r is not zero, replace a with b, replace b with r, and go back to step 1.
3. If r is zero, b is the GCD.

### 2.3 Example

Let's calculate the GCD of a = 30 and b = 24:

1. Step 1: Using the Euclidean division, we have 30 = 1 * 24 + 6.
2. Step 2: Since the remainder r = 6 is not zero, we replace a with b, b with r, and continue with the Euclidean division: 24 = 4 * 6 + 0.
3. Step 3: The remainder r = 0 is zero, so we stop the iteration. The GCD of 30 and 24 is $\gcd(30, 24) = 6$.

### 2.4 Intuitive Understanding

Suppose we have a rectangular room with length $a$ and width $b$. We want to tile the room with square tiles, and each side of the square tiles should be as long as possible. The maximum side length is actually the GCD $\gcd(a, b)$, and the Euclidean method allows us to find it:


First, we try to cover the rectangle with b × b square tiles. However, this leaves a remaining rectangle with dimensions r × b, where r < b. Then, we try to cover the remaining rectangle with r × r square tiles, leaving another remaining rectangle with dimensions r1 × r. We continue this process, trying to cover the remaining rectangles with smaller and smaller square tiles. When there is no remaining rectangle, i.e., when the square tiles completely cover the previous remaining rectangle, the sequence ends. The side length of the smallest square tile is the GCD.

![Image from Wikipedia](./img/3-1.gif)

### 2.5 Code Implementation

We can implement the Euclidean Algorithm in Python with just 6 lines of code:

```python
def euclidean_algorithm(a, b):
    if a < b:
        a, b = b, a
    while b:
        a, b = b, a % b
    return a

# Example
num1 = 30
num2 = 24
gcd_result = euclidean_algorithm(num1, num2)
print(f'The GCD of {num1} and {num2} is {gcd_result}')
# Output: The GCD of 30 and 24 is 6
```

## 3. Summary

The greatest common divisor (GCD) is an important concept in cryptography, and the Euclidean Algorithm is a commonly used algorithm for finding the GCD of integers. By understanding this algorithm, we have laid the foundation for further learning about zero-knowledge proofs and cryptography.