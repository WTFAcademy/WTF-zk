---
title: 04. Extended Euclidean Algorithm
tags:
  - zk
  - basic
  - euclidean
---

# WTF zk Tutorial Lesson 4: Extended Euclidean Algorithm

In this tutorial, we will delve into an extension of the Euclidean algorithm that not only calculates the greatest common divisor but also finds the integer solutions that satisfy Bézout's equation.

## 1. Bézout's Equation

Before introducing the extended Euclidean algorithm, let's first understand Bézout's equation. For two integers $a$ and $b$, there exist integers $x$ and $y$ that satisfy the following equation:

$$
ax + by = \gcd(a, b)
$$

This equation is known as Bézout's equation, where $\gcd(a, b)$ is the greatest common divisor of $a$ and $b$. The goal of the extended Euclidean algorithm is to find such integers $x$ and $y$.

## 2. Extended Euclidean Algorithm

### 2.1 Basic Idea

The extended Euclidean algorithm not only calculates the greatest common divisor using the Euclidean algorithm but also finds the integer solutions that satisfy Bézout's equation through reverse deduction. In the Euclidean algorithm, we only care about the remainder $r_i$ of each iteration and not the quotients $q_i$. The extended algorithm uses $q_i$ to calculate the Bézout's equation backwards, effectively utilizing what would otherwise be discarded.

Let's recall the Euclidean algorithm:

$$
a = bq_0 + r_0
$$

$$
b = r_0q_1 + r_1
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

We continue iterating until $r_n$ = 0, at which point $r_{n-1}= \gcd(a,b)$ and we have:

$$
r_{n-2} = \gcd(a,b) q_{n}
$$

$$
r_{n-3} = r_{n-2} q_{n-1}  +  \gcd(a,b)
$$

$$
...
$$

$$
a = bq + r
$$

Where all the $q_i$ are known. Therefore, we can continuously expand and express $r, ..., r_{n-2}$ as linear combinations of $a$ and $b$, ultimately expressing $\gcd(a,b)$ as a linear combination of $a$ and $b$, which yields Bézout's equation.

We will now derive the extended Euclidean algorithm using both iterative and recursive methods.

### 2.2 Iterative Derivation

#### 2.2.1 Iterative Formula

First, let's express the remainder $r_i$ obtained from each iteration as a linear combination of $a$ and $b$. For the $i$-th iteration with remainder $r_i$, let there exist integers $x_i$ and $y_i$ that satisfy the following equation:

$$
x_i a + y_i b=r_i
$$

Since $r_{n-1}=\gcd(a,b)$, we have:

$$
x_{n-1} a + y_{n-1} b=\gcd(a,b)
$$

Therefore, $(x_{n-1}, y_{n-1} )$ is the pair $(x,y)$ that satisfies Bézout's equation. Our goal is to iteratively compute these values.

From the equation $r_{i-2} = r_{i-1}q_{i} + r_i$, we can derive:

$$
r_i = r_{i-2} - r_{i-1}q_{i}
$$

Expanding $r_{i-2}$ and $r_{i-1}$ as linear combinations of $a$ and $b$, we have:

$$
r_i = (x_{i-2} - x_{i-1}q_{i}) a + (y_{i-2} - y_{i-1}q_{i}) b
$$

Thus, we obtain the iterative relationship between $(x_i, y_i)$ and $(x_{i-2},x_{i-1},y_{i-2},y_{i-1})$ :

$$
x_i = x_{i-2} - x_{i-1}q_{i}
$$

$$
y_i = y_{i-2} - y_{i-1}q_{i}
$$

#### 2.2.2 Initial Conditions

With the iterative relationship established, the next step is to determine the initial conditions. For the first iteration, we have:

$$
r_0 = a - q_0b
$$

In other words, $x_0 = 1$, $y_0 = -q_0$. This implies:

$$
1 = x_{-2} -q_0 x_{-1}
$$

$$
-q_0 = y_{-2} -q_0 y_{-1}
$$

Therefore, we can derive the initial conditions as $(x_{-2}, x_{-1}, y_{-2}, y_{-1}) = (1, 0, 0, 1)$.

We then continue iterating $(x_i, y_i)$ using the Euclidean algorithm:

$$
x_i = x_{i-2} - x_{i-1}q_{i}
$$

$$
y_i = y_{i-2} - y_{i-1}q_{i}
$$

The final result $(x_{n-1}, y_{n-1})$ obtained is the pair $(x,y)$ that satisfies Bézout's equation.

#### 2.2.3 Example

Let's compute the integers $x$ and $y$ that satisfy Bézout's equation for $a=30$ and $b=24$:

$$
ax + by = \gcd(a, b)
$$

1. Step 1: Initialize $(x_{-2}, x_{-1}, y_{-2}, y_{-1}) = (1, 0, 0, 1)$.

2. Step 2: Apply the Euclidean division to obtain:

$$
30 = 1 \cdot 24 + 6
$$

Here, $(q_0, r_0) = (1, 6)$. Substituting into the iteration equations $(x_i, y_i)$, we have:

$$
x_0 = 1 - 1 \times 0 = 1
$$

$$
y_0 = 0 - 1 \times 1 = -1
$$

At this point, we have $x_i a + y_i b=r_i$ equal to $30-24$, which equals $6$, and the equation holds.

3. Step 3: Since the remainder $r$($r=6$) is non-zero, replace $a$ with $b$ and $b$ with $r$, and continue with the Euclidean division:

$$
24 = 4 \cdot 6 + 0
$$

Here, $(q_1, r_1) = (4, 0)$. Since the remainder is $0$, we stop iterating. The greatest common divisor is $\gcd(30,24)=6$, and the pair $(x, y) = (x_0, y_0)=(1, -1)$ satisfies Bézout's equation.

4. Step 4: We obtain the coefficients $(x, y) =(1, -1)$ that satisfy Bézout's equation:

$$
a - b = 6
$$

### 2.3 Recursive Derivation

We want to find $x$ and $y$ such that $x\cdot a+y\cdot b=gcd(a, b)$.

When $b = 0$, obviously $x = 1, y=0$.

When $b\neq 0$, we have $gcd(a, b)=gcd(b, a\% b)$. For the left-hand side, $gcd(a, b)=ax + by$ ; for the right-hand side, $gcd(b, a\% b)=bx_1+(a\% b)\cdot y_1=bx_1+(a-(a//b)\cdot b)\cdot y_1=ay_1+b(x_1-(a//b)\cdot y_1)$. The correspondence between the left-hand side and the right-hand side is $x=y_1, y=(x_1-(a//b)\cdot y_1)$. This completes the derivation.

### 2.4 Code Implementation

Let's implement the extended Euclidean algorithm in Python:

#### Iterative Version

```python
def extended_euclidean_algorithm(a, b):
    x1, y1, x2, y2 = 1, 0, 0, 1

    while b:
        q = a // b
        a, b = b, a % b
        x1, x2 = x2, x1 - q * x2
        y1, y2 = y2, y1 - q * y2

    return a, x1, y1

# Example
num1 = 30
num2 = 24
gcd_result, x, y = extended_euclidean_algorithm(num1, num2)
print(f'The greatest common divisor of {num1} and {num2} is {gcd_result}')
print(f'The integer solutions that satisfy Bézout\'s equation are: {num1}*{x} + {num2}*{y} = {gcd_result}')
```

#### Recursive Version

```python
def ext_gcd(a, b):
    if b == 0:
        return 1, 0
    else:
        x, y = ext_gcd(b, a%b)
        x, y = y, x - (a//b) * y
        return x, y
```

## 3. Applications

The extended Euclidean algorithm has wide-ranging applications, including:

- **Multiplicative Inverse:** The main application of the extended Euclidean algorithm is calculating the multiplicative inverse modulo N, as explained in the next tutorial.
- **RSA Algorithm:** In the RSA asymmetric encryption algorithm, the extended Euclidean algorithm is used to generate the private key, ensuring it satisfies certain mathematical relationships.
- **Solving Congruence Equations:** In number theory, the extended Euclidean algorithm is commonly used to solve congruence equations of the form $ax \equiv 1 \pmod{m}$, where $a$ and $m$ are coprime.

## 4. Summary

In this tutorial, we introduced Bézout's equation and the extended Euclidean algorithm. The extended Euclidean algorithm has widespread applications, and mastering it will lay the foundation for our future in-depth study of zero-knowledge proofs.
