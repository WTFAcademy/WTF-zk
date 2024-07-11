---
title: Milestone 02: Diffie-Hellman Key Exchange Algorithm
tags:
  - zk
  - basic
  - cryptography
  - diffie-hellman
---

# WTF zk Tutorial Milestone 02: Diffie-Hellman Key Exchange Algorithm

In this lesson, we will cover Milestone 02 of the WTF zk Zero Knowledge Proof tutorial. By now, you should have a good understanding of number theory and group theory. In this milestone, we will learn about the Diffie-Hellman key exchange algorithm, which is a method for sharing keys over an insecure communication channel. This algorithm is a fundamental building block of cryptography and provides the foundation for secure communication.

## 1. Background

The Diffie-Hellman key exchange algorithm was first proposed by Whitfield Diffie and Martin Hellman in 1976. It is a public key cryptographic algorithm that allows two remote users to establish a shared key without actually sharing the key itself.

- **Public Key Cryptography:** The Diffie-Hellman algorithm was the first public key cryptography algorithm, which revolutionized the traditional method of sharing keys and laid the foundation for modern secure communication.

- **Security:** Based on the difficulty of the discrete logarithm problem, the two parties can securely negotiate a shared key without revealing their private keys.

- **Wide Applications:** The Diffie-Hellman algorithm is widely used in the field of secure communication, including protocols such as TLS/SSL and SSH.

![](./img/MS02-1.png)

## 2. Algorithm Principles

![](./img/MS02-2.png)

The core idea of the Diffie-Hellman algorithm is to utilize the difficulty of the discrete logarithm problem. Given a large prime number `p`, a base `g`, and `A ≡ g^a mod p`, it is computationally difficult to determine the value of `a`. The algorithm can be summarized in the following steps:

### 2.1 Key Generation

1. **Parameter Selection:** Choose two large prime numbers `p` and its primitive root (generator) `g`. Both `p` and `g` are public information.
2. **Private Key Generation:** Each party selects a private key. Let's say Alice chooses private key `a` and Bob chooses private key `b`. Both `a` and `b` are kept secret.
3. **Compute Public Key:** Alice computes `A = g^a mod p`, and Bob computes `B = g^b mod p`.
4. **Exchange Public Keys:** Alice sends `A` to Bob, and Bob sends `B` to Alice. At this point, both `A` and `B` are public.

In this step, the public keys `p`, `g`, `A`, and `B` are public, while the private keys `a` and `b` are kept secret.

### 2.2 Key Agreement

1. **Compute Session Key:** After receiving Bob's public key `B`, Alice computes `K = B^a mod p`. Similarly, after receiving Alice's public key `A`, Bob computes `K = A^b mod p`.
2. **Generate Shared Key:** Alice and Bob now have the same key `K`, which can be used as a session key for encrypted communication. Since an eavesdropper does not have access to `a` and `b`, it is computationally infeasible to calculate `K`, making the key `K` secure.

## 3. Example

To better understand the Diffie-Hellman algorithm, let's walk through a simple example.

1. **Parameter Selection:** Choose the prime number `p = 13` and its primitive root `g = 6`.
2. **Private Key Generation:** Alice chooses private key `a = 5`, and Bob chooses private key `b = 4`.
3. **Compute Public Key:** Alice computes `A = 6^5 mod 13 = 2`, and Bob computes `B = 6^4 mod 13 = 9`.
4. **Exchange Public Keys:** Alice sends `A = 2` to Bob, and Bob sends `B = 9` to Alice.
5. **Compute Session Key:** Alice computes `K = 9^5 mod 13 = 3`, and Bob computes `K = 2^4 mod 13 = 3`.
6. **Generate Shared Key:** Alice and Bob now have the same shared key `K = 3`, which can be used for further encrypted communication.

## 4. Algorithm Logic

The security of the Diffie-Hellman key exchange algorithm is based on the difficulty of the discrete logarithm problem. For an eavesdropper, the only information available is the prime number `p`, the primitive root `g`, Alice's public key `A = g^a mod p`, and Bob's public key `B = g^b mod p`. In order to obtain the shared key `K = g^(ab) mod p`, the eavesdropper needs to compute `a = log_g(A)` or `b = log_g(B)`, which is the discrete logarithm problem. However, there is no efficient algorithm for solving this problem, making it computationally infeasible. Therefore, the Diffie-Hellman algorithm is secure.

Additionally, since `p` is a large prime number, the order (number of elements) of the multiplicative group `Z^*_p` modulo `p` is `p-1`, which is very large. As the primitive root `g` is a generator of `Z^*_p`, its powers can cover all elements in `Z^*_p`, making it difficult to break the discrete logarithm problem by brute force.

## 5. Code Implementation

Here is a simple implementation in Python that demonstrates the Diffie-Hellman key exchange algorithm:

```python
import random

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

def generate_params():
    p = random_prime()
    g = random.randint(2, p - 2)
    return p, g

def generate_private_key():
    return random.randint(2, 2**16)

def generate_public_key(private_key, p, g):
    return pow(g, private_key, p)

def generate_shared_secret(private_key, public_key, p):
    return pow(public_key, private_key, p)

def random_prime():
    while True:
        num = random.randint(10**3, 10**4)
        if is_prime(num):
            return num

# Example
p, g = generate_params()
alice_private_key = generate_private_key()
bob_private_key = generate_private_key()

alice_public_key = generate_public_key(alice_private_key, p, g)
bob_public_key = generate_public_key(bob_private_key, p, g)

alice_shared_secret = generate_shared_secret(alice_private_key, bob_public_key, p)
bob_shared_secret = generate_shared_secret(bob_private_key, alice_public_key, p)

print("Prime number (p):", p)
print("Primitive root/generator (g):", g)
print("Alice's private key:", alice_private_key)
print("Bob's private key:", bob_private_key)
print("Alice's public key:", alice_public_key)
print("Bob's public key:", bob_public_key)
print("Shared secret (Alice):", alice_shared_secret)
print("Shared secret (Bob):", bob_shared_secret)

## Output Example
# Prime number (p): 2707
# Primitive root/generator (g): 1620
# Alice's private key: 8706
# Bob's private key: 60566
# Alice's public key: 1183
# Bob's public key: 2369
# Shared secret (Alice): 1776
# Shared secret (Bob): 1776
```

## 6. Conclusion

The Diffie-Hellman key exchange algorithm is an important cryptographic algorithm that solves the problem of sharing keys over an insecure channel, providing the foundation for modern secure communication. By leveraging the difficulty of the discrete logarithm problem, Diffie-Hellman ensures the security of key sharing. In practical applications, Diffie-Hellman is widely used in scenarios such as TLS/SSL protocols and SSH communication, providing a secure and reliable key sharing mechanism for communicating parties.
