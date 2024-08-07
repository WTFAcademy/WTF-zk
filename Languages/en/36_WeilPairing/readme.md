---
title: 36. Weil Pairing
tags:
  - zk
  - abstract algebra
  - elliptic curve
  - group theory
  - finite field
  - pairing
---

# WTF zk Tutorial 36: Weil Pairing

In this lesson, we will introduce the Weil Pairing, which plays an important role in pairing-based encryption algorithms and zero-knowledge proofs.

## 1. Weil Pairing

### 1.1 Derivation

The Weil Pairing is a bilinear pairing based on elliptic curves. Let's define the elliptic curve $E(K)$ over a field $K$. Based on the torsion group properties discussed earlier, the $m$-torsion group $E[m]$ is isomorphic to $\mathbb{Z}/m\mathbb{Z} \times \mathbb{Z}/m\mathbb{Z}$. The Weil Pairing $e_m(P,Q)$ maps two points $P, Q$ on $E[m]$ to $\mu_m$, which can be defined as follows:

$$
e_m(P,Q): E[m] \times E[m] \to \mu_m
$$

Here, $\mu_m$ denotes the set of $m$-th roots of unity, which are the elements $z$ that satisfy the equation $z^m = 1$.

For a rational function $f$ defined on the elliptic curve, we can define its principal divisor (in terms of points on the elliptic curve) as:

$$ 
D_f = \text{div}(f) = \sum_{P \in E}{n_P[P]} 
$$

According to the principal divisor theorem, we can always find a rational function $f = f_Q$ whose divisor satisfies:

$$
D_f = \text{div}(f) = m[Q] - m[O]
$$

Since this divisor satisfies $\text{deg}(D_f) = m - m = 0$ and $\text{sum}(D_f) = mQ - mO = O - mO = O$ (where $Q$ is a point on the $m$-torsion group), we can conclude that $f$ is a valid function.

Next, let's define the $[m]$-th scalar multiplication mapping $[m]: E \to E$, where $Q' \in E[m^2]$ is a point on the elliptic curve that satisfies $[m]Q' = Q$. We also define the inverse mapping $[m]^*$ of $[m]$, which finds all points that are mapped to a specific point $Q$ by $m$ times. In other words, it finds the points $Q$ that satisfy $Q' = [m]^*Q$. According to the principal divisor theorem, we can find a rational function $g = g_Q$ whose divisor satisfies:

$$
D_g = \text{div}(g) = [m]^* [Q] - [m]^* [O] = \sum_{R \in E[m]}{[Q' + R] - [R]}
$$

This indicates that $g$ has zeros at all $[m]^* Q$ and poles at all $[m]^* O$. Since $[m]Q'=Q$, $[m]^*(Q)$ is simply $Q'$ plus all the points in $E[m]$ (the $[m]$ mapping is a surjection from the $m$-torsion group to itself). According to the definition of the torsion group, $[m]^*O$ is simply all the points in $E[m]$. It can be easily verified that $\text{deg}(D_g) = m^2 - m^2 = 0$ and $\text{sum}(D_f) = m^2 Q' + \sum_{R \in E[m]}{R - R} = O - m^2O = O$ (the torsion group $E[m]$ has a total of $m^2$ elements).

We can also verify that $f \circ [m]$ and $g^m$ have the same divisor. Here, $f \circ [m] = f([m]Q)$ means that before applying $f$ at each point $Q$, we first transform $Q$ into its $m$-th multiple $[m]P$. Thus, $f \circ [m]$ has zeros at all $[m]^*Q$ with a multiplicity of $m$, and it has poles at all $[m]^*O$ with a multiplicity of $m$. As for $g^m$, its zeros and poles are located at the same positions as $g$, but with multiplicities multiplied by $m$. Therefore, we have $\text{div}(f \circ [m])=\text{div}(g^m)$. According to the uniqueness theorem of divisors, the functions $f \circ [m]$ and $g^m$ are constant multiples of each other. Thus, we can assume:

$$
f \circ [m] = g^m
$$

Now, let's assume another point $P$ on the torsion group $E[m]$ such that $[m]P = O$. Then, for any point $X$ on the elliptic curve, we have:

$$
g(X+P)^m = f([m]X + [m]P) = f([m]X) = g(X)^m
$$

In other words, $g^m$ has the same value at points $X$ and $X+P$. We can define a new function $e_m(P, Q) = \frac{g_Q(X+P)}{g_Q(X)}$. According to the above equation, we have $e_m(P, Q)^m = 1$, which means $e_m(P, Q) \in \mu_m$ and is one of the $m$-th roots of unity. Additionally, according to the properties of algebraic geometry (which are not covered in this tutorial), $e_m(P, Q)$ is a constant that is independent of the choice of point $X$.

This $e_m(P,Q)$ is known as the Weil Pairing, and its definition is as follows: the Weil Pairing $e_m$ maps two points $P, Q$ on the $m$-torsion group of an elliptic curve to the $m$-th roots of unity:

$$
e_m: E[m] \times E[m] \to \mu_m
$$

Its specific form is:

$$
e_m(P, Q) = \frac{g_Q(X+P)}{g_Q(X)}
$$

where $X$ is a point on the elliptic curve $E$ that allows $g_Q(X+P)$ and $g_Q(X)$ to be well-defined and non-zero.

### 1.2 Properties

**Property 1. Bilinearity:** For torsion points $P, Q, R$ on $E[m]$, we have $e_m(P + R, Q) = e_m(P, Q) e_m(R, Q)$ and $e_m(P, Q + R) = e_m(P, Q) e_m(P, Q)$.

<details><summary>Click to expand the proof👀</summary>

**Proof of $e_m(P + R, Q) = e_m(P, Q) e_m(R, Q)$**

According to the definition of the Weil Pairing:

$$
e_m(P + R, Q) = \frac{g_Q(X+P + R)}{g_Q(X)} 
$$

$$
= \frac{g_Q(X+P + R)}{g_Q(X+P)} \frac{g_Q(X+P)}{g_Q(X)} 
$$

Let $X+P = Y$, then we have:

$$
= \frac{g_Q(Y + R)}{g_Q(Y)} \frac{g_Q(X+P)}{g_Q(X)} 
$$

$$
= e_m(R, Q) e_m(P, Q)
$$

Q.E.D.

**Proof of $e_m(P, Q + R) = e_m(P, Q) e_m(P, R)$**

This proof is relatively difficult and requires the use of related content from the theory of divisors. First, we define $f_Q, f_R, f_S, g_Q, g_R, g_S$ as functions of points $Q, R, S= Q+R$. Then, we define a function $h$ on the elliptic curve that satisfies:

$$
\text{div}(h) = (Q+R) - (Q) - (R) + (O)
$$

According to the divisor theorem, we have:

$$
\text{div}(\frac{f_S}{f_Qf_R}) = m \text{div}(h)
$$

Therefore, $f_S = c f_Q f_R h^m$, where $c$ is a constant. Since $f_i \circ [m] = g_i^m$, we compose both sides of the equation with $[m]$:

$$
g_S = c'g_Qg_R(h \circ [m])
$$

Therefore:

$$
e_m(P, Q+R) = \frac{g_S(X + P)}{g_S(X)} = \frac{g_Q(X+P)g_R(X+P)h([m]X + [m]P)}{g_Q(X)g_R(X)h([m]X)}
$$

Since $[m]P = O$, the equation simplifies to:

$$
= \frac{g_Q(X+P)g_R(X+P)}{g_Q(X)g_R(X)} = e_m(P, Q) e_m(P,R)
$$

Q.E.D.

</details>

**Property 2. Non-degeneracy:** If $e_m(P,Q) = 1$ holds for all $P \in E[m]$, then $Q = O$.

**Property 3. Antisymmetry:** $e_m(P, Q) = e_m(Q, P)^{-1}$, and $e_m(P, P) = 1$.

## 2. Common Form of Weil Pairing

The $g$ function in the Weil Pairing introduced in the previous section is computationally expensive to compute. Therefore, we often use another form:

$$
e_m(P, Q) = \frac{f_P(Q+X)}{f_P(X)} / \frac{f_Q(P-X)}{f_Q(-X)}
$$

Here, $P, Q$ are points on the $m$-torsion group $E[m]$ of an elliptic curve, $X$ is any point on the elliptic curve that satisfies $X \notin \set{O, P, -Q, P-Q}$, and $f_P$ and $f_Q$ are rational functions defined on the elliptic curve. These functions satisfy:

$$
\text{div}(f_P) = m[P] - m[O]
$$

$$
\text{div}(f_Q) = m[Q] - m[O]
$$

This form of the Weil Pairing $e_m(P, Q) \in \mu_m$ also satisfies the properties mentioned in the previous section: bilinearity, non-degeneracy, and antisymmetry.

### 2.1 Example

Let's provide an example of the Weil Pairing. Consider the elliptic curve $E: y^2 = x^3 - x \pmod{5}$ defined over $F_5$. It has three roots $\alpha_1, \alpha_2, \alpha_3$, corresponding to $0, -1, 1$, which correspond to three points on the elliptic curve: $P_1(0,0), P_2(-1,0), P_3(1,0)$. Since they satisfy $2P_1 = 2P_2 = 2P_3 = O$, they form the $2$-torsion group of the elliptic curve $E[2] = \set{P_1, P_2, P_3, O}$. For the points $P_i$, we can define rational functions $f_{Pi} = x - \alpha_i$, and the corresponding principal divisors satisfy:

$$
\text{div}(f_{Pi}) = 2[P_i] - 2[O]
$$

Let's take $P_1, P_3$, and another point $X = (2,1)$ on the elliptic curve to calculate the Weil Pairing:

$$
e_2(P_1, P_3) = \frac{f_1(P_3+X)}{f_1(X)} / \frac{f_3(P_1-X)}{f_3(-X)}
$$

Here, $P_3 + X = (3,3)$, $P_1 - X = (2, 1)$, $-X = (2, 4)$, $f_1(P_3+X) = 3$, $f_1(X)= 2$, $f_3(P_1-X) = 1$, $f_3(-X) = 1$. Therefore, the Weil Pairing is:

$$
e_2(P_1, P_3) = \frac{3}{2} / \frac{1}{1} = 3 * 3 = -1 \pmod 5
$$

We can see that $e_2(P_1, P_3) = -1 \in \mu_2$.

## 3. Summary

In this lesson, we introduced the derivation and two forms of the Weil Pairing. The derivation process is quite complex, so it is sufficient to remember the conclusions when applying it. In the next lesson, we will introduce efficient algorithms for computing the Weil Pairing.