---
title: 01. Integer Arithmetic Basics
tags:
  - zk
  - basic
  - integer
---

# WTF zk Tutorial Lesson 1: Integer Arithmetic Basics

As a beginner-friendly tutorial on zero-knowledge proofs, we will start by learning the basics of integer arithmetic. Most of you have probably learned this in secondary school, so it should be quite easy. We will also reproduce integer arithmetic using Python, so even beginners can quickly get started.

For those who haven't used Python before, it is recommended to install [Anaconda](https://www.anaconda.com/download) to install and manage the Python environment.

## 1. Basic Definitions

An integer is a number without a decimal part and can be either positive, negative, or zero. We use $\mathbb{Z}$ to represent the set of all integers.

$$
\mathbb{Z} = \lbrace \ldots, -3, -2, -1, 0, 1, 2, 3, \ldots \rbrace
$$

For an integer $a \in \mathbb{Z}$, we use $\lvert a \rvert$ to represent the absolute value of $a$, which is the non-negative value of $a$ regardless of its sign.

$$
\lvert 69 \rvert = 69
$$

$$
\lvert -69 \rvert = 69
$$

We often use the natural numbers $\mathbb{N}$, which are a subset of integers and include all positive integers.

$$
\mathbb{N} = \lbrace 1, 2, 3, \ldots \rbrace
$$

In addition, we sometimes use non-negative integers, which we denote as $\mathbb{N_0}$:

$$
\mathbb{N_0} = \lbrace 0, 1, 2, 3, \ldots \rbrace
$$

> Note: Some textbooks include 0 in the set of natural numbers, and there is currently [debate](https://zh.wikipedia.org/wiki/%E8%87%AA%E7%84%B6%E6%95%B0) on whether 0 should be included.

## 2. Integer Arithmetic

Integer arithmetic includes addition, subtraction, multiplication, and division. Let's review the rules for these basic operations:

- **Addition ( $+$ ):** For integers $a$ and $b$, their sum $a + b$ is the result of adding them together.

    ```python
    a, b = 7, 5
    sum_result = a + b
    print(f'Addition example: {sum_result}')
    # Addition example: 12
    ```

- **Subtraction ( $-$ ):** For integers $a$ and $b$, their difference $a - b$ is the result of subtracting $b$ from $a$.

    ```python
    diff_result = a - b
    print(f'Subtraction example: {diff_result}')
    # Subtraction example: 2
    ```

- **Multiplication ( $\times$ ):** For integers $a$ and $b$, their product $a \times b$ is the result of multiplying them together.

    ```python
    product_result = a * b
    print(f'Multiplication example: {product_result}')
    # Multiplication example: 35
    ```


## 3. Properties of Integers

Integers have some important properties:

- **Closure:** Integer addition and multiplication are closed operations within the set of integers, meaning that the sum or product of any two integers is still an integer.

- **Commutativity:** Integer addition and multiplication are commutative, meaning that $a + b = b + a$ and $a \times b = b \times a$ hold true for any integers $a$ and $b$.

- **Associativity:** Integer addition and multiplication are associative, meaning that $(a + b) + c = a + (b + c)$ and $(a \times b) \times c = a \times (b \times c)$ hold true for any integers $a$, $b$, and $c$.

## 4. Euclidean Division

The division we commonly use is real number division, where the result of dividing two integers may not be an integer, e.g., $7 \div 5 = 1.4$ is not an integer. Therefore, we introduce integer division, also known as Euclidean Division. It has two components: quotient and remainder. The definition of Euclidean Division is as follows:

For integers $a$ and $b$ (where $b \neq 0$), there exists a unique pair of integers $(q, r)$ such that $a = bq + r$, where $q$ is the quotient, $r$ is the remainder, and $0 \leq r \lt |b|$.

If the remainder when dividing $a$ by $b$ is zero, we say that $a$ is divisible by $b$ ($b$ divides $a$) and write $b \mid a$. We can also call $b$ a factor of $a$. If the remainder is not zero, we write $b \nmid a$.

We can implement Euclidean Division in Python, taking care to handle the case when $a$ or $b$ is negative: the `divmod` function in Python allows for negative remainders, whereas Euclidean Division requires $0 \leq r \lt |b|$. On the contrary, the modulo operation (`%`) in Python allows for negative numbers. Here, it is necessary to understand the internal implementation formula for the modulo operation in programming languages: $a\%b=a-(a//b) * b$. (The `//` here is Python's internal implementation of Euclidean Division, ensuring a positive remainder less than the divisor).

```python
def euclidean_division(a, b):
    quotient, remainder = divmod(a, b)
    if remainder < 0:
        # Adjust the remainder to ensure it is non-negative
        remainder += abs(b)
        # Adjust the quotient to maintain the equation
        quotient += 1
    return quotient, remainder

quotient, remainder = euclidean_division(a, b)
print(f'Division example: quotient is {quotient}, remainder is {remainder}')
# Division example: quotient is 1, remainder is 2
```

## 5. Summary

In this lesson, we introduced the basics of integers, including their definitions and basic operations (addition, subtraction, multiplication, and Euclidean Division), and implemented them using Python. We believe that most of you have learned these concepts in secondary school and find them straightforward. Let's continue the WTF zk journey!