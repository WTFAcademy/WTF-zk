---
title: 39. Weil Pairing on Extension Fields
tags:
  - zk
  - abstract algebra
  - elliptic curve
  - group theory
  - finite field
  - pairing
---

# WTF zk Tutorial Lesson 39: Weil Pairing on Extension Fields

In this tutorial, we will discuss the Weil pairing on extension fields. This concept involves two important ideas: embedding degree and the MOV algorithm. Understanding these concepts will deepen your understanding of bilinear pairings and elliptic curves.

## 1. Embedding Degree

When constructing pairings, we rely on torsion groups that have a special property. For an elliptic curve $E(\mathbb{F}_p)$, if $m$ and $p$ are coprime, then there exists a positive integer $k$ such that

$$
E(\mathbb{F}_{p^{k}})[m] \cong \mathbb{Z}/m\mathbb{Z} \times \mathbb{Z}/m\mathbb{Z}
$$

In other words, we need to find a suitable value for $k$ in order to construct the pairing. The embedding degree is the smallest value of $k$ that satisfies this condition.

### 1.1 Computing the Embedding Degree

Let's say the order of the elliptic curve $E(\mathbb{F}_p)$ is $n$, and $m$ is a prime factor of $n$. The embedding degree is the smallest positive integer $k$ that satisfies the equation $m | (p^k - 1)$.

According to Fermat's Little Theorem, we have $p^{m-1} \equiv 1 \pmod{m}$. Therefore, for any curve and any value of $m$, there is always an embedding degree. We denote the embedding degree corresponding to a specific value of $m$ as $k(m)$.

### 1.2 Example

Let's take the elliptic curve $E(\mathbb{F}_ {19})$ as an example, with the equation $y^2 = x^3 - x + 1$. The elliptic curve has a total of 22 elements, which means its order is $n = 22$. Let's choose the largest prime factor of 22, which is $m = 11$, and compute the 11-torsion group on the elliptic curve. This group has 11 points. However, $E(\mathbb{F}_{19})[11]$ is not isomorphic to $\mathbb{Z}/11\mathbb{Z} \times \mathbb{Z}/11\mathbb{Z}$ because their orders are different (11 vs 121).

Now let's calculate the embedding degree $k(11)$:

$$
(19^1 -1) \mod 11 = 7
$$

$$
(19^2 -1) \mod 11 = 8
$$

$$
(19^3 -1) \mod 11 = 5
$$

$$
(19^4 -1) \mod 11 = 3
$$

$$
(19^5 -1) \mod 11 = 9
$$

$$
(19^6 -1) \mod 11 = 2
$$

$$
(19^7 -1) \mod 11 = 1
$$

$$
(19^8 -1) \mod 11 = 4
$$

$$
(19^9 -1) \mod 11 = 6
$$

$$
(19^{10} -1) \mod 11 = 0
$$

Therefore, for the elliptic curve $E(\mathbb{F}_ {19})$ and $m = 11$, the embedding degree $k(11) = 10$. In other words, $E(\mathbb{F}_{19^{10}})[11]$ is isomorphic to $\mathbb{Z}/11\mathbb{Z} \times \mathbb{Z}/11\mathbb{Z}$ and can be used for pairings.

## 2. The MOV Algorithm

The MOV algorithm is a method to transform the elliptic curve discrete logarithm problem (ECDLP) on an elliptic curve into the discrete logarithm problem (DLP) on a finite field. Its purpose is to leverage the relative ease of solving the discrete logarithm problem on finite fields to attack the more challenging discrete logarithm problem on elliptic curves.

The core idea of the MOV algorithm is to use pairings on elliptic curves to transform the discrete logarithm problem $Q = xP$ on an elliptic curve into the discrete logarithm problem $e(Q, T') = e(P,T')^x$ on the finite field $F_{p^k}^*$, and then solve it.

### 2.1 Algorithm Steps

Given a base point $P$ on the elliptic curve $E(F_p)$ and a point $Q = xP$, the goal is to find $x$.

1. **Compute the Rank of the Group**: Calculate the number of group elements $N$ on the elliptic curve $E(F_p)$.
2. **Compute the Order of the Point**: Calculate the order $m$ of the point $P$, where $m | N$. Since $Q = xP$, the order of $Q$ is also $m$.
3. **Compute the Embedding Degree**: Find the smallest positive integer $k$ that satisfies $m | (p^k - 1)$, which is the embedding degree.
4. **Choose Points T and T'**: Select a random point $T \in F_{p^k}$ such that $T \notin F_{p}$. Then compute the point $T' = (N/m)T$, where the order of $T'$ is $m$.
5. **Construct the Pairing**: Use the Weil pairing (or Tate pairing) to construct a bilinear map $e: E[m] \times E[m] \rightarrow \mathbb{F}_{p^k}^*$ on the elliptic curve $E(\mathbb{F}_{p^k})$.
6. **Transform the Problem**: Compute the pairings

  $$
  \alpha = e_m(P, T') \in \mathbb{F}_{p^k}^*
  $$

  $$
  \beta = e_m(Q, T') \in \mathbb{F}_{p^k}^*
  $$

7. **Solve the DLP**: Solve the DLP problem $\beta = \alpha^x$ in $\mathbb{F}_{p^k}^*$.
8. **Solve the ECDLP**: Based on the bilinearity property, the obtained value of $x$ from the previous step is the solution to $Q = xP$. In other words, $\beta = e_m(Q, T') = e_m(xP, T') = e_m(P, T')^x = \alpha ^x$.

### 2.2 Security Implications

The MOV algorithm reveals that if the embedding degree $k$ of an elliptic curve is small, the security of the discrete logarithm problem on that curve is compromised. This is because the discrete logarithm problem on the finite field $\mathbb{F}_{p^k}$ can be solved more efficiently using index calculus algorithms. Therefore, to ensure the security of elliptic curve cryptosystems, it is advisable to choose elliptic curves with larger embedding degrees.

However, if the embedding degree $k$ of an elliptic curve is large, the field $E(\mathbb{F}_{p^k})$ used for pairing will be very large, resulting in low computational efficiency. In practice, we need to strike a balance between security and efficiency by choosing elliptic curves with as small embedding degrees as possible while still resisting MOV attacks. The two elliptic curves, `alt_bn128` and `bls12_381`, used for pairing in Ethereum, have embedding degrees of 12, which provide a good balance between security and pairing efficiency.

## 3. Summary

In this tutorial, we have discussed the Weil pairing on extension fields and related concepts. The embedding degree is an important parameter that specifies the extension field required for the Weil pairing, and it affects the security and efficiency of elliptic curve applications. The MOV algorithm provides a way to exploit the weakness of elliptic curves with low embedding degrees by transforming the elliptic curve discrete logarithm problem (ECDLP) into the relatively easier discrete logarithm problem (DLP) on a finite field. When selecting elliptic curves, we need to consider both security and pairing efficiency, and choose elliptic curves with moderate embedding degrees.
