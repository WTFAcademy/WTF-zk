# WTF zk Tutorial 07: Fermat's Little Theorem

Previously we introduced addition, subtraction, multiplication, and division in modular arithmetic. In this tutorial, we will introduce modular exponentiation and Fermat's Little Theorem.

## 1. Modular Exponentiation

Modular exponentiation refers to the operation of raising a number to a power modulo n, which is commonly used in cryptography:

$$
b = a^c \mod{n}
$$

when $0 \leq b < n$.

For example, given $(a, c, n) = (7, 5, 13)$, we can calculate $7^5=16807$, which leaves a remainder of 11 when divided by 13, so $b = 11$.

Of course, modular exponentiation can also be expressed in congruence form:

$$
b \equiv a^c \pmod{n}
$$

### 1.1 Optimized Algorithm

$a^c$ can be a very large number, taking up a lot of memory in a computer, while the result of modular arithmetic is $0 \leq b < n$. Therefore, we can save memory by utilizing the properties of modular arithmetic.

According to modular arithmetic, we have:

$$
x \cdot y \mod{n} = (x \mod{n}) \cdot (y \mod{n}) \mod{n}
$$

If both x and y are large, we can first perform the modulo operation and then multiply, saving memory usage. Exponentiation can be expanded into repeated multiplication:

$$
a^c \mod{n} = a \cdot a \cdot a \cdot ... \mod{n}
$$

Therefore, we can multiply a by a and then take modulo in each step, transforming the product into a smaller number, and continue to multiply a and take modulo until the operation is complete:

$$
a^c \mod{n} = (((a \cdot a \mod{n}) \cdot a \mod{n}) \cdot ... )\mod{n}
$$

Taking $(a, c, n) = (7, 5, 13)$ as an example:

1. In the first step, calculate $7 * 7 \mod{13} = 10$.

2. In the second step, calculate $10 * 7 \mod{13} = 5$.

3. In the third step, calculate $5 * 7 \mod{13} = 9$.

4. In the fourth step, calculate $9 * 7 \mod{13} = 11$, and it is finished. Therefore, $b = 11$.

## 1.2 Code Implementation

We implement the optimized algorithm for modular exponentiation in Python:

```python
def mod_pow(base, exponent, modulus):
    result = 1

    # Expand the exponent into binary form and process each bit from highest to lowest
    while exponent > 0:
        # If the current bit is 1, multiply it by the current base and then take modulo
        if exponent % 2 == 1:
            result = (result * base) % modulus
        # Square the base and then take modulo
        base = (base * base) % modulus
        # Right shift one bit, which is equivalent to dividing by 2
        exponent //= 2

    return result

# Example: Calculate (7^5) % 13
a = 7
c = 5
n = 13
result = mod_pow(a, c, n)
print(f"{a}^{c} mod {n} = {result}")
# 7^5 mod 13 = 11
```

## 2. Fermat's Little Theorem

Fermat's Little Theorem is an important theorem in number theory, providing a powerful tool for solving modular exponentiation problems.

### 2.1 Definition

Fermat's Little Theorem states that if p is a prime numbers, then for any integer a:

$$
a^{p} \equiv a \pmod{p}
$$

In other words, $a^p -a$ is divisible by p. For example, for $a = 3$ and $p = 5$, we have $3^5 - 3 = 240 = 48 \cdot 5$.

Fermat's Little Theorem can also be written in another form. When a is coprime with p, we can divide both sides of the equation by a to get the following form:

$$
a^{p-1} \equiv 1 \pmod{p}
$$

In other words, $a^{p-1} -1$ is divisible by p. For example, for $a = 3$ and $p = 5$, we have $3^4 -1 = 80 = 16 \cdot 5$.

### 2.2 Proof

First, we need to prove that the following equation holds for prime number p:

$$
(x+y)^p \equiv x^p +y^p \pmod{p}
$$

We expand the equation using the binomial theorem. Except for $x^p$ and $y^p$, the remaining terms contain p and can be canceled by dividing by p:

$$
(x+y)^p \equiv  x^p +y^p + p(...) \equiv x^p +y^p \pmod{p}
$$

By induction, we can obtain:

$$
(x_1 + ... + x_n)^p \equiv x_1^p + ... + x_n^p \pmod{p}
$$

If we expand a as a sum of a's, $a = 1+ ... +1$, and substitute it into the equation, we have:

$$
a^p \equiv (1 + ... + 1)^p \equiv 1^p + ... + 1^p \equiv a \pmod{p}
$$

Proof is complete.

### 2.3 Applications

#### 2.3.1 Calculation of Modular Inverse

Fermat's Little Theorem can also be used to calculate the modular inverse. If p is a prime number and a is not divisible by p, then $a^{p-2}$ is the modular inverse of a modulo p. That is:

$$
a \cdot a^{p-2} \equiv 1 \pmod{p}
$$

For example, for $a = 3$ and $p = 5$, the modular inverse of a is $3^{5-2} \equiv 27 \equiv 2 \pmod{5}$.

#### 2.3.2 Primality Testing

Fermat's Little Theorem can be used for probabilistic primality testing. For a given prime number p, randomly choose an integer a and check if it satisfies $a^{p-1} \equiv 1 \pmod{p}$. If it does not, then p is definitely not prime; if it does, then p is potentially prime. However, it is important to note that there exist pseudoprimes, which are numbers that pass the test but are not prime.

## 3. Summary

In this tutorial, we introduced modular exponentiation and Fermat's Little Theorem. Fermat's Little Theorem is a very useful tool in the fields of number theory and cryptography, with a wide range of applications. By understanding Fermat's Little Theorem deeply, we can better apply it to solve mathematical problems related to primality testing, modular inverses, and more.
