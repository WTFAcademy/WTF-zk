raise ValueError("a and n must be coprime for Euler's theorem.")
    
result = pow(a, euler_phi(n), n)
return result

# Example
n = 15
print(f"Euler's function phi({n}): {euler_phi(n)}")
# Euler's function phi(15): 8

a = 7
result = euler_theorem(a, n)
print(f"Euler's theorem: {a}^phi({n}) mod {n} = {result}")
# Euler's theorem: 7^phi(15) mod 15 = 1

## 4. Summary

In this tutorial, we introduced Euler's theorem and its relationship with Fermat's little theorem. Euler's theorem is the mathematical foundation of the RSA encryption algorithm and is very important. It is necessary for everyone to master it.
# WTF zk Tutorial 10: Euler's Theorem

Euler's Theorem is a fundamental theorem in number theory that states in modular arithmetic, for any integer coprime with the modulus, the exponentiation of that integer by the Euler function is congruent to 1 modulo the modulus. It provides a mathematical foundation for encryption algorithms such as RSA. In this tutorial, we will introduce the discrete logarithm problem, orders, and Euler's Theorem.

## 1. Discrete Logarithm Problem

The Discrete Logarithm Problem is a classic problem in mathematics and cryptography, which says that computing logarithms modulo a number is very difficult.

Given a prime number $p$ and integers $g$ and $h \in \mathbb{Z}_n^*$, we want to find an integer $x$ such that:

$$
g^x \equiv h \pmod{p}
$$

For example, for $(p, g, h) = (7, 3, 6)$, we want to find $x$ that satisfies the equation $3^x \equiv 6 \pmod{7}$. We can try to solve it using brute force:

$$
3^1 \equiv 3 \pmod{7}
$$

$$
3^2 \equiv 2 \pmod{7}
$$

$$
3^3 \equiv 6 \pmod{7}
$$

Therefore, $x = 3$ satisfies the condition.

However, computing discrete logarithms gets very difficult for larger primes. For example, $(p, g, h) = (104729, 5, 3375)$ is quite challenging. The security of RSA encryption algorithm and elliptic curve cryptography relies on the hardness of the discrete logarithm problem, so larger and harder to compute parameters are chosen.

## 2. Orders

Let $a \in \mathbb{Z}_n$, the smallest integer $k$ that satisfies $a^k \equiv 1 \pmod{n}$ is called the order of the element $a$.

For example:

For modulo $n = 5$ and $a = 2$, we have:

$$
2^1 = 2 \pmod{5}
$$

$$
2^2 = 4 \pmod{5}
$$

$$
2^3 = 8 = 3 \pmod{5}
$$

$$
2^4 = 16 = 1 \pmod{5}
$$

Therefore, the order of $a$ is $4$. The order of an element is important because it characterizes the cyclic property of the set of elements. We can see that $2^5 = 2 \cdot 2^4 = 2 \cdot 1 = 2 \pmod{5}$, which falls into the next cycle of $\{2, 4, 3, 1\}$.

### 2.1 Properties of Orders

In number theory, order is an important concept that represents the cyclic property between an element and a modulus. The following are some important properties of the order:

#### 1. If the order of $a$ is $k$, then $a^j \equiv 1 \pmod{n}$ if and only if $k$ divides $j$.

Continuing with the previous example, $a = 2, n = 5$, the order of $a$ is $4$, and $2^8 \equiv 256 \equiv 1 \pmod{5}$, which shows that $4$ divides $8$.

<details><summary>Click to expand the proof 👀</summary>

First, let's express $j$ in terms of $k$. According to the Euclidean division theorem, we have

$$
j = qk + r
$$

where $0 \le r < k$. Substitute it back into the original equation:

$$
a^j = a^{qk+r} = a^{qk}a^r = (a^{k})^qa^r \equiv 1 \pmod{n}
$$

Since $a^k \equiv 1 \pmod{n}$, we can simplify $(a^{k})^q\equiv 1 \pmod{n}$, and the above equation becomes:

$$
a^r \equiv 1 \pmod{n}
$$

According to the definition of order, $k$ is the smallest integer that satisfies $a^k \equiv 1 \pmod{n}$, and since $0 \le r < k$, it follows that $r = 0$. Therefore, we have:

$$
j = qk
$$

Thus, $k$ divides $j$, and the proof is complete.
</details>

#### 2. If $a$ is coprime with the modulus $n$, then the order $k$ of $a$ divides $\phi(n)$, where $\phi(n)$ is the Euler's totient function.

<details><summary>Click to expand the proof 👀</summary>

This property involves Euler's Theorem, which we will introduce in the next section.

According to Euler's Theorem, we have $a^{\phi(n)} \equiv 1 \pmod{n}$. According to the first property: If the order of $a$ is $k$, then $a^j \equiv 1 \pmod{n}$ if and only if $k$ divides $j$. Therefore, $k$ divides $\phi(n)$.  Proof complete.
</details>

## 3. Euler's Theorem

Euler's Theorem relates Euler's function and the cyclic property of exponentiation.

**Theorem:** If the integer $a$ and the positive integer $n$ are coprime (i.e., $\gcd(a,n)=1$), then $a^{\phi(n)} \equiv 1 \pmod{n}$.

Here, $\phi(n)$ is Euler's function, which counts the number of integers in the range $[1, ..., n-1]$ that are coprime with $n$.

Continuing with the previous example, $a = 2, n = 5$, first calculate $\phi(5) = 5-1 = 4$, then we have $2^4 \equiv 16 \equiv 1 \pmod{5}$, which satisfies Euler's Theorem.

Here's another example, $a = 3, n = 7$, first calculate $\phi(7)=7-1=6$, then apply Euler's Theorem to get $3^6 \equiv 1 \pmod{7}$. Checking $3^6 = 729$, with a remainder of $1$ when divided by $7$, Euler's Theorem is correct.

<details><summary>Click to expand the proof 👀</summary>

Consider the set $S = Z_n^* = \{1 \le x \le n | \gcd(x,n) = 1\}$. We know that $S$ has $\phi(n)$ elements, and we can represent them as $\{x_1, x_2, ..., x_{\phi(n)}\}$.

Now consider another set $S'$, whose elements are obtained by multiplying the elements in $S$ by $a$. It can be represented as:

$S' = aS = \{ax_1, ax_2, ..., ax_{\phi(n)}\}$

**Lemma 1:** $\gcd(ax_i,n) = 1$.

Proof: Since $\gcd(a, n) = 1$ and $\gcd(x_i,n) = 1$, it follows that $\gcd(ax_i,n) = 1$.

**Lemma 2:** No two elements in $S'$ are congruent modulo $n$.

Proof: Assume that there exist two elements in $S'$, $ax_i$ and $ax_j$, that are congruent modulo $n$, i.e., $ax_i \equiv ax_j \pmod{n}$. This implies $a(x_i - x_j) \equiv 0 \pmod{n}$, which means $n$ divides $a(x_i - x_j)$, i.e., $n|a(x_i- x_j)$. Since $\gcd(a, n) = 1$, it follows that $n|(x_i- x_j)$, i.e., $x_i- x_j = kn$. Since $1 \le x_i, x_j \le n$, we have $x_i - x_j = 0$, which means $x_i = x_j$, i.e., $i=j$. Therefore, $x_i$ is congruent to $x_j$ if and only if $i=j$. Proof complete.

According to Lemma 1 and Lemma 2, we know that $S'$ consists of $\phi(n)$ elements that are coprime with $n$, and they are pairwise incongruent. In other words, $S' = Z_n^*$, which contains the same elements as $S$ (but the order may be different).

Next, we multiply all elements in both $S$ and $S'$, and they should be congruent, i.e.,

$$(ax_1)(ax_2)...(ax_{\phi(n)}) \equiv x_1x_2...x_{\phi(n)} \pmod{n}$$

Taking out all the $a$'s, there are $\phi(n)$ of them, we have:

$$a^{\phi(n)} x_1x_2...x_{\phi(n)}  \equiv x_1x_2...x_{\phi(n)} \pmod{n}$$

Let $X = x_1x_2...x_{\phi(n)}$, with $\gcd(X,n) = 1$. The equation can be simplified to:

$$a^{\phi(n)} X  \equiv X \pmod{n}$$

Since $X^{-1}$ exists, we can multiply both sides by $X^{-1}$ and simplify, we obtain:

$$a^{\phi(n)}  \equiv 1 \pmod{n}$$

Proof complete!
</details>

### 3.1 Relationship with Fermat's Little Theorem

We can easily prove Fermat's Little Theorem using Euler's Theorem.

According to Euler's Theorem: If the integer $a$ and the positive integer $n$ are coprime (i.e., $\gcd(a,n)=1$), then $a^{\phi(n)} \equiv 1 \pmod{n}$.

When $n$ is a prime number, $\phi(n)=n-1$, substituting it into the original theorem, we have $a^{n-1} \equiv 1 \pmod{n}$, which is equivalent to $a^{n} \equiv a \pmod{n}$. In this way, we have proved Fermat's Little Theorem, which can be considered as a special case of Euler's Theorem when $n$ is a prime number.

### 3.2 Code Implementation

You can verify Euler's Theorem in Python:

```python
def gcd(a, b):
    while b:
        a, b = b, a % b
    return a

def euler_phi(n):
    count = 0
    for i in range(1, n + 1):
        if gcd(n, i) == 1:
            count += 1
    return count

def euler_theorem(a, n):
    if gcd(a, n) != 1:
```