---
title: 06. Modular Division
tags:
  - zk
  - basic
  - modular arithmetic
  - modular inverse
  - modular division
---

# WTF zk Tutorial Lesson 6: Modular Division

There is a significant difference between division in modular arithmetic and ordinary integer division, and it is crucial to understand it. In this tutorial, we will introduce modular division, modular inverse, and methods for calculating the inverse.

## 1. Division

In the previous tutorial, we introduced addition and multiplication in modular arithmetic, which are similar to ordinary addition and multiplication. However, division in modular arithmetic is very different from ordinary division. If we apply integer division to modular arithmetic, we will get strange results. For example, we know that $6 \equiv 12 \pmod{3}$, but if we divide both sides by $3$, we get $2 \equiv 4 \pmod{3}$, which is obviously not true. Therefore, ordinary division does not work, and we must define division in modular arithmetic differently.

In general, division is the inverse operation of multiplication and can reverse the effect of multiplication. For example, in modulo $n$, if we have $xy \equiv z$, then the result of $z/y$ should be $x$. In other words, in modular arithmetic, computing the division of $z$ by $y$ is finding an integer $x$ that satisfies $xy \equiv z$.

For example, to calculate $4/2 \mod 5$, we can find that $2 \cdot 2 \equiv 4 \pmod{5}$ through an exhaustive search, so the result of the equation is $2$.

To better define and calculate division in modular arithmetic, we will now introduce modular inverse.

## 2. Modular Inverse

The modular inverse is defined as follows: If there exists an integer $w$ such that $wy \equiv 1 \pmod{n}$, we call $w$ the inverse of $y$ modulo $n$, denoted as $y^{-1}$.

The inverse exists only when $y$ and $n$ are coprime (i.e., $\gcd(y,n)=1$).

With the inverse, we can convert modular division $x/y$ into multiplication $xy^{-1}$ for calculation.

### 2.1 Methods for Calculating the Inverse

So, how do we calculate the inverse of $y$ modulo $n$? In this tutorial, we introduce two commonly used methods:

#### 2.1.1 Exhaustive Search

In modular arithmetic, $Z_n$ contains only a finite number of elements, so we can exhaustively search these elements to find $w \in Z_n$ such that $wy \equiv 1 \pmod{n}$ holds, and $w$ will be the inverse $y^{-1}$ we are looking for. For example, to find the inverse of $2$ modulo $5$, we can calculate the product of all elements in $Z_5$ with 2 and then calculate the remainder when divided by $5$. We can find the value where the remainder is $1$. As shown below, we find that $2^{-1} \equiv 3 \pmod{5}$.

| $Z_5$ Element | Multiplication with 2 | Remainder |
| ------------- | --------------------- | --------- |
| 0             | 0                     | 0         |
| 1             | 2                     | 2         |
| 2             | 4                     | 4         |
| 3             | 6                     | 1         |
| 4             | 8                     | 3         |

#### 2.1.2 Extended Euclidean Algorithm

In the previous tutorials, we learned that the extended Euclidean algorithm can be used to calculate the coefficients that satisfy the Bezout's identity. In fact, it can also be used to calculate the inverse, which is more efficient than an exhaustive search.

When the inverse `w` of `y` exists, $\gcd(y, n)=1$, and we can construct a Bezout's identity:

$$
kn + wy = 1
$$

By moving $kn$ to the right side of the equation, we get:

$$
wy = 1 - kn
$$

In other words,

$$
wy \equiv 1 \pmod{n}
$$

Therefore, the $w$ in the equation is the inverse of $y$, and we can solve it using the extended Euclidean algorithm.

For example, we can use this method to find the inverse of $y = 7$ modulo $n = 69$, as shown in the following code (you can also try calculating it manually).

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
y = 7
n = 69
gcd_result, k, w = extended_euclidean_algorithm(n, y)
if gcd_result == 1:
    print(f'The greatest common divisor of {n} and {y} is {gcd_result}, the inverse exists, which is {w}')
else:
    print(f'The greatest common divisor of {n} and {y} is {gcd_result}, the inverse does not exist')

# The greatest common divisor of 69 and 7 is 1, the inverse exists, which is 10
```

By using the extended Euclidean algorithm, we obtain $y^{-1} = 10$. It can be verified that $yy^{-1} = 70$, and when divided by $69$, the remainder is $1$, which satisfies the definition of the inverse.

Here is the recursive version of the extended Euclidean algorithm implemented in code to calculate the modular inverse:

```python
def get_inverse(a, N):
    if gcd(a, N) == 1:
        x, y = ext_gcd(a, N)
        return (x + N) % N
    print("No inverse!")
    return 0
```

Now, please try to solve the following problem:

$$
6/9 \pmod{23} = ?
$$

## Summary

In this tutorial, we introduced the concepts of division and inverse in modular arithmetic, and two methods for calculating the inverse: exhaustive search and the extended Euclidean algorithm. There is a significant difference between division in modular arithmetic and ordinary integer division, and everyone need to practice and become familiar with it.
