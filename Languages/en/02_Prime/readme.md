---
title: 02. Prime Number Basics
tags:
  - zk
  - basic
  - prime number
---
# WTF zk Tutorial Lecture 2: Prime Number Basics

Welcome to the second lesson of the WTF zk tutorial series! In this tutorial, we will explore the basics of prime numbers. Prime numbers play a crucial role in cryptography, making it essential to understand them for learning zero-knowledge proofs.


## 1. Definition of Prime Numbers

Prime numbers are natural numbers greater than 1 that cannot be evenly divided by any other natural number except 1 and itself. In other words, a prime number has no factors other than 1 and itself.

For example, 2, 3, 5, and 7 are prime numbers because they can only be divided evenly by 1 and themselves. On the other hand, all even numbers (except 2) are not prime numbers because they can be divided evenly by 2.

## 2. Properties of Prime Numbers

Prime numbers are the basic building blocks of all natural numbers. The fundamental theorem of arithmetic states that any natural number greater than 1 can be expressed as a unique product of prime numbers, regardless of the order of the prime numbers.

For example:

$$
84 = 2^2 \times 3 \times 7 
$$

In this example, 2, 3, and 7 are prime numbers, and this factorization is unique.

Prime Number Theorem: The number of prime numbers less than or equal to N is approximately $N/\ln{N}$, and there are infinitely many prime numbers.

Proof:

Euclidean Proof

1. **Assume a Finite Number of Prime Numbers:** Let's assume that there are only a finite number of prime numbers and denote them as $p_1, p_2, \ldots, p_n$.

2. **Construct a New Number:** Consider a new number $N = p_1 \times p_2 \times \ldots \times p_n + 1$. This number is obtained by multiplying all known prime numbers and adding 1.

3. **Properties of the New Number:** The number N is obviously a prime number because it is not divisible by any known prime number. Dividing N by any known prime number leaves a remainder of 1.

4. **Contradiction:** This leads to a contradiction because if N is not a prime number, then it must have a prime factor. This prime factor either belongs to the known prime numbers or is a new prime number different from the known ones.

5. **Conclusion:** In either case, this contradicts the initial assumption of a finite number of prime numbers. Therefore, the initial assumption is incorrect, and the number of prime numbers must be infinite.

## 3. Prime Numbers and Composite Numbers

Natural numbers can be divided into two categories: prime numbers and composite numbers. Composite numbers are the opposite of prime numbers. A composite number is a natural number greater than 1 that has factors other than 1 and itself. For example, 4, 6, 8, and 9 are all composite numbers.

## 4. Finding Prime Numbers

Finding prime numbers is an important task in number theory. This problem gained attention in the Middle Ages when people tried to find formulas that could generate prime numbers exclusively. In the era of Gauss, it was basically confirmed that simple prime formulas do not exist. Gauss believed that determining primality is a very difficult problem. Since then, many mathematicians have been fascinated by this problem. Primality testing algorithms can be divided into two categories: deterministic algorithms and random algorithms. Deterministic algorithms provide a definite result but are usually slower, while random algorithms are the opposite.

### Deterministic Algorithms

- [Sieve of Eratosthenes](https://en.wikipedia.org/wiki/Sieve_of_Eratosthenes)

The most commonly used method is the Sieve of Eratosthenes. Its logic is very simple: first, determine a range to search, then eliminate all multiples of prime numbers between 0 and $\sqrt{n}$. The remaining numbers within the range are all prime numbers.

We can implement this method in Python:

```python
def sieve_of_eratosthenes(n):
    primes = [True] * (n + 1)
    primes[0] = primes[1] = False
    for i in range(2, int(n**0.5) + 1):
        if primes[i]:
            for j in range(i * i, n + 1, i):
                primes[j] = False
    return [x for x in range(n + 1) if primes[x]]

# Example: Find all prime numbers less than or equal to 20
limit = 20
prime_numbers = sieve_of_eratosthenes(limit)
print(f'Prime numbers less than or equal to {limit}: {prime_numbers}')
# Prime numbers less than or equal to 20: [2, 3, 5, 7, 11, 13, 17, 19]
```

- [Lucas-Lehmer Primality Test](https://en.wikipedia.org/wiki/Lucas%E2%80%93Lehmer_primality_test)
- [AKS Primality Test](https://en.wikipedia.org/wiki/AKS_primality_test)

### Random Algorithms

- Fermat Primality Test
  - Test using [Fermat's Little Theorem](../07_Exp/readme.md).
- [Miller-Rabin Primality Test](https://en.wikipedia.org/wiki/Miller%E2%80%93Rabin_primality_test)

## 5. Application of Prime Numbers in Cryptography

Prime numbers play a crucial role in cryptography, especially in public-key cryptography. For example, RSA (Rivest-Shamir-Adleman) is an asymmetric encryption algorithm that uses the product of large prime numbers as part of the public and private keys. Calculating the product of prime numbers is simple, but factoring large composite numbers into prime factors is very difficult. This difficulty ensures the security of the RSA encryption algorithm.

## 6. Summary

In this tutorial, we have learned the basics of prime numbers, including their definition, properties, and methods for finding prime numbers. Prime numbers have important applications in mathematics and cryptography, laying the foundation for our understanding of zero-knowledge proofs.