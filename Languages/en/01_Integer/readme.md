---
title: 01. Basic Integer Operations
tags:
  - zk
  - basic
  - integer
---

# WTF zk Tutorial Lecture 1: Basic Integer Operations

As a beginner-friendly tutorial on zero-knowledge proofs, we will start by learning the basics of integer arithmetic. Most of you have probably learned this in secondary school, so it should be quite easy. We will also implement integer arithmetic using Python, making it easy for beginners to get started.


If you are new to Python, we recommend installing [Anaconda](https://www.anaconda.com/download) to easily set up and manage your Python environment.

## 1. Basic Definitions

An integer is a whole number without a decimal part. It can be positive, negative, or zero. We use the symbol $\mathbb{Z}$ to represent the set of all integers.

$$
\mathbb{Z} = \lbrace \ldots, -3, -2, -1, 0, 1, 2, 3, \ldots \rbrace
$$

For an integer $a \in \mathbb{Z}$, the absolute value of $a$, denoted as $\lvert a \rvert$, represents the non-negative value of $a$ without considering its sign.

$$
\lvert 69 \rvert = 69
$$

$$
\lvert -69 \rvert = 69
$$

We often use the term "natural numbers" to refer to positive integers. It is a subset of the set of integers and includes all positive integers.

$$
\mathbb{N} = \lbrace 1, 2, 3, \ldots \rbrace
$$

Additionally, we sometimes refer to non-negative integers as $\mathbb{N_0}$:

$$
\mathbb{N_0} = \lbrace 0, 1, 2, 3, \ldots \rbrace
$$

> Note: The inclusion of 0 in the set of natural numbers is a topic of debate. Some textbooks include 0, while others do not. (Source: [Wikipedia](https://en.wikipedia.org/wiki/Natural_number))

## 2. Integer Operations

Integer operations include addition, subtraction, multiplication, and division. Let's review the rules for these basic operations:

- **Addition ($+$):** To add two integers $a$ and $b$, simply sum them up.
    
    ```python
    a, b = 7, 5
    sum_result = a + b
    print(f'Example: {sum_result}')
    # Example: 12
    ```

- **Subtraction ($-$):** To subtract an integer $b$ from another integer $a$, subtract $b$ from $a$.
    
    ```python
    diff_result = a - b
    print(f'Example: {diff_result}')
    # Example: 2
    ```

- **Multiplication ($\times$):** To multiply two integers $a$ and $b$, multiply them together.
    
    ```python
    product_result = a * b
    print(f'Example: {product_result}')
    # Example: 35
    ```


## 3. Properties of Integers

Integers have some important properties:

- **Closure Property:** Integer addition and multiplication are closed within the set of integers. This means that the sum or product of any two integers will still be an integer.

- **Commutative Property:** Integer addition and multiplication are commutative. This means that the order of the integers does not affect the result. For any integers $a$ and $b$, $a + b = b + a$ and $a \times b = b \times a$.

- **Associative Property:** Integer addition and multiplication are associative. This means that the grouping of integers does not affect the result. For any integers $a$, $b$, and $c$, $(a + b) + c = a + (b + c)$ and $(a \times b) \times c = a \times (b \times c)$.

## 4. Euclidean Division

The division we commonly use is real number division, where the result of dividing two integers may not be an integer, e.g., $7 \div 5 = 1.4$ is not an integer. Therefore, we introduce integer division, also known as Euclidean Division. Its result consists of two parts: the quotient and the remainder. The definition of Euclidean Division is as follows:

For integers $a$ and $b$ (where $b \neq 0$), there exists a unique pair of integers $(q, r)$ such that $a = bq + r$. Here, $q$ represents the quotient, $r$ represents the remainder, and $0 \leq r \lt |b|$.

If the remainder of $a$ divided by $b$ is zero, we say that $a$ is divisible by $b$ ($b$ divides $a$), denoted as $b \mid a$. We can also say that $b$ is a factor of $a$. If the remainder is not zero, we denote it as $b \nmid a$.

We can implement Euclidean Division in Python. When implementing it, we need to handle the cases where $a$ or $b$ is negative. The `divmod` function in Python allows for negative remainders, but Euclidean Division requires the remainder to be non-negative and less than the divisor. On the other hand, the modulo operation (`%`) in Python allows for negative remainders. It is necessary to understand the internal implementation formula of the modulo operation in programming languages: $a\%b=a-(a//b) * b$ (where `//` represents the internal implementation of Euclidean Division in Python, ensuring that the remainder is positive and less than the divisor).

```python
def euclidean_division(a, b):
    quotient, remainder = divmod(a, b)
    if remainder < 0:
        # Adjust the remainder to ensure it is non-negative
        remainder += abs(b)
        # Adjust the quotient to maintain the equation's validity
        quotient += 1
    return quotient, remainder

quotient, remainder = euclidean_division(a, b)
print(f'Example: Quotient is {quotient}, Remainder is {remainder}')
# Example: Quotient is 1, Remainder is 2
```

## 5. Summary

In this lesson, we introduced the basics of integers, including their definitions and basic operations (addition, subtraction, multiplication, and Euclidean Division), and implemented them using Python. These concepts are usually covered in middle school and are relatively simple. Now, let's continue our journey into the world of Zero-Knowledge Proofs (ZKPs)!