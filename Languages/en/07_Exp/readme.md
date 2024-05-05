---
title: 07. Fermat's Little Theorem
tags:
  - zk
  - basic
  - chinese remainder theorem
---

# Tutorial 07: Fermat's Little Theorem

In the previous tutorial, we introduced addition, subtraction, multiplication, and division in modular arithmetic. In this tutorial, we will introduce modular exponentiation and Fermat's Little Theorem.

## 1. Modular Exponentiation

Modular exponentiation is the operation of exponentiation performed on a modulus and is widely used in cryptography:

$$
b = a^c \mod{n}
$$

where $0 \le b < n$.

For example, given $(a, c, n) = (7, 5, 13)$, we can calculate that $7^5=16807$, which when divided by 13 leaves a remainder of 11, so $b = 11$.

Modular exponentiation can also be written in congruence form:

$$
b \equiv a^c \pmod{n}
$$

### 1.1 Optimization Algorithm

Computing $a^c$ can require a significant amount of memory, while the result of the modular operation, $0 \le b < n$, can be much smaller. Therefore, we can optimize memory usage by leveraging the properties of modular arithmetic.

According to modular arithmetic, we have:

$$
x \cdot y \mod{n} = (x \mod{n})  \cdot (y \mod{n}) \mod{n}
$$

If both $x$ and $y$ are large, we can first perform the modulus operation on them and then perform the multiplication to save memory. Additionally, exponentiation can be expressed as repeated multiplication:

$$
a^c \mod{n} = a \cdot a \cdot a \cdot ... \mod{n} 
$$

Therefore, we can multiply $a$ at each step and then take the modulus, reducing the number in each step, and continue this process until the operation is completed.

$$
a^c \mod{n} = (((a \cdot a \mod{n}) \cdot a \mod{n}) \cdot ... )\mod{n} 
$$

Let's take $(a, c, n) = (7, 5, 13)$ as an example:

1. In the first step, we calculate $7 * 7 \mod{13} =10$.

2. In the second step, we calculate $10 * 7 \mod{13} = 5$.

3. In the third step, we calculate $5 * 7 \mod{13} = 9$.

4. In the fourth step, we calculate $9 * 7 \mod{13} = 11$, and we are done. Therefore, $b = 11$.

## 1.2 Code Implementation

We can implement the optimized algorithm for modular exponentiation in Python as follows:

```python
def mod_pow(base, exponent, modulus):
    result = 1

    # Expand the exponent into binary form and process each bit from high to low
    while exponent > 0:
        # If the current bit is 1, multiply by the current base and then take the modulus
        if exponent % 2 == 1:
            result = (result * base) % modulus
        # Square the base and then take the modulus
        base = (base * base) % modulus
        # Right shift by one bit, equivalent to dividing by 2
        exponent //= 2

    return result

# Example: calculate (7^5) % 13
a = 7
c = 5
n = 13
result = mod_pow(a, c, n)
print(f"{a}^{c} mod {n} = {result}")
# 7^5 mod 13 = 11
```

## 2. Fermat's Little Theorem

Fermat's Little Theorem is an important theorem in number theory that provides a powerful tool for solving modular exponentiation problems.

### 2.1 Definition

Fermat's Little Theorem states that if $p$ is a prime number, then for any integer $a$, we have

$$
a^{p} \equiv a \pmod{p}
$$

In other words, $a^p -a$ is divisible by $p$. For example, when $a = 3$ and $p = 5$, we have $3^5 - 3 = 240 = 48 \cdot 5$.

Fermat's Little Theorem can also be written in another form. When $a$ is coprime to $p$, we can divide both sides of the equation by $a$ to obtain the following form:

$$
a^{p-1} \equiv 1 \pmod{p}
$$

In other words, $a^{p-1} -1$ is divisible by $p$. For example, when $a = 3$ and $p = 5$, we have $3^4 -1 = 80 = 16 \cdot 5$.

### 2.2 Proof

First, we need to prove that the following equation holds for prime numbers $p$:

$$
(x+y)^p \equiv x^p +y^p \pmod{p}
$$

We expand the original equation using the binomial theorem. Except for $x^p$ and $y^p$, all other terms contain $p$ and can be eliminated by dividing by $p$:

$$
(x+y)^p \equiv  x^p +y^p + p(...) \equiv x^p +y^p \pmod{p}
$$

By induction, we can obtain:

$$
(x_1 + ... + x_n)^p \equiv x_1^p + ... + x_n^p \pmod{p}
$$

If we expand $a$ as $a$ ones added together $a = 1+ ... +1$, and substitute it into the above equation, we have:

$$
a^p \equiv (1 + ... + 1)^p \equiv 1^p + ... + 1^p \equiv a \pmod{p}
$$

Therefore, the proof is complete.

### 2.3 Applications
#### 2.3.1 Calculating Modular Inverses

Fermat's Little Theorem can also be used to calculate modular inverses. If $p$ is a prime number and $a$ is not divisible by $p$, then $a^{p-2}$ is the modular inverse of $a$ modulo $p$. In other words:

$$
a \cdot a^{p-2} \equiv 1 \pmod{p}
$$

For example, when $a = 3$ and $p = 5$, the modular inverse of $a$ is $3^{5-2} \equiv 27 \equiv 2 \pmod{5}$.

#### 2.3.2 Primality Testing

Fermat's Little Theorem can be used for probabilistic primality testing. For a given prime number $p$, randomly choose an integer $a$ and check if it satisfies $a^{p-1} \equiv 1 \pmod{p}$. If it does not satisfy the equation, then $p$ is definitely not a prime number; if it satisfies the equation, then $p$ may be a prime number. However, it should be noted that there are pseudoprimes, which are numbers that are not prime but pass the test.

## 3. Summary

In this tutorial, we introduced modular exponentiation and Fermat's Little Theorem. Fermat's Little Theorem is a very useful tool in number theory and cryptography, with a wide range of applications. By understanding Fermat's Little Theorem in depth, we can better apply it to solve mathematical problems related to primality testing, modular inverses, and more.