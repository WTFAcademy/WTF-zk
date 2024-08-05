---
title: 06. Hash Functions
tags:
  - zk
  - basic
  - cryptography
  - hash
  - pedersen hash
  - hash to curve
  - quadratic residual
---

# WTF zk Tutorial Milestone 06: Hash Functions

In this lesson, we will explore hash functions, with a focus on their combination with elliptic curves. This includes hash-to-curve and Pedersen hash.

## 1. What is a Hash Function?

A hash function is an algorithm that maps an input of any length (usually referred to as a "message") to a fixed-length string known as a hash value or digest. The most commonly used hash function is SHA256, which transforms any input into a 256-bit (32-byte) hash value. It is widely used in encryption, data integrity verification, and digital signatures.

A good hash function should have the following properties:

- **Deterministic**: The same input will always produce the same output.
- **One-way**: The hash function can efficiently compute the hash value of any input, but it is computationally infeasible to reverse-engineer the input from the hash value. This ensures that the hash value effectively hides the original input.
- **Collision resistance**: The probability of two different inputs producing the same output (i.e., a collision) is extremely low. For example, the strings "apple," "apples," and "zpple" are similar, but their hashes are completely different.
- **Binding**: A small change in the input data should result in a significant change in the output hash value, making it easy to detect any changes to the data.

```python
# Hash function: SHA256
from hashlib import sha256

def get_hash(message_string):
    return sha256(message_string.encode('utf-8')).hexdigest()

print("Hash of 'apple':", get_hash("apple"))
print("Hash of 'apples':", get_hash("apples"))
print("Hash of 'zpple':", get_hash("zpple"))

# Output:
# Hash of 'apple': 3a7bd3e2360a3d29eea436fcfb7e44c735d117c42d1c1835420b6b9942dd4f1b
# Hash of 'apples': f5903f51e341a783e69ffc2d9b335048716f5f040a782a2764cd4e728b0f74d9
# Hash of 'zpple': 2d198bd02ab5e8a7260f50db5dea5672c03151c3febcf3d2ec129263d4f299bd
```

## 2. Hash-to-Curve

In elliptic curve cryptography, the hash-to-curve method maps a message to a point on an elliptic curve using a hash function. In some elliptic curve encryption algorithms, such as ECDSA and EC ElGamal, we need to map the message to a specific point on the elliptic curve. This is where the hash-to-curve method comes into play.

Why do we need hash-to-curve? Can't we simply compute the hash of the message?

Not necessarily. If we directly use the hash of the message as the x-coordinate of a point and calculate y^2 using the elliptic curve equation y^2 = x^3 + ax + b, the calculated y^2 may not be a quadratic residue modulo p. In this case, there is no point on the elliptic curve with the x-coordinate x. Therefore, we need a special method to map the message to a point on the elliptic curve.

## 2.1 Try-and-Increment Method

The try-and-increment method is a commonly used hash-to-curve method. The basic steps are as follows:

1. **Choose a hash function**: Typically, a hash function with strong collision resistance, such as SHA-256, is chosen.

2. **Initialize a counter**: Set the counter c to 0.

3. **Compute the hash of the message**: Concatenate the message M and the counter c, then hash the resulting string to obtain a hash value H(M|c), where | represents concatenation.

4. **Try to construct a point**: Treat the hash value as the x-coordinate of a point P(x, y) on the elliptic curve and calculate y^2 using the elliptic curve equation.

5. **Check the validity of the point**: For each generated point, check if it satisfies the elliptic curve equation, i.e., whether y^2 is a quadratic residue. If it satisfies the equation, accept this point as the result of the hash. If it does not satisfy the equation, increment the counter c by 1 and repeat steps 3-5.

In the following Python example, we use the try-and-increment method to hash the string `'Example message'` to a point on the secp256k1 curve:

```python
# Hash to curve
# Try-and-Increment method

from hashlib import sha256
from py_ecc.secp256k1 import secp256k1

def hash_to_curve_try_and_increment(message):
    # Counter
    counter = 0
    while True:
        # Compute the hash of the message and the counter
        data = message + counter.to_bytes(32, 'big')
        hash_digest = sha256(data).digest()

        # Calculate the x-coordinate from the hash
        x = int.from_bytes(hash_digest, 'big') % secp256k1.P

        # Try to calculate y^2 using the elliptic curve equation y^2 = x^3 + ax + b
        y_squared = (pow(x, 3, secp256k1.P) + secp256k1.A * x + secp256k1.B) % secp256k1.P
        
        # Calculate the square root of y^2 modulo p, if it exists (for secp256k1, p % 4 = 3, this method can be used)
        y = pow(y_squared, (secp256k1.P + 1) // 4, secp256k1.P)

        # If y^2 = y_squared, then y^2 is a quadratic residue, (x, y) is a point on the elliptic curve, return it
        # Otherwise, increment the counter c by 1 and try again
        if pow(y, 2, secp256k1.P) == y_squared:

            # y^2 has two square roots y and -y, we use the last bit of the hash to determine the sign of y
            sign_bit = hash_digest[-1] & 1
            if sign_bit == 1:
                y = secp256k1.P - y  # Use -y

            return (x, y)

        counter += 1

# Example
message = 'Example message'.encode('utf-8')
point_on_curve = hash_to_curve_try_and_increment(message)
print(f"Point on secp256k1 curve: {point_on_curve}")

# Output:
# Point on secp256k1 curve: (75672206050705717597513752332592681441562708170391675094677140490692301502235, 2079954378639550643990441934946533201466680551826647417569849183466717633402)
```

## 3. Pedersen Hash

Pedersen hash is a type of hash function that utilizes two generator points (also known as base points) on an elliptic curve. It possesses the properties of hiding and binding and is commonly used in zero-knowledge proof algorithms.

Suppose we want to hash a message m. We can choose a random number r as a blinding factor and use the following formula to construct the hash value H:

$$
H = rG + mP
$$

Here, the point G is the generator point of secp256k1, the point P is obtained through the hash-to-curve method, r is a randomly generated blinding factor, and m is the message we want to hash. Note that the base points G and P must be independently generated, i.e., there cannot exist a smaller k such that P = kG.

In the following Python example, we use the generator point G on the secp256k1 curve and the point P obtained through the hash-to-curve method as the two base points to construct a simple Pedersen hash function.

```python
from py_ecc.secp256k1 import secp256k1
import os

def pedersen_hash(G, P, m, r):
    """
    Calculate the Pedersen hash using two points G and P on secp256k1.
    :param G: The generator point on secp256k1.
    :param P: The point obtained through hash-to-curve.
    :param m: The message.
    :param r: The random number.
    :return: The Pedersen hash as a point on the secp256k1 curve.
    """
    hash_point = secp256k1.add(secp256k1.multiply(G, m), secp256k1.multiply(P, r))
    return hash_point

def message_to_int(message):
    """Convert the message to an integer."""
    message_hash = sha256(message.encode('utf-8')).digest()
    return int.from_bytes(message_hash, 'big')

# Example
G = secp256k1.G
P = (75672206050705717597513752332592681441562708170391675094677140490692301502235, 2079954378639550643990441934946533201466680551826647417569849183466717633402)
m = message_to_int('Example message')
r = int.from_bytes(os.urandom(32), 'big') % secp256k1.N  # Random blinding factor
print(f"Random number r: {r}")
# Output:
# Random number r: 73024396533133913522992000700997978493545300935845156062873113842229351634806

hash_point = pedersen_hash(G, P, m, r)
print(f"Pedersen hash: {hash_point}")
# Output:
# Pedersen hash: (61158186220483422500680232915115660637414963516696475985433668859480078549697, 19925636506537717141567615179623096875787300022679479682581994441236159884610)
```

## 4. Summary

In this lesson, we have introduced hash functions, which play a central role in cryptography and data security. SHA-256 is the most commonly used hash function, while Pedersen hash is often used in zero-knowledge proofs. Some encryption algorithms require mapping messages to points on elliptic curves, and this is where the hash-to-curve method comes into play.