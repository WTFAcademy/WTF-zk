# WTF zk Tutorial 4: Extended Euclidean Algorithm

In this tutorial, we will delve into an extension of the Euclidean algorithm that not only calculates the greatest common divisor but also finds the integer solutions that satisfy Bézout's equation.

## 1. Bézout's Equation

Before introducing the extended Euclidean algorithm, let's first understand Bézout's equation. For two integers a and b, there exist integers x and y that satisfy the following equation:

```
ax + by = gcd(a, b)
```

This equation is known as Bézout's equation, where gcd(a, b) is the greatest common divisor of a and b. The goal of the extended Euclidean algorithm is to find such integers x and y.

## 2. Extended Euclidean Algorithm

### 2.1 Basic Idea

The extended Euclidean algorithm not only calculates the greatest common divisor using the Euclidean algorithm but also finds the integer solutions that satisfy Bézout's equation through reverse deduction. In the Euclidean algorithm, we only care about the remainders ri of each iteration and not the quotients qi. The extended algorithm makes use of qi to reverse compute Bézout's equation, effectively utilizing what would otherwise be discarded.

Let's recall the Euclidean algorithm:

```
a = bq0 + r0
b = r0q1 + r1
...
ri-2 = ri-1qi + ri
...
rn-2 = rn-1qn + rn
```

We continue iterating until rn = 0, at which point rn-1 = gcd(a,b) and we have:

```
rn-2 = gcd(a, b) qn 
rn-3 = rn-2 qn-1 + gcd(a, b)
...
a = bq + r
```

Where all the qi are known. Therefore, we can continuously expand and express r, ..., rn-2 as linear combinations of a and b, ultimately expressing gcd(a, b) as a linear combination of a and b, which yields Bézout's equation.

We will now derive the extended Euclidean algorithm using both iterative and recursive methods.

### 2.2 Iterative Derivation

#### 2.2.1 Iterative Formula

First, let's express the remainder ri obtained from each iteration as a linear combination of a and b. For the ith iteration with remainder ri, let there exist integers xi and yi that satisfy the following equation:

```
xi a + yi b = ri
```

Since rn-1 = gcd(a,b), we have:

```
x{n-1} a + y{n-1} b = gcd(a,b)
```

Therefore, (x{n-1}, y{n-1}) is the pair (x,y) that satisfies Bézout's equation. Our goal is to iteratively compute these values.

From the equation ri-2 = ri-1qi + ri, we can derive:

```
ri = ri-2 - ri-1qi
```

Expanding ri-2 and ri-1 as linear combinations of a and b, we have:

```
ri = (xi-2 - xi-1qi) a + (yi-2 - yi-1qi) b
```

Thus, we obtain the iterative relationship between (xi, yi) and (xi-2, xi-1, yi-2, yi-1):

```
xi = xi-2 - xi-1qi
yi = yi-2 - yi-1qi
```

#### 2.2.2 Initial Conditions

With the iterative relationship established, the next step is to determine the initial conditions. For the first iteration, we have:

```
r0 = a - q0b
```

In other words, x0 = 1, y0 = -q0. This implies:

```
1 = x{-2} - q0 x{-1}
-q0 = y{-2} - q0 y{-1}
```

Therefore, we can derive the initial conditions as (x{-2}, x{-1}, y{-2}, y{-1}) = (1, 0, 0, 1).

We then continue iterating (xi, yi) using the Euclidean algorithm:

```
xi = xi-2 - xi-1qi
yi = yi-2 - yi-1qi
```

The final result (x{n-1}, y{n-1}) obtained is the pair (x, y) that satisfies Bézout's equation.

#### 2.2.3 Example

Let's compute the integers x and y that satisfy Bézout's equation for a = 30 and b = 24:

```
ax + by = gcd(a, b)
```

1. Step 1: Initialize (x{-2}, x{-1}, y{-2}, y{-1}) = (1, 0, 0, 1).

2. Step 2: Apply the Euclidean division to obtain:

```
30 = 1 * 24 + 6
```

Here, (q0, r0) = (1, 6). Substituting into the iteration equations (xi, yi), we have:

```
x0 = 1 - 1 * 0 = 1
y0 = 0 - 1 * 1 = -1
```

At this point, we have xia + yib = 30 - 24, which equals 6, and the equation holds.

3. Step 3: Since the remainder r is non-zero r = 6, replace a with b and b with r, and continue with the Euclidean division:

```
24 = 4 * 6 + 0
```

Here, (q1, r1) = (4, 0). Since the remainder is 0, we stop iterating. The greatest common divisor is gcd(30, 24) = 6, and the pair (x, y) = (x0, y0) = (1, -1) satisfies Bézout's equation.

4. Step 4: We obtain the coefficients (x, y) = (1, -1) that satisfy Bézout's equation:

```
a - b = 6
```

### 2.3 Recursive Derivation

We want to find x and y such that x * a + y * b = gcd(a, b).

When b = 0, obviously x = 1 and y = 0.

When b ≠ 0, we have gcd(a, b) = gcd(b, a % b). For the left-hand side, gcd(a, b) = ax + by; for the right-hand side, gcd(b, a % b) = bx1 + (a % b) * y1 = bx1 + (a - (a // b) * b) * y1 = ay1 + b(x1 - (a // b) * y1). The correspondence between the left-hand side and the right-hand side is x = y1 and y = x1 - (a // b) * y1. This completes the derivation.

### 2.4 Code Implementation

Let's implement the extended Euclidean algorithm in Python:

#### Iterative Version

```python
def extended_euclidean_algorithm(a, b):
    x1, y1, x2, y2 = 1, 0, 0, 1
    
    while b:
        q = a // b
        a, b = b, a % b
        x1, x2 = x2, x1 - q * x2
        y1, y2 = y2, y1 - q * y2

    return a, x1, y1

# Example
num1 = 30
num2 = 24
gcd_result, x, y = extended_euclidean_algorithm(num1, num2)
print(f'The greatest common divisor of {num1} and {num2} is {gcd_result}')
print(f'The integer solutions that satisfy Bézout\'s equation are: {num1}*{x} + {num2}*{y} = {gcd_result}')
```

#### Recursive Version

```python
def ext_gcd(a, b):
    if b == 0:
        return 1, 0
    else:
        x, y = ext_gcd(b, a%b)
        x, y = y, x - (a//b) * y
        return x, y
```

## 3. Applications

The extended Euclidean algorithm has wide-ranging applications, including:

- **Multiplicative Inverse:** The main application of the extended Euclidean algorithm is calculating the multiplicative inverse modulo N, as explained in the next tutorial.
- **RSA Algorithm:** In the RSA asymmetric encryption algorithm, the extended Euclidean algorithm is used to generate the private key, ensuring it satisfies certain mathematical relationships.
- **Solving Congruence Equations:** In number theory, the extended Euclidean algorithm is commonly used to solve congruence equations of the form ax ≡ 1 (mod m), where a and m are coprime.

## 4. Summary

In this tutorial, we introduced Bézout's equation and the extended Euclidean algorithm. The extended Euclidean algorithm has widespread applications, and mastering it will lay the foundation for our future in-depth study of zero-knowledge proofs.