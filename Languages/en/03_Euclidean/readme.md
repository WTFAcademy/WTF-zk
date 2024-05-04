---
title: 03. Euclidean Algorithm
tags:
  - zk
  - basic
  - euclidean
---

# WTF zk Tutorial Lesson 3: Euclidean Algorithm

In this tutorial, we will learn about the greatest common divisor (GCD) and its calculation using the Euclidean Algorithm, which has wide applications in cryptography.

## 1. Greatest Common Divisor

### 1.1 Definition

The greatest common divisor (GCD) is the largest positive integer that can simultaneously divide both integers. For example, the GCD of 10 and 15 is 5, which can be written as:

$$
\gcd(10, 15) = 5
$$


### 1.2 Properties of the Greatest Common Divisor

For natural numbers $a$ and $b$ (assuming $a > b$), the GCD has the following properties:

1. Commutative property: $\gcd(a, b) = \gcd(b, a)$

2. The GCD of $a$ and $b$ is also the GCD of the remainder when $a$ is divided by $b$: $\gcd(a, b) = \gcd(b, a \bmod b)$

3. The GCD of $a$ and 0 is $a$: $\gcd(a, 0) = a$

4. If $b$ divides $a$ (denoted as $b \mid a$), then $\gcd(a, b) = b$

You can try to derive these properties.

### 1.3 How to Calculate the Greatest Common Divisor

We commonly use two methods to calculate the greatest common divisor: prime factorization and the Euclidean Algorithm. Let's first introduce the prime factorization method, which consists of three steps:

1. Prime factorization: Perform prime factorization for the two integers, $a$ and $b$, separately.

2. Identify common prime factors: Compare the prime factors of the two numbers and identify the ones they have in common.

3. Multiply to obtain the greatest common divisor: Multiply the common prime factors to obtain the GCD.

For example, let's calculate the GCD of $a = 30$ and $b = 24$. First, perform prime factorization:

$$
30 = 2 \times 3 \times 5
$$


$$
24 = 2^3 \times 3
$$

The common factors are $2 \times 3$, so the GCD is 6.

However, prime factorization of large numbers can be very difficult. The Euclidean Algorithm is a more efficient method for calculating the GCD.

## 2. Euclidean Algorithm

The Euclidean Algorithm (also known as division algorithm) is a commonly used algorithm for calculating the GCD of two integers.

### 2.1 Basic Idea

Let $a$ and $b$ be two integers, where $a \geq b$. Using Euclidean division, we have:

$$
a = bq + r
$$

where $q$ and $r$ are natural numbers, and $0 \leq r \lt |b|$.

According to the properties of the greatest common divisor (Property 2 in section 1.2), $\gcd(a, b) = \gcd(b, r)$, and since $r < b \leq a$, we can transform the problem of finding the GCD between two large numbers to finding the GCD between two smaller numbers. When $r \neq 0$, we can continuously replace $a$ with $b$ and $b$ with $r$, applying the Euclidean division:

$$
b = rq_1 + r_1
$$

$$
...
$$

$$
r_{i-2} = r_{i-1}q_{i} + r_i
$$


$$
...
$$

$$
r_{n-2} = r_{n-1}q_{n} + r_n
$$

During the iteration, the GCD has the following relation:

$$
\gcd(a, b) = \gcd(b, r) = ... = \gcd(r_{n-2}, r_{n-1}) = \gcd(r_{n-1}, r_{n})
$$

Since $0 \leq r_n < r_{n-1} < r$, the value of $r_n$ decreases with each iteration until $r_n = 0$.

When $r_n = 0$, according to the property of the GCD (Property 3 in Section 1.2), we have: 

$$
\gcd(r_{n-1}, r_n) = \gcd(r_{n-1}, 0) = r_{n-1}
$$

Therefore, the GCD $\gcd(a, b) = r_{n-1}$.

### 2.2 Algorithm Steps

1. Let $r$ be the remainder when $a$ is divided by $b$, i.e. $r = a \mod b$.
2. If $r$ is not zero, replace $a$ with $b$, and $r$ with $b$, and return to step 1.
3. If $r$ is zero, $b$ is the GCD.

### 2.3 Example

Let's calculate the GCD of $a = 30$ and $b = 24$:

1. Step 1: Apply the Euclidean division, $30 = 1 \cdot 24 + 6$.

2. Step 2: Since the remainder $r = 6$ is not zero, replace $a$ with $b$, and $r$ with $b$, and continue with the Euclidean division: $24 = 4 \cdot 6 + 0$.

3. Step 3: The remainder in the previous step, $r = 0$, is zero. Stop the iteration. The GCD is $\gcd(30, 24) = 6$.

### 2.4 Intuitive Understanding

Suppose we have a rectangular room with length $a$ and width $b$. The room wants to be tiled with square tiles, and each side of the square tiles should be as long as possible. This maximum side length is actually the GCD $\gcd(a, b)$, and the Euclidean method allows us to find it:

First, we try to tile the rectangle with $b \times b$ square tiles. However, this leaves a leftover rectangle with dimensions $r \times b$, where $r < b$. Then, we try to tile the remaining rectangle with $r \times r$ square tiles, which leaves another residual rectangle with dimensions $r_1 \times r$. We continue this process by attempting to tile each leftover rectangle with $r_i \times r_i$ square tiles. When there is no residual rectangle left, i.e., when the square tiles completely cover the previous leftover rectangle, the sequence ends. The side length of the smallest square tile is the GCD $\gcd(a, b)$.

![Image from Wikipedia](./img/3-1.gif)

### 2.5 Code Implementation

We can implement the Euclidean Algorithm using Python with just 6 lines of code:

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
print(f'The greatest common divisor of {num1} and {num2} is {gcd_result}')
# Output: The greatest common divisor of 30 and 24 is 6
```

## 3. Summary

The greatest common divisor is crucial in cryptography, and the Euclidean Algorithm is a commonly used algorithm to solve the GCD of integers. By understanding this algorithm, we have laid the foundation for further learning zero-knowledge proofs and cryptography.
