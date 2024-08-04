---
title: Milestone 01: RSA Algorithm
tags:
  - zk
  - basic
  - cryptography
  - rsa
---

# WTF zk Tutorial Milestone 01: RSA Algorithm

In this tutorial, we will introduce the classic RSA encryption algorithm and implement it in Python and Solidity. The RSA algorithm relies on mathematical problems in number theory, which we have discussed in the first 10 lessons of WTF zk. This tutorial will deepen your understanding of these concepts.

## 1. Background

The RSA (Rivest–Shamir–Adleman) algorithm was invented by Ron Rivest, Adi Shamir, and Leonard Adleman in 1977, and it is named after their initials. (PS: A mathematician named Clifford Cocks at the Government Communications Headquarters (GCHQ) in the UK proposed a similar system in an internal document in 1973. However, his research remained classified until 1997.)

- **Public Key Cryptography:** 
  - Limitations of Private Key Cryptography:
    - Key Distribution: The encryption key needs to be negotiated through a secure channel, which is difficult to implement in practice.
    - Key Management: In a network with $n$ users, each pair of users needs to share a secret key, resulting in a total of $n(n-1)/2$ keys to manage.

  - The brilliance of public key cryptography lies in designing encryption algorithms based on computational complexity. The RSA algorithm is one of the earliest encryption algorithms that separated the public and private keys. It allows encryption without the need to share the private key, making it more flexible and secure.

- **Security:** 
The security of the RSA algorithm is based on the mathematical difficulty of certain problems, such as factoring large numbers and computing discrete logarithms.
  
- **Widespread Applications:** 
RSA is still widely used in encryption communication, digital certificates, identity verification, and many other fields, despite being invented almost 50 years ago.

![](./img/MS01-1.png)

## 2. Algorithm Steps

The RSA algorithm consists of three steps: key generation, encryption using the public key, and decryption using the private key. Let's explain each step in detail.

![](./img/MS01-2.png)

### Step 1: Key Generation

Key generation is the first step of the RSA algorithm, where a pair of public and private keys are generated.

1. **Choose two large prime numbers, $p$ and $q$:** Randomly select two large prime numbers and compute their product $n = p \times q$.
2. **Calculate Euler's totient function $\phi(n)$:** $\phi(n) = (p-1) \times (q-1)$.
3. **Choose an encryption exponent $e$:** Choose an integer $e$ that is coprime with $\phi(n)$, usually a prime number.
4. **Calculate the decryption exponent $d$:** Calculate an integer $d$ that satisfies $d \times e \equiv 1 \pmod{\phi(n)}$.

Finally, the public key is $(n, e)$ and the private key is $(n, d)$.

### Step 2: Encrypting the Message

The encryption process uses the public key to convert the plaintext message $M$ into an integer ($M < n$). Then, using the public key $(n, e)$, compute:

$$
C \equiv M^e \pmod{n}
$$

The ciphertext $C$ is the encrypted result.

### Step 3: Decrypting the Message

The decryption process uses the private key to compute the plaintext message $M$ from the ciphertext $C$ using the private key $(n, d)$:

$$
M \equiv C^d \pmod{n}
$$

The decrypted message $M$ is the original plaintext.

## 3. Example

In this section, we will use a simple example to familiarize ourselves with RSA encryption.

First, let's choose two prime numbers $(p, q) = (5, 7)$. Then, the modulus $n = pq = 35$ and Euler's totient function $\phi(n) = (p-1)(q-1) = 24$.

Next, choose a public key $e = 5$ that is coprime with $\phi(n) = 24$ for encryption. Use the extended Euclidean algorithm to calculate the private key $d$ that satisfies $ed \equiv 1 \pmod{24}$ for decryption. In this case, $d = 5$.

Now, let's choose a message $M = 4$ and encrypt it using the RSA algorithm. The ciphertext $C$ is calculated as $C = M^e = 4^{5} = 9 \pmod{35}$.

Finally, to decrypt the ciphertext, we only need to compute $M = C^d = 9^5 = 4 \pmod{35}$.

## 4. Algorithm Logic

When you see RSA, you may have two questions:

1. Why does the decryption process $M \equiv C^d \pmod{n}$ recover the plaintext from the ciphertext?
2. Why is the RSA encryption algorithm secure?

In this section, we will explore these two questions.

### Question 1: Decryption Logic

To understand the decryption step of RSA, we need to prove $M \equiv C^d \pmod{n}$, where $C \equiv M^e \pmod{n}$. We will use Euler's theorem.

First, let's expand the original equation:

$$
C^d  \equiv (M^e \pmod{n})^d \equiv M^{ed} \pmod{n}
$$

Since $ed \equiv 1 \pmod{\phi(n)}$, we have $ed = k\phi(n) + 1$, where $k \in \mathbb{Z}$. Substituting this into the equation, we have:

$$
C^d \equiv M^{k\phi(n) + 1} \equiv M^{k\phi(n)} M \pmod{n}
$$

Assuming $\gcd(M, n)=1$ (when $M$ and $n$ are not coprime, we need to use another proof method, see [Wikipedia link](<https://en.wikipedia.org/wiki/RSA_(cryptosystem)#Proofs_of_correctness>) ), according to Euler's theorem, we have $M^{\phi(n)} = 1$. Therefore, the equation can be simplified as:

$$
C^d \equiv 1^k M \equiv M \pmod{n}
$$

Proof complete.

In other words, the decryption step only requires computing the ciphertext raised to the power of $d$ modulo $n$ to recover the correct plaintext.

### Question 2: Security

The security of the RSA algorithm is based on the difficulty of factoring large prime numbers. Although the algorithm has been around for nearly 50 years, it is still considered secure when the private key length is greater than 2048 bits. In this section, we will explore why the RSA algorithm is difficult to crack from a hacker's perspective.

#### Attack Method 1: Factorize $n$

If we can factorize $n$ into $p$ and $q$, we can easily calculate $\phi(n)=(p-1)(q-1)$ and the private key $d$, thereby breaking the RSA algorithm. There are several factorization algorithms, such as the Quadratic Sieve, Elliptic Curve Method, and Number Field Sieve, but their computational complexity is exponential. Therefore, with the current computing power, no one can effectively factorize $n$ into $p$ and $q$. However, with the advent of quantum computers, the quantum algorithm [Shor's algorithm](https://en.wikipedia.org/wiki/Shor%27s_algorithm) reduces the complexity of prime factorization to polynomial time, which directly threatens the RSA algorithm. As a result, many cryptographers are researching post-quantum cryptographic algorithms. The main technical approaches currently being explored are based on problems related to hash functions, coding theory, multivariate polynomials, lattices, and isogenies.

#### Attack Method 2: Compute $\phi(n)$ without factoring $n$

This problem is not easier than factoring $n$, because if you can compute $\phi(n)$, you can easily factorize $n$. This is because:

$$
\phi(n)=(p-1)(q-1)=pq-p-q+1 = n - (p+q) + 1
$$

If you calculate $\phi(n)$ and $n$ is known, you can calculate $p+q$. Furthermore, $p-q$ can be calculated by taking the square root of $(p+q)^2 - 4n$. By calculating $p$ and $q$, you have effectively factored $n$. However, since factoring $n$ is difficult, computing $\phi(n)$ is also difficult.

#### Attack Method 3: Compute the private key $d$ directly

This method is as difficult as factoring large integers: after calculating $d$, you can calculate multiples of $\phi(n)$ by $de - 1$, and there are methods to effectively factorize large integers based on multiples of $\phi(n)$.

## 5. Code Implementation

In this section, we will implement the RSA algorithm in Python and Solidity.

### 5.1 Python

The `generate_keypair`, `encrypt`, and `decrypt` functions implement the key generation, encryption, and decryption processes of the RSA algorithm.

> Note: This RSA implementation is for educational purposes only and is not secure. In practice, additional techniques (such as padding) and longer keys (greater than 2048 bits) need to be used.

```python
import random

# Prime number checking function, this method has a high complexity. If interested, you can learn about the faster Miller-Rabin algorithm.
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
        num = random.randint(10**2, 10**3)
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

## Output Example
# Original Message: 123
# Encrypted Message: 124872
# Decrypted Message: 123
# Public key: (141727, 52447)
# Private key: (141727, 19423)
```

### 5.2 Solidity

The EVM has a built-in modular exponentiation operation in the precompiled contract, with the address `0x05`. We can use it to handle the modular exponentiation operations in RSA encryption and decryption. However, key generation is more complex, so we won't include it on-chain.

You can deploy this contract on-chain to verify if the encryption and decryption steps in the Python program are correct.

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract RSA {
    // The precompiled contract address for modular exponentiation is 0x05. Details: https://www.evm.codes/precompiled#0x05?fork=shanghai

    // Encrypt using the public key
    function encrypt(uint message, uint e, uint n) public returns (uint) {
        // RSA encryption: cipher = message^e mod n
        return modExp(message, e, n);
    }

    // Decrypt using the private key
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

In this tutorial, we learned about the classic RSA algorithm, understood its principles and security, and implemented it in Python and Solidity. This is a milestone that marks the end of the introductory part of number theory in WTF zk. Next, we will briefly embark on an adventure in abstract algebra!