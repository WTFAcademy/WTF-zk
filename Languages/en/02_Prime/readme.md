---
title: 02. Prime Number Basics
tags:
  - zk
  - basic
  - integer
---

# WTF zk Tutorial Lesson 2: Prime Number Basics
Welcome to the second lesson of the WTF zk tutorial series! In this tutorial, we will explore the basics of prime numbers. Prime numbers play a crucial role in cryptography, making it essential to understand them for learning zero-knowledge proofs.

## 1. Definition of Prime Numbers

Prime numbers are also known as prime numbers and are defined as follows: For a natural number greater than 1, if it cannot be divided evenly by any natural number other than 1 and itself, then it is a prime number.

2, 3, 5, and 7 are all prime numbers because they can only be divided evenly by 1 and themselves. In addition, all even numbers except 2 are not prime numbers because they can be divided evenly by 2 in addition to 1 and themselves.

## 2. Properties of Prime Numbers

Prime numbers are fundamental units of all natural numbers, and the fundamental theorem of arithmetic tells us:

> Any natural number greater than 1 can be expressed as a unique product of prime numbers, regardless of the order of the prime numbers.

For example:

$$
84 = 2^2 \times 3 \times 7 
$$

Here, 2, 3, and 7 are prime numbers, and this factorization is unique.

Prime Number Theorem: The number of prime numbers less than or equal to N is approximately $N/\ln{N}$, and there are infinitely many prime numbers.

Proof:

Euclidean proof

1. **Assume a Finite Number of Prime Numbers:** First, assume that there are a finite number of prime numbers, which we denote as $p_1, p_2, \ldots, p_n$.

2. **Construct a New Number:** Consider the new number $N = p_1 \times p_2 \times \ldots \times p_n + 1$, which is obtained by multiplying all known prime numbers and adding 1.

3. **Properties of the New Number:** The number N is obviously a prime number because it is not a multiple of any known prime number, as dividing it by any known prime number leaves a remainder of 1.

4. **Contradiction:** Hence, this leads to a contradiction, because if N is not a prime number, it must have a prime factor, which either is a known prime number or a new prime number different from the known prime numbers.

5. **Conclusion:** In any case, this results in a contradiction with the initial assumption of a finite number of prime numbers. Therefore, the initial assumption is incorrect, and there must be infinitely many prime numbers.

## 3. Prime Numbers and Composite Numbers

We can classify natural numbers into prime numbers and composite numbers. Composite numbers are the complements of prime numbers: For a natural number greater than 1, if it has factors other than 1 and itself, it is a composite number. For example, 4, 6, 8, and 9 are composite numbers.

## 4. Finding Prime Numbers

Finding prime numbers is an important task in number theory, which has attracted attention since medieval times. People tried to find prime number formulas (formulas that can generate prime numbers only) during that time. By the time of Gauss, it was basically confirmed that simple prime number formulas do not exist. Therefore, Gauss believed that primality testing is a fairly difficult problem. Since then, this problem has attracted a large number of mathematicians. Primality testing algorithms can be divided into two main categories: deterministic algorithms and probabilistic algorithms. The former provides a definite result but is usually slower, while the latter provides a result that may vary.

### Deterministic Algorithms

- [Sieve of Eratosthenes](https://en.wikipedia.org/wiki/Sieve_of_Eratosthenes)

The most commonly used method is the Sieve of Eratosthenes. Its logic is very simple: first, determine a range to search, then eliminate all multiples of prime numbers between 0 and $\sqrt n$, leaving behind all prime numbers within the range.

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

- [Lucas-Lehmer Primality Test](https://en.wikipedia.org/wiki/Lucas-Lehmer_test)
- [AKS Primality Test](https://en.wikipedia.org/wiki/AKS_primality_test)

### Probabilistic Algorithms

- Fermat Primality Test
  - Uses [Fermat's Little Theorem](../07_Exp/readme.md) for testing.
- [Miller-Rabin Primality Test](https://en.wikipedia.org/wiki/Miller%E2%80%93Rabin_primality_test)

## 5. Applications of Prime Numbers in Cryptography

Prime numbers play a significant role in the field of cryptography, particularly in public-key cryptography. For example, RSA (Rivest-Shamir-Adleman) is an asymmetric encryption algorithm that uses the product of large prime numbers as part of the public and private keys: Calculating the product of prime numbers is simple, but factoring a large composite number into prime factors is extremely difficult, ensuring the security of the RSA encryption algorithm.

## 6. Conclusion

In this tutorial, we have learned the basics of prime numbers, including their definition, properties, and methods for finding prime numbers. Prime numbers have important applications in both mathematics and cryptography, laying the foundation for understanding zero-knowledge proofs.
