---
title: Milestone 01. RSA Algorithm
tags:
  - zk
  - basic
  - cryptography
  - rsa
---

# WTF zk Tutorial Milestone 01: RSA Algorithm

This tutorial introduces the classic RSA encryption algorithm and provides implementations in Python and Solidity. The RSA algorithm's security is based on mathematical problems in number theory, which were covered in the first 10 lessons of the WTF zk series. By the end of this tutorial, you will have a deeper understanding of these concepts.

## 1. Background

The RSA (Rivest–Shamir–Adleman) algorithm was invented by Ron Rivest, Adi Shamir, and Leonard Adleman in 1977 and is named after their initials. (Note: Clifford Cocks, a mathematician at the Government Communications Headquarters (GCHQ) in the UK, proposed a similar system in an internal document in 1973. However, his research remained classified until 1997 due to its involvement with top-secret information.)

- **Public-key Cryptography:**
  - Limitations of symmetric-key cryptography:
    - Key distribution: It requires the negotiation of encryption keys through a secret and secure channel, which is difficult to achieve in practice.
    - Key management: In a network with n users, each pair of users needs to share a secret encryption key, resulting in a total of n(n-1)/2 keys to manage.

  - The beauty of public-key cryptography lies in the use of computational complexity to design encryption algorithms. The RSA algorithm is one of the earliest encryption schemes to separate public and private keys, allowing encryption without the need to share the private key. This makes it more flexible and secure.

- **Security:**
The security of RSA is based on the difficulty of solving mathematical problems in number theory. Many public-key cryptographic systems are constructed based on mathematical problems that are difficult to solve, such as the factorization problem, quadratic residue problem, and discrete logarithm problem.
  - Factorization problem: Given a large integer, write it as a product of prime numbers.
  - Quadratic residue problem: Let n = pq be the product of two large primes, randomly choose a ∈ QR_n, find x such that x^2 ≡ a (mod n).
  - Discrete logarithm problem: Let g be a primitive root of Z_p^*, given an element y ∈ Z_p^*, find the unique x, 1 ≤ x ≤ p-1, such that g^x ≡ y (mod p). x is called the discrete logarithm of y modulo p with base g.

- **Widespread Applications:**
It has been almost 50 years since the invention of RSA, and it is still widely used in encryption communication, digital certificates, identity verification, and other fields.

![](./img/MS01-1.png)

## 2. Algorithm Steps

The RSA algorithm consists of 3 steps: key generation, encryption with the public key, and decryption with the private key. Let's explain each step in detail.

![](./img/MS01-2.png)

### Step 1: Key Generation

Key generation is the first step of the RSA algorithm, where a pair of public and private keys are generated.

1. **Choose two large prime numbers, p and q:** Randomly select two large prime numbers and calculate their product, n = p * q.
2. **Calculate Euler's totient function, φ(n):** φ(n) = (p-1) * (q-1).
3. **Choose an encryption exponent, e:** Select an integer e that is coprime with φ(n). It is usually chosen to be a prime number.
4. **Calculate the decryption exponent, d:** Calculate an integer d that satisfies d * e ≡ 1 (mod φ(n)).

Finally, the public key is (n, e), and the private key is (n, d).

### Step 2: Encrypt the Message

The encryption process uses the public key to convert the plaintext message M into an integer (M < n), then calculates:

C ≡ M^e (mod n)

The ciphertext C is the encrypted result.

### Step 3: Decrypt the Message

The decryption process uses the private key to calculate the plaintext message M from the ciphertext C:

M ≡ C^d (mod n)

The decrypted result M is the original plaintext message.

## 3. Example

In this section, let's familiarize ourselves with the RSA algorithm using a simple example that can be calculated by hand.

First, we choose two prime numbers (p, q) = (5, 7). Then, the modulus n = pq = 35, and Euler's totient function φ(n) = (p-1)(q-1) = 24.

Next, we choose a public key e = 5 that is coprime with φ(n) = 24 for encryption. We calculate the private key d using the extended Euclidean algorithm to satisfy ed ≡ 1 (mod φ(n)), which gives us d = 5.

Now, let's choose a message M = 4 and encrypt it using the RSA algorithm. We calculate the ciphertext C = M^e = 4^5 = 9 (mod 35).

Finally, we decrypt the ciphertext to obtain the original message M by calculating M = C^d = 9^5 = 4 (mod 35).

## 4. Algorithm Logic

When we encounter RSA, we may have two questions:

1. Why does the decryption process M ≡ C^d (mod n) restore the ciphertext to plaintext?

2. Why is the RSA encryption algorithm secure?

In this section, we will explore these two questions.

### Question 1: Decryption Logic

To understand the decryption steps of RSA, we need to prove that M ≡ C^d (mod n), where C ≡ M^e (mod n). We will use Euler's theorem.

First, let's expand the original equation:

C^d ≡ (M^e (mod n))^d ≡ M^(ed) (mod n)

Since ed ≡ 1 (mod φ(n)), we have ed = kφ(n) + 1, where k ∈ Z. Substituting this into the equation, we have:

C^d ≡ M^(kφ(n) + 1) ≡ M^(kφ(n)) M (mod n)

Assuming gcd(M, n) = 1 (when M and n are not coprime, we need to use a different proof method, see [Wikipedia link](https://en.wikipedia.org/wiki/RSA_(cryptosystem)#Proofs_of_correctness)), according to Euler's theorem, M^φ(n) = 1. Therefore, the equation can be simplified to:

C^d ≡ 1^k M ≡ M (mod n)

Q.E.D.

In other words, the decryption process only requires calculating the ciphertext raised to the power of d modulo n to restore the correct plaintext.

### Question 2: Security

The security of the RSA algorithm is based on the difficulty of factoring large prime numbers. Although the algorithm has been around for nearly 50 years, it is still considered secure when the key length is greater than 2048 bits. In this section, let's discuss why it is difficult to break the RSA algorithm from a hacker's perspective.

#### Attack Method 1: Factorization of n

If we can effectively factorize n into p and q, we can easily calculate φ(n) = (p-1)(q-1) and the private key d, thereby breaking the RSA algorithm. There are several factorization algorithms available, including the quadratic sieve, elliptic curve algorithm, and number field sieve. However, the complexity of these algorithms is exponential. Therefore, with the current computing power, no one can effectively factorize n into p and q. However, with the advent of quantum computers, the complexity of prime factorization is reduced to polynomial time by the quantum algorithm [Shor's algorithm](https://en.wikipedia.org/wiki/Shor%27s_algorithm), which directly threatens the RSA algorithm. Therefore, many cryptographers are researching post-quantum cryptographic algorithms. The main technical routes for post-quantum cryptographic algorithms include hash-based, code-based, multivariate, lattice-based, and homomorphic encryption.

#### Attack Method 2: Computing φ(n) without factoring n

This problem is not easier than factoring n because if you can compute φ(n), you can easily factor n. This is because:

φ(n) = (p-1)(q-1) = pq-p-q+1 = n - (p+q) + 1

If you can compute φ(n) and n is public, you can calculate p+q. Similarly, you can calculate p-q by computing the square root of (p+q)^2 - 4n. By calculating p and q, you have effectively factorized n. However, since factoring n is difficult, computing φ(n) is also difficult.

#### Attack Method 3: Computing the private key d directly

This method is as difficult as factoring large integers: calculating the private key d from the equation de ≡ 1 (mod φ(n)) without knowing φ(n). However, this method is as difficult as factoring large integers because once you have calculated d, you can calculate a multiple of φ(n) through de - 1, and there are methods to effectively factorize large integers based on multiples of φ(n).

## 5. Code Implementation

This section provides implementations of the RSA algorithm in both Python and Solidity.

### 5.1 Python

The `generate_keypair`, `encrypt`, and `decrypt` functions implement the key generation, encryption, and decryption processes of the RSA algorithm.

> Note that this RSA implementation is only for educational purposes and is not secure. In practice, additional techniques (such as padding) and longer keys (greater than 2048 bits) should be used.

```python
import random

# Prime number test function, this method has high complexity. If you are interested, you can learn about the faster Miller-Rabin algorithm.
def is_prime(num):
    if num < 2:
        return False
    for i in range(2, int(num**0.5) + 1):
        if num % i == 0:
            return False
    return True

def gcd(a, b):
    while b:
        a, b = b, a % b
    return a

def modinv(a, b):
    m0, x0, x1 = b, 0, 1
    while a > 1:
        q = a // b
        a, b = b, a % b
        x0, x1 = x1 - q * x0, x0
    return x1 + m0 if x1 < 0 else x1

def generate_keypair():
    p, q = random_prime(), random_prime()
    n = p * q
    phi = (p - 1) * (q - 1)
    e = random.randint(2, phi - 1)
    while gcd(e, phi) != 1:
        e = random.randint(2, phi - 1)
    d = modinv(e, phi)
    return ((n, e), (n, d))

def random_prime():
    while True:
        num = random.randint(100, 999)
        if is_prime(num):
            return num

def encrypt(message, public_key):
    n, e = public_key
    return pow(int(message), e, n)

def decrypt(ciphertext, private_key):
    n, d = private_key
    return pow(ciphertext, d, n)

# Example
message = 123
public_key, private_key = generate_keypair()
encrypted_message = encrypt(message, public_key)
decrypted_message = decrypt(encrypted_message, private_key)

print("Original Message:", message)
print("Encrypted Message:", encrypted_message)
print("Decrypted Message:", decrypted_message)
print("Public key:", public_key)
print("Private key:", private_key)

## Output example
# Original Message: 123
# Encrypted Message: 124872
# Decrypted Message: 123
# Public key: (141727, 52447)
# Private key: (141727, 19423)
```

### 5.2 Solidity

EVM has a built-in modular exponentiation operation in the precompiled contract at address 0x05, which we can use to handle modular exponentiation operations in RSA encryption and decryption. However, key generation is more complex, so we won't include it in the contract.

You can deploy this contract on the blockchain to verify the correctness of the encryption and decryption steps in the Python program.

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract RSA {
    // The precompiled contract address for modular exponentiation is 0x05, details: https://www.evm.codes/precompiled#0x05?fork=shanghai

    // Encrypt with the public key
    function encrypt(uint message, uint e, uint n) public returns (uint) {
        // RSA encryption: cipher = message^e mod n
        return modExp(message, e, n);
    }

    // Decrypt with the private key
    function decrypt(uint cipher, uint d, uint n) public returns (uint) {
        // RSA decryption: message = cipher^d mod n
        return modExp(cipher, d, n);
    }

    function modExp(uint256 base, uint256 exponent, uint256 modulus) public returns (uint256 result) {
        assembly {
            // Free memory pointer
            let pointer := mload(0x40)

            // Length of base, exponent, and modulus. 0x20 == 32 bytes
            mstore(pointer, 0x20)
            mstore(add(pointer, 0x20), 0x20)
            mstore(add(pointer, 0x40), 0x20)

            // Define variables base, exponent, and modulus
            mstore(add(pointer, 0x60), base)
            mstore(add(pointer, 0x80), exponent)
            mstore(add(pointer, 0xa0), modulus)

            // Save the result
            let value := mload(0xc0)

            // Call the precompiled contract 0x05 = bigModExp
            if iszero(call(not(0), 0x05, 0, pointer, 0xc0, value, 0x20)) {
                revert(0, 0)
            }

            // Return the result
            result := mload(value)
        }
    }
}
```

## 6. Summary

In this tutorial, we learned about the classical RSA algorithm, understood its principles and security, and implemented it in Python and Solidity. This milestone marks the end of the number theory introduction in the WTF zk series. Next, we will briefly venture into abstract algebra!