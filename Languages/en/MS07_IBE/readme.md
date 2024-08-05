---
title: Milestone 07. Identity-Based Encryption
tags:
  - zk
  - basic
  - cryptography
  - hash
  - pedersen hash
  - hash to curve
  - quadratic residual
---

# WTF zk Tutorial Milestone 07: Identity-Based Encryption

In this lesson, we will introduce Identity-Based Encryption (IBE), which allows users to use identity information, such as email addresses, as the public key of the encryption system.

## 1. Identity-Based Encryption

Identity-Based Encryption (IBE) was proposed by Adi Shamir in 1984. The main feature of IBE is that it allows any party to use publicly available information, such as a user's email address or domain name, as its public key. This allows the sender to directly encrypt messages using the recipient's identity information without having to obtain the recipient's public key in advance. This solves the key distribution problem in traditional Public Key Infrastructure (PKI).

### 1.1 Basic Principles

An IBE system typically consists of four main parts:

1. **Setup**: A trusted centralized entity called a Private Key Generator (PKG) is responsible for verifying a user's identity information, generating the corresponding private key, and securely distributing it to the user.
2. **Extraction**: Users prove their identity to the PKG and obtain the corresponding private key.
3. **Encryption**: The sender encrypts the message using the recipient's public identity (such as an email address) and the system's public parameters.
4. **Decryption**: The recipient decrypts the received message using the private key obtained from the PKG.

### 1.2 Advantages and Disadvantages

IBE systems have the following advantages:

- **Simplified Key Management**: There is no need to maintain and distribute certificates like traditional public key systems because a user's public key is their identity information, such as an email address. This simplifies the process of key management and distribution.
- **Real-Time Encryption**: The sender can immediately encrypt a message without obtaining the recipient's public key in advance, only needing to know the recipient's identity information.
- **Delayed Private Key Generation**: The user's private key is generated and extracted by the PKG only when it is first needed, allowing for flexible key management.

At the same time, IBE also has some disadvantages:

- **Centralization**: All private keys are generated and distributed by a centralized entity (PKG). If the PKG is attacked, the overall security of the system is compromised.
- **Key Revocation**: If a user's private key is compromised, there needs to be a mechanism to revoke that key. However, in IBE, the public key is based on the user's identity information (such as an email address), and it cannot be changed or revoked without changing the user's identity.

## 2. Boneh-Franklin IBE Scheme

Although IBE was proposed as early as 1984, practical schemes did not appear until 2001 when Boneh and Franklin proposed a pairing-based IBE scheme that solved the challenges of key management and distribution in traditional public key encryption systems.

Next, we will use the bls curve as an example to introduce the steps of Alice sending an encrypted message to Bob in the IBE scheme.

### 2.1 Setup

In this phase, the Private Key Generator (PKG) selects the global parameters, which include:

- The bls12_381 elliptic curve parameters.
- Public parameters: the base point $G_1$ of $E(\mathbb{F}_p)$, and the base point $G_2$ of $E(\mathbb{F}_{p^2})$ in bls.
- The master private key $s$.
- The master public key $P^{PKG} = sG_1 \in E(\mathbb{F}_p)$.
- Bilinear pairing $e: E(\mathbb{F}_{p^2}) \times E(\mathbb{F}_p) \to \mathbb{F}_{p^{12}}$.
- Hash function $H_1$: hashes the message to a point on the elliptic curve $E(\mathbb{F}_{p^2})$.
- Hash function $H_2$: hashes the pairing result to bytes.

### 2.2 Extraction

Alice extracts her public and private keys.

- Alice chooses an identity-based public key $\text{Pub}^{Alice}$, such as the email address `"alice@wtf.email"`, and maps the public key to a point on the elliptic curve $P^{Alice} = H_1(\text{Pub}^{Alice}) \in E(\mathbb{F}_{p^2})$ using the hash function $H_1$.

- Alice requests the private key from the PKG: $Q^{Alice} = s P^{Alice} \in E(\mathbb{F}_{p^2})$.

### 2.3 Encryption

Bob encrypts the message $M$ based on Alice's identity information.

- Bob chooses a plaintext $M$ and a random number $r$.
- Computes the point $P^{Alice} = H_1(\text{Pub}^{Alice})$.
- Computes $C_1 = rG_1$.
- Computes $C_2 = M \oplus H_2(e(P^{Alice}, P^{PKG})^r)$, where $\oplus$ denotes the XOR operation.

The ciphertext sent by Bob to Alice is $(C_1, C_2)$.

### 2.4 Decryption

In this step, Alice uses her private key $Q^{Alice}$ to decrypt the ciphertext $(C_1, C_2)$, and the decrypted message is $M' = C_2 \oplus H_2(e(Q^{Alice}, C_1))$.

If the encryption and decryption steps are correct, Alice will be able to decrypt the correct plaintext $M' = M$.

### 2.5 Algorithm Correctness

Why is $M' = M$?

Let's expand $M'$:

$$
M' = C_2 \oplus H_2(e(Q^{Alice}, C_1))
$$

$$
M' = M \oplus H_2(e(P^{Alice}, P^{PKG})^r) \oplus H_2(e(Q^{Alice}, C_1))
$$

According to the properties of the XOR operation, if $H_2(e(P^{Alice}, P^{PKG})^r) =  H_2(e(Q^{Alice}, C_1))$, then we have $M' = M$.

Readers are urged to verify the equality of the two based on the properties of bilinear pairings.

### 2.6 Code Example

Now, let's use the py_ecc library to write an IBE example based on the bls curve pairing. The example includes the setup, extraction, encryption, and decryption steps of IBE. We simplified the step of verifying the identity and provided the corresponding private key based on the identity.

```python
from py_ecc.optimized_bls12_381 import G1, G2, multiply, add, pairing, curve_order, FQ2, FQ12
from py_ecc.bls.hash_to_curve import hash_to_G2
from hashlib import sha256
import os

# H1: Hash message to a point on the G2 curve
def H1(message, dst=b'WTF-HASH-TO-CURVE-bls12-381'):
    # The DST parameter is the domain separation tag for the hash function
    point_projective = hash_to_G2(message, dst, sha256)
    return point_projective

# H2: Hash fq12 element (pairing result) to bytes
def H2(fq12_elem):
    # Convert all the coefficients of the FQ12 element to strings and concatenate them
    concatenated_coeffs = ''.join(str(coeff) for coeff in fq12_elem.coeffs)
    # Hash the concatenated string using SHA256
    hash_digest = sha256(concatenated_coeffs.encode()).digest()
    return hash_digest

# XOR two bytes objects together
def xor_bytes(bytes1, bytes2):
    """XOR two bytes objects together."""
    return bytes(a ^ b for a, b in zip(bytes1, bytes2))

# IBE encryption
def ibe_encrypt(master_pk, user_id, message):
    r = int.from_bytes(os.urandom(32), 'big') % curve_order
    
    # Compute shared secret using pairing
    P_user = H1(user_id.encode())
    shared_secret = pairing(P_user, master_pk)
    C1 = multiply(G1, r)
    C2 = xor_bytes(message, H2(shared_secret ** r))

    return C1, C2

# IBE decryption
def ibe_decrypt(user_sk, C1, C2):
    shared_secret = pairing(user_sk, C1)
    M = xor_bytes(C2, H2(shared_secret))
    return M


# Master key generation
master_sk = int.from_bytes(os.urandom(32), 'big') % curve_order
master_pk = multiply(G1, master_sk)

# Generate private key based on Alice's id
alice_id = "alice@wtf.email"
alice_sk = multiply(H1(alice_id.encode()), master_sk)

# Bob encrypts the message
bob_id = "bob@wtf.email"
message = b"WTF, Alice!"
print("Original message:", message)
C1, C2 = ibe_encrypt(master_pk, alice_id, message)
print("Encryption C1:", C1)
print("Encryption C2:", C2)

# Alice decrypts the message
decrypted_message = ibe_decrypt(alice_sk, C1, C2)
print("Decrypted message:", decrypted_message)

# Output example
# Original message: b'WTF, Alice!'
# Encryption C1: (725374226968432448365528450463540667799630567526402423184017492362194410232185198007920253993995187216521721662343, 2220163884092685170597202150534200353558680069175326450716109816259628864987790756986054551188110826100753535572404, 578944078995539478898067346383698208062908690132418954413632161636084423626880593706141384237810614307828491209731)
# Encryption C2: b'\xdd\xcfGS\xfa:j\xc2&@\x13'
# Decrypted message: b'WTF, Alice!'
```

## 3. Summary

In this lesson, we introduced Identity-Based Encryption (IBE) and implemented a simple Boneh-Franklin IBE scheme. Identity-Based Encryption allows users to use identity information, such as email addresses, as the public key of the encryption system, solving the key distribution problem in traditional Public Key Infrastructure (PKI).