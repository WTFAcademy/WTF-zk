---
title: 31. Elliptic Curve Discrete Logarithm Problem
tags:
  - zk
  - abstract algebra
  - elliptic curve
  - group theory
  - finite field
  - discrete logarithm
---

# WTF zk Tutorial Lesson 31: Elliptic Curve Discrete Logarithm Problem

The Elliptic Curve Discrete Logarithm Problem (ECDLP) is a fundamental concept in elliptic curve cryptography (ECC). In this section, we will introduce the definition and the challenges associated with solving the ECDLP.

## 1. Scalar Multiplication

First, let's discuss scalar multiplication in elliptic curves, which involves finding $Q = kP = P + P + ... + P$ (adding point P to itself k times), where k is an integer and P is a point on the elliptic curve. This operation is achieved by continuously adding the point P to itself.

For example, consider the elliptic curve over a finite field $y^2 = x^3 - x + 1 \mod 13$ and the point $P(0, 1)$ on the curve. We want to find $Q = 3P = P + P + P$.

To calculate $2P = (x_2, y_2)$, we can use the doubling formula. First, we calculate the slope $\lambda = \frac{3 \cdot 0^2 - 1 }{2 \cdot 1} = -1\cdot 7 = 6 \mod 13$. Then, we find the x-coordinate $x_2 = \lambda^2 - 2x = 36- 2 \cdot 0 = 10 \mod 13$ and the y-coordinate $y_2 = \lambda(x - x_2) - y = 6 \cdot (0 - 10) - 1 = 4 \mod 13$. Therefore, $2P = (10, 4)$.

Next, we calculate $3P = (x_3, y_3) = 2P + P$ using the point addition formula. The slope $\lambda = \frac{y_2 - y}{x_2 - x} = \frac{4 - 1}{10 - 0} = 3 \cdot 4 = 12 \mod 13$. The x-coordinate $x_3 =  \lambda^2 - x - x_2 = 144 - 0 - 10 = 4 \mod 13$, and the y-coordinate $y_3 = \lambda(x - x_3) - y = 12 (0-4) - 1 = 3 \mod 13$. Therefore, the final result is $3P = (4,3)$.

### 1.1 Double-And-Add Algorithm

The Double-And-Add algorithm is an efficient method for performing scalar multiplication. It reduces the number of additions required by representing k in binary form and applying double and add operations to quickly calculate $Q = nP$.

For example, when calculating $9P$, we can convert 9 to its binary form 1001, which means:

$$
9P = 1 \cdot 8P + 0 \cdot 4P + 0 \cdot 2P + 1 \cdot P
$$
 
Then, we calculate $2P = P + P$,  $4P = 2P + 2P$,  $8P = 4P + 4P$, and finally $9P = 8P + 1P$.

Using the Double-And-Add algorithm, the original calculation that requires n steps can be reduced to $2\log{n}$ steps, which is highly efficient.

### 1.2 Code Implementation

Now, let's implement the Double-And-Add algorithm in Python. We will use the elliptic curve over a finite field $y^2 = x^3 - x + 1 \mod 13$ and the point $P(0, 1)$ on the curve. We want to find $Q = 9P$, and the calculated result is $(7,8)$.

```python
from sympy import mod_inverse

# Redefine the parameters of the elliptic curve and the point P
p = 13
a = -1
b = 1
P = (0, 1)

# Define point addition and point doubling operations on the elliptic curve
# Define addition operation
def elliptic_curve_addition(P, Q, a, p):
    if P == ('inf', 'inf'):
        return Q
    if Q == ('inf', 'inf'):
        return P
    if P[0] == Q[0] and (P[1] != Q[1] or P[1] == 0):
        # P + Q = O (infinity) if they are vertically symmetric or P is a tangent point
        return ('inf', 'inf')
    if P == Q:
        # Point doubling
        lambda_ = (3 * P[0]**2 + a) * mod_inverse(2 * P[1], p) % p
    else:
        # Point addition
        lambda_ = (Q[1] - P[1]) * mod_inverse(Q[0] - P[0], p) % p

    x3 = (lambda_**2 - P[0] - Q[0]) % p
    y3 = (lambda_ * (P[0] - x3) - P[1]) % p

    return (x3, y3)

def ecc_double_and_add(P, k, a, p):
    """Double-And-Add algorithm for scalar multiplication on elliptic curves."""
    result = ('inf', 'inf')  # Infinity
    addend = P

    while k:
        if k & 1:
            result = elliptic_curve_addition(result, addend, a, p)
        addend = elliptic_curve_addition(addend, addend, a, p)
        k >>= 1
    return result

# Test the Double-And-Add algorithm
# Choose a scalar k = 9 for scalar multiplication testing
k = 9
result = ecc_double_and_add(P, k, a, p)

result
# (7, 8)
```

## 2. Elliptic Curve Discrete Logarithm Problem (ECDLP)

Previously, we learned about the Discrete Logarithm Problem (DLP): given a generator g and an integer a in the multiplicative group $\mathbb{F}^*_p$, find the discrete logarithm x such that $a \equiv g^x \pmod{n}$. This problem is computationally difficult.

Now, let's extend this challenging problem to elliptic curves, which gives rise to the Elliptic Curve Discrete Logarithm Problem (ECDLP): given points P and Q on an elliptic curve group $E(\mathbb{F}_p)$ over a finite field $\mathbb{F}_p$, find the discrete logarithm k such that $Q = kP$. This problem is also computationally difficult. Although the operations on elliptic curves involve additions, they are much more complex, involving multiple additions and multiplications in modular arithmetic. Therefore, ECDLP is even more challenging than DLP.

For example, for the elliptic curve $y^2 = x^3 - x + 1 \mod 13$ and the point $P(0, 1)$ on the curve, it is easy to calculate $Q = 9P$ using the Double-And-Add algorithm, which equals $(7, 8)$. However, given $P(0,1)$ and $Q(7, 8)$, it is difficult to solve the discrete logarithm $k = \log_P{Q}$, and there is no efficient algorithm.

### 2.1 Properties

Next, let's discuss some properties of the Elliptic Curve Discrete Logarithm, using the elliptic curve $y^2 = x^3 - x + 1 \mod 13$ and the point $P(0, 1)$ as an example.

**Property 1: Order of a Point** For a point P on an elliptic curve, the smallest positive integer s that satisfies $sP = O$ is called the order of the point P.

For example, the order of the point $P(0, 1)$ is 19 because $19P = 0$, and it is the smallest positive integer that satisfies $sP = O$.

**Property 2: Periodicity** For a point P on an elliptic curve with order s, if $Q = kP$ holds, then $Q = (k + ns)P$ also holds, where n is any integer. This means that the discrete logarithm $\log_P{Q}$ is an element in $\mathbb{Z}/s\mathbb{Z}$ with a period of s.

For example, if $3P = (4,3)$, then $22P = (4,3)$ and $41P = (4,3)$ also hold.

**Property 3: Additive Homomorphism** For points P, $Q_1$, and $Q_2$ on an elliptic curve $E(\mathbb{F}_p)$, it holds that

$$
\log_P{Q_1 + Q_2} = \log_P{Q_1} + \log_P{Q_2}
$$

This means that the elliptic curve discrete logarithm mapping $n = \log_P{Q}$ is a group homomorphism from the elliptic curve $E(\mathbb{F}_p)$ to $\mathbb{Z}/s\mathbb{Z}$.


## 3. Difficulty of ECDLP

Solving the ECDLP is usually computationally difficult, with algorithmic complexity typically being exponential. The most efficient algorithms currently have an exponential complexity of $O(\sqrt{p})$. This means that although there are algorithms that can solve ECDLP, they are not practical in practice because the required time increases dramatically as the elliptic curve parameters grow.

In comparison, the traditional Discrete Logarithm Problem (DLP) is simpler, and there are subexponential algorithms to solve it, such as the Index Calculus algorithm. Therefore, when the modulus p is the same, solving ECDLP is much more difficult than DLP. As a result, encryption algorithms based on ECDLP are more difficult to crack and provide higher security when the private key length is the same.

The table below shows the private key lengths required for the same security level in DLP and ECDLP. It can be seen that ECDLP only requires 1/10 of the private key length to achieve the same security as traditional DLP. This is why elliptic curves are widely used in blockchain and zero-knowledge proofs.

| Security Level | DLP (Private Key Length) | ECDLP (Private Key Length) |
|----------------|-------------------------|----------------------------|
| 80 bits        | 1024 bits               | 160 bits                   |
| 112 bits       | 2048 bits               | 224 bits                   |
| 128 bits       | 3072 bits               | 256 bits                   |
| 192 bits       | 7680 bits               | 384 bits                   |
| 256 bits       | 15360 bits              | 512 bits                   |

However, it should be noted that not every elliptic curve's discrete logarithm problem is difficult to solve. It is advisable to use elliptic curves that have been tested in practice, such as secp256k1, alt_bn128, and bls12_381, rather than inventing new ones.

## 4. Common Elliptic Curves

Bitcoin primarily uses an elliptic curve called `secp256k1`. This curve is defined over a finite field and standardized by SECG (Standards for Efficient Cryptography Group). The choice of the `secp256k1` curve is based on its specific mathematical properties, which make encryption algorithms based on this curve both secure and efficient.

The equation for the `secp256k1` curve is:

$$
y^2 = x^3 + 7 \mod p
$$

It is defined over a specially chosen finite field $\mathbb{F}_p$, where p is a very large prime number: $p = 2^{256} - 2^{32} - 977$.

The key generation, signature, and verification processes in Bitcoin rely on point operations on the `secp256k1` elliptic curve. The private key is a randomly chosen integer, and the public key is the scalar multiplication of the private key and a fixed base point on the curve. The signing process of a transaction uses the ECDSA (Elliptic Curve Digital Signature Algorithm), which is also based on the `secp256k1` curve.

In Python, we can use the `secp256k1` module in the `py_ecc` library to perform basic operations on the elliptic curve. In the following code, we use the `secp256k1` module to calculate the corresponding public key from a given private key. This process is essentially the same as generating a public key from a private key in Bitcoin.

```python
# Elliptic Curve secp256k1 Example
# Generate public key from private key using scalar multiplication
from py_ecc.secp256k1 import secp256k1

def generate_public_key(private_key):
    """
    Generate the public key using the secp256k1 elliptic curve from the given private key.
    
    Args:
    private_key (int): The private key, a large integer.
    
    Returns:
    (int, int): The public key, a point on the elliptic curve.
    """
    # Base point of secp256k1
    G = secp256k1.G
    
    # Calculate the public key
    public_key = secp256k1.multiply(G, private_key)
    
    return public_key

# Example: Using a random private key
private_key = 123456789  # In practice, the private key should be a randomly generated large integer, e.g., private_key = int(os.urandom(32).hex(), 16)

# Generate the public key
public_key = generate_public_key(private_key)

# Print the results
print(f"Private Key: {private_key}")
print(f"Public Key: {public_key}")

# Output
# Private Key: 123456789
# Public Key: (4051293998585674784991639592782214972820158391371785981004352359465450369227, 88166831356626186178414913298033275054086243781277878360288998796587140930350)
```

## 5. Summary

In this section, we introduced the Elliptic Curve Discrete Logarithm Problem (ECDLP), which provides 10 times the security of traditional DLP when using the same private key length. ECDLP is widely used in blockchain and zero-knowledge proofs. We also introduced the `secp256k1` curve used in Bitcoin and demonstrated the process of generating a public key from a private key.