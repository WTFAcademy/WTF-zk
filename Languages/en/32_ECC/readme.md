---
title: 32. Elliptic Curve Cryptography
tags:
  - zk
  - abstract algebra
  - elliptic curve
  - group theory
  - finite field
  - discrete logarithm
  - diffie-hellman
  - elgamal
  - ecdsa
---

# WTF zk Tutorial 32: Elliptic Curve Cryptography

In this lesson, we will discuss two classic algorithms in elliptic curve cryptography: Elliptic Curve Diffie-Hellman (ECDH), Elliptic Curve Elgamal (EC Elgamal), and Elliptic Curve Digital Signature Algorithm (ECDSA). These algorithms combine elliptic curves with traditional public key encryption techniques to provide enhanced security with shorter key lengths.

If you are not familiar with the Diffie-Hellman algorithm or the Elgamal algorithm, you can refer to the WTF zk [Milestone 02](https://github.com/WTFAcademy/WTF-zk/blob/main/MS02_DH/readme.md) and [Milestone 03](https://github.com/WTFAcademy/WTF-zk/blob/main/MS03_ElGamal/readme.md) for more information.

## 1. Elliptic Curve Cryptography

Elliptic Curve Cryptography (ECC) is a cryptographic method based on the mathematical theory of elliptic curves. It utilizes point addition and scalar multiplication on elliptic curves to provide the same or higher level of security as traditional public key encryption systems with shorter key lengths.

- **Key Length**: ECC offers the same or higher level of security as traditional cryptographic algorithms with shorter key lengths. For example, a 256-bit ECDH key provides the same security level as a traditional Diffie-Hellman key of approximately 3072 bits.
- **Computational Efficiency**: Due to the smaller key length, ECC is generally more computationally efficient.
- **Bandwidth and Storage**: With shorter key lengths, ECC is more efficient in network transmission and storage.

## 2. ECDH Algorithm

The ECDH algorithm is a Diffie-Hellman key exchange protocol based on elliptic curves. It leverages the difficulty of solving the elliptic curve discrete logarithm problem (ECDLP) to achieve secure key exchange, making it challenging for attackers to deduce the exchanged key even on a public channel.

The ECDH algorithm is widely used in secure communication standards and protocols, including the TLS/SSL secure transmission protocol, secure instant messaging applications, and cryptocurrency wallets.

### 2.1 Key Exchange Process

The key exchange process of the ECDH algorithm is similar to the traditional Diffie-Hellman algorithm, except that it replaces the integer multiplication group with an elliptic curve over a finite field.

1. **Parameter Selection**: Both parties agree on the same elliptic curve parameters and base point $G$.
2. **Private Key Generation**: Alice and Bob each randomly choose a private key $a$ and $b$.
3. **Public Key Computation**: Alice computes the public key $A = aG$, and Bob computes the public key $B = bG$.
4. **Key Exchange**: Alice sends $A$ to Bob, and Bob sends $B$ to Alice.
5. **Shared Key Computation**: Alice calculates $S = aB$, and Bob calculates $S = bA$. Due to the properties of elliptic curves, $S = aB = bA = abG$ holds, so Alice and Bob share the same key $S$.

### 2.2 Code Example

The following Python code demonstrates the ECDH key exchange using the `secp256k1` curve.

```python
# Elliptic Curve Diffie-Hellman (ECDH) algorithm

from py_ecc.secp256k1 import secp256k1
import os

def generate_keys():
    private_key = int.from_bytes(os.urandom(32), 'big') % secp256k1.N
    public_key = secp256k1.multiply(secp256k1.G, private_key)
    return private_key, public_key

# Alice and Bob generate their own key pairs
alice_private, alice_public = generate_keys()
bob_private, bob_public = generate_keys()

# Calculate the shared secret
shared_secret_alice = secp256k1.multiply(bob_public, alice_private)
shared_secret_bob = secp256k1.multiply(alice_public, bob_private)

if shared_secret_alice == shared_secret_bob:
    print("Shared secret matches.")
else:        
    print("Shared secret does not match!")

print(f"Alice's Private Key: {alice_private}")
print(f"Alice's Public Key: {alice_public}")

print(f"Bob's Private Key: {bob_private}")
print(f"Bob's Public Key: {bob_public}")

print(f"Shared Secret: {shared_secret_alice}")

# Output:
# Shared secret matches.
# Alice's Private Key: 44226773042722162955098193291492534006186517732096623157459837212766793078584
# Alice's Public Key: (113906392817926084413632896524344771269472367375880032535005632965062391078788, 49665636540644454541653315656482000530366349019751676160955522917215379042285)
# Bob's Private Key: 51860882402071446551116109914681284224864199234652843480335793819475548437366
# Bob's Public Key: (52340819409831460217804635786419806447405367609650964443132838196582132856471, 56429557458241459690871510882159471830396052430769816127197158365607969924309)
# Shared Secret: (39817116182924354378808003014233470575110979407770339130416639641795260327693, 42970388080766198583159133018251494914868250846130428856587988974064644921855)
```

### 2.3 Considerations

- **Curve Selection**: The security of ECDH depends on the selection of elliptic curves. It is important to choose curves that have been thoroughly tested in practice to avoid potential weaknesses.
- **Random Number Generation**: The security of private keys relies on the quality of random number generation. It is recommended to use a cryptographically secure random number generator for generating private keys.
- **Public Key Verification**: In practical applications, the receiving party should verify that the received public key indeed comes from a legitimate sender to prevent man-in-the-middle attacks.

## 3. EC Elgamal Algorithm

The Elliptic Curve Elgamal encryption algorithm (EC Elgamal) is a public-key encryption algorithm that combines elliptic curve cryptography (ECC) with the Elgamal encryption system. It utilizes the difficulty of solving the elliptic curve discrete logarithm problem (ECDLP) to achieve secure message encryption.

Let's assume that Alice wants to communicate with Bob using the EC Elgamal algorithm.

### 3.1 Key Generation

First, Bob needs to generate a key pair:

1. **Curve and Base Point Selection**: Choose an elliptic curve $E$ and a base point $G$ on the curve.
2. **Private Key and Public Key Generation**: Choose a random number $x$ as the private key and calculate the public key $Y = xG$.

The public key $(E, G, Y)$ is made public, while the private key $x$ is kept secret.

### 3.2 Encryption

Next, Alice wants to encrypt the plaintext message $M$, where $M$ is a point on the elliptic curve:

1. Choose a random number $k$.
2. Compute the point $C_1 = kG$.
3. Compute the point $C_2 = M + kY$.
4. The ciphertext is the pair of points $(C_1, C_2)$.

The random number $k$ changes with each encryption, ensuring that the EC Elgamal algorithm produces different temporary ciphertexts even for the same plaintext. In the encryption process, the random number $k$ is kept private, while the ciphertext $(C_1, C_2)$ is made public.

### 3.3 Decryption

After receiving the ciphertext $(C_1, C_2)$, Bob needs to use the private key $x$ to decrypt it:

1. Compute the point $M' = C_2 - xC_1$.

The calculated point $M'$ is the original plaintext message $M$.

### 3.4 Code Example

The following Python code demonstrates the EC Elgamal encryption using the `secp256k1` curve.

```python
from py_ecc.secp256k1 import secp256k1
from random import randint

def elgamal_encrypt(G, Y, M):
    k = randint(1, secp256k1.N - 1)
    C1 = secp256k1.multiply(G, k)
    C2 = secp256k1.add(M, secp256k1.multiply(Y, k))
    return (C1, C2)

def elgamal_decrypt(C1, C2, x):
    # Compute xC1 using the private key x
    xC1 = secp256k1.multiply(C1, x)
    # Compute M = C2 - xC1
    M = secp256k1.add(C2, (xC1[0], -xC1[1]))
    return M

# Example parameters
p = secp256k1.N
G = secp256k1.G

# Generate key pairs
x, Y = generate_keys()

# Assume the message M is a point on the curve, here we simply choose G as an example
M = G
print("Original Plaintext Message:", M)

# Encryption
C1, C2 = elgamal_encrypt(G, Y, M)
print("Encrypted Message:", (C1, C2))

# Decryption
M_decrypted = elgamal_decrypt(C1, C2, x)
print("Decrypted Message:", M_decrypted)

# Verification
assert M == M_decrypted, "Decryption failed!"
print("Message decrypted successfully!")

# Example output
# Original Plaintext Message: (55066263022277343669578718895168534326250603453777594175500187360389116729240, 32670510020758816978083085130507043184471273380659243275938904335757337482424)
# Encrypted Message: ((87298472810248234319752437423707505477343664832890363292431829216099637291919, 39528614830056678009484946030376271359657183017625571564228160252781333158439), (67113196324182438503834247973075313606138491143388276462715763950508942145812, 59499979624168470896804403233074133393632477568643779021536973756576878140912))
# Decrypted Message: (55066263022277343669578718895168534326250603453777594175500187360389116729240, 32670510020758816978083085130507043184471273380659243275938904335757337482424)
# Message decrypted successfully!
```

## 4. ECDSA

ECDSA (Elliptic Curve Digital Signature Algorithm) is a commonly used digital signature algorithm in elliptic curve cryptography. It utilizes the difficulty of solving the ECDLP to ensure the security of the signature. ECDSA is often used in Ethereum smart contracts, as demonstrated in [WTF Solidity Lesson 37](https://github.com/AmazingAng/WTF-Solidity/blob/main/37_Signature/readme.md).

Let's assume that Bob uses ECDSA for signing and Alice verifies the signature. The main steps are key generation, signing, and signature verification.

### 4.1 Key Generation

First, Bob needs to generate a key pair:

1. **Curve and Base Point Selection**: Choose an elliptic curve $E$ and a base point $G$, and calculate the order $n$ of the base point, i.e., $nG = O$.
2. **Private Key and Public Key Generation**: Choose a random number $x$ as the private key and calculate the public key $Y = xG$.

The public key $(E, G, Y)$ is made public, while the private key $x$ is kept secret.

### 4.2 Signing

Next, Bob uses the private key $x$ generated earlier to sign a message:

1. **Message Hash**: Compute the hash value $H(M)$ of the message $M$.
2. **Random Number Selection**: Generate a random number $k$, ensuring $1 < k < p-1$.
3. **Compute $r$**: Compute the point $P = kG$ using the random number $k$ and take the x-coordinate of point $P$ as $r$.
4. **Generate Signature**: Compute $s = k^{-1}(H(M)+xr) \mod n$, where $n$ is the order of the base point $G$. The generated signature is $(r, s)$.

It is important to ensure that a random value is generated for $k$ to prevent potential private key leaks. Additionally, if $r$ or $s$ is zero, it is necessary to regenerate a random value for $k$.

### 4.3 Signature Verification

In this step, Alice uses the original message $M$ and the public key $Y$ to verify the validity of the signature.

1. **Compute Message Hash**: Compute $H(M)$.
2. **Compute $u_1$ and $u_2$**: Compute $u_1 = H(m)s^{-1} \mod n$ and $u_2 = rs^{-1} \mod n$.
3. **Verify Signature**: Compute point $P' = u_1G + u_2Y$. If the x-coordinate of $P'$ is equal to $r$, the signature is valid.

### 4.4 Algorithm Correctness

Let's explore why the x-coordinate of the correctly signed point $P'$ is equal to $r$:

$$
P' = u_1G + u_2Y = u_1G + u_2xG
$$

Using the distributive property of scalar multiplication, we have:

$$
P' = (u_1 + u_2x)G
$$

Expanding $u_1$ and $u_2$, we have:

$$
P' = u_1G + u_2Y = (H(m)s^{-1} + rxs^{-1})G = (H(m) + rx)s^{-1}G
$$

Expanding $s$, we have:

$$
P' = u_1G + u_2Y = (H(m) + rx)(k^{-1}(H(M)+xr))^{-1}G = kG = P
$$

Therefore, the x-coordinate of the correctly signed point $P'$ is equal to $r$.

### 4.5 Code Example

The following Python code demonstrates the signing and verification process of ECDSA using the `secp256k1` curve:

```python
# ECDSA

from py_ecc.secp256k1 import secp256k1
import os
import hashlib

def generate_keys():
    # Generate private key
    private_key = os.urandom(32)
    private_key_int = int.from_bytes(private_key, 'big') % secp256k1.N
    # Generate public key
    public_key = secp256k1.multiply(secp256k1.G, private_key_int)
    return private_key_int, public_key

def ecdsa_sign(message, private_key):
    # Hash the message
    message_hash = hashlib.sha256(message).digest()
    message_hash_int = int.from_bytes(message_hash, 'big')
    
    k = int.from_bytes(os.urandom(32), 'big') % secp256k1.N
    R = secp256k1.multiply(secp256k1.G, k)
    r = R[0] % secp256k1.N
    s = ((message_hash_int + r * private_key) * secp256k1.inv(k, secp256k1.N)) % secp256k1.N
    
    return (r, s)

def ecdsa_verify(message, signature, public_key):
    r, s = signature
    message_hash = hashlib.sha256(message).digest()
    message_hash_int = int.from_bytes(message_hash, 'big')
    
    w = secp256k1.inv(s, secp256k1.N)
    u1 = (message_hash_int * w) % secp256k1.N
    u2 = (r * w) % secp256k1.N
    
    P = secp256k1.add(secp256k1.multiply(secp256k1.G, u1), secp256k1.multiply(public_key, u2))
    
    return r == P[0] % secp256k1.N

# Example
x, Y = generate_keys()
M = b"Hello, ECDSA with secp256k1!"
print("Original Plaintext Message:", M)

signature = ecdsa_sign(M, x)
print("Signature:", signature)

valid = ecdsa_verify(M, signature, Y)
print("Signature Verification Result:", valid)
```

## 4. Summary

In this lesson, we discussed two classic algorithms in elliptic curve cryptography: ECDH and EC Elgamal. These algorithms combine elliptic curves with traditional public key cryptography algorithms to provide enhanced security with shorter key lengths. They are well-suited for applications in blockchain and zero-knowledge proof scenarios.