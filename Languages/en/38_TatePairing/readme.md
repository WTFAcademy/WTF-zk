---
title: 38. Tate Pairing
tags:
  - zk
  - abstract algebra
  - elliptic curve
  - group theory
  - finite field
  - pairing
---

# WTF zk Tutorial Lesson 38: Tate Pairing

In this lesson, we will introduce the concept of Tate Pairing and its variant, Ate Pairing. These pairings are designed to improve the efficiency of Weil Pairing.

## 1. Tate Pairing

Tate Pairing is a type of bilinear pairing defined on the elliptic curve $E(F_Q)$ over a finite field $F_Q$, where $q = p^n$.

**Definition:** Let $m$ be a prime number coprime to $q$ such that $q \equiv 1 \pmod{m}$, and $E[m] \cong \mathbb{Z}/m\mathbb{Z}$. The Tate Pairing maps two points $P, Q$ on the $m$-torsion group $E[m]$ to the finite field $F_q$:

$$
\hat{\tau}(P, Q) = \left(\frac{f_P(Q+X)}{f_P(X)}\right)^{\frac{q-1}{m}}
$$

Here, $X$ is any point on the elliptic curve that satisfies $f_P(Q+X)$ and $f_P(X)$ being nonzero. $f_P$ is a rational function defined on the elliptic curve $E(F_Q)$, and its divisor satisfies:

$$
\text{div}(f_P) = m[P] - m[O]
$$

Tate Pairing has the following properties:

**Property 1. Bilinearity:** Tate Pairing satisfies $\hat{\tau}(P + R, Q) = \hat{\tau}_m(P, Q) \hat{\tau}_m(R, Q)$ and $\hat{\tau}_m(P, Q + R) = \hat{\tau}_m(P, Q) \hat{\tau}_m(P, R)$.

**Property 2. Non-degeneracy:** For a nonzero point $P \in E[m]$, if $\hat{\tau}_m(P,P) \in \mu_m$ holds, where $\mu_m$ is the set of $m$-th roots of unity, then $\hat{\tau}_m(P,P) ^m = 1$ and $\hat{\tau}_m(P,P) ^m \neq 1$.

**Property 3. Efficient Computation:** While Weil Pairing requires the computation of $f_P$ and $f_Q$, Tate Pairing only requires the computation of $f_P$, which can be done more efficiently using Miller's algorithm.

## 2. Ate Pairing

Ate Pairing is a variant of Tate Pairing that optimizes the computation process. Ate Pairing utilizes the Frobenius mapping and a smaller loop length to reduce the number of iterations in the computation, thus accelerating the pairing computation. Pairings on Ethereum are implemented based on Ate Pairing, as detailed in [EIP-197](https://eips.ethereum.org/EIPS/eip-197).

Next, we will provide an example of pairing using the py_ecc library in Ethereum. In this example, we take two generators $G_1$ and $G_2$ on the elliptic curve, where $G_2$ is represented by complex numbers $a+bi$, which may appear more complex but have the same properties as before.

Then, we take three numbers $a = 69, b = 420, c = ab = 28980$, and compute three points $A = aG_2, B = bG_1, C = cG_2$. We then verify if $e(A, B)$ is equal to $e(G_2, C)$ using pairings.

Since $ab = c$, we have $e(A, B) = e(aG_2, bG_1) =  abe(G_2, G_1) = ce(G_2, G_1) = e(G_2, cG_1) = e(G_2, C)$, so the two pairings are equal. Thus, we can verify $ab = 28980$ through pairings of $A, B, C, G_2$ without knowing the values of $a, b$. It's quite remarkable.

```python
from py_ecc.bn128 import G1, G2, pairing, add, multiply, eq

print(G1)
print(G2)
print("\n")

a = 69
b = 420
c = a * b
A = multiply(G2, a)
B = multiply(G1, b)
pair_A_B = pairing(A, B)
print("Pairing of points A and B: ",pair_A_B)
print("\n")

C = multiply(G2, c)
pair_G2_C = pairing(C, G1)
print("Pairing of points G2 and C: ",pair_G2_C)
print("\n")

print("Is pair_A_B == pair_G2_C? ", pair_A_B == pair_G2_C)

# Output
# (1, 2)
# ((10857046999023057135944570762232829481370756359578518086990519993285655852781, 11559732032986387107991004021392285783925812861821192530917403151452391805634), (8495653923123431417604973247489272438418190587263600148770280649306958101930, 4082367875863433681332203403145435568316851327593401208105741076214120093531))


# Pairing of points A and B:  (19735667940922659777402175920395455799125563888708961631093487249968872129612, 1976543863057094994989237517814173599120655827589866703826517845909315612857, 19686523416572620016989349096902944934819162198495809257491045534399198954254, 5826646852844954420149583478015267673527445979905768896060072350584178989060, 2064185964405234542610947637037132798744921024553195185441592358018988389207, 8341934863294343910133492936755210611939463215146220944606211376003151106114, 12807669762027938768857302676393862225355612177677457846751491105239425227277, 5741126950795831539169012545403256931813076395529913201048083937620822856065, 11074901068523180915867722424807487877141140784438044188857570704539589417315, 19327019285776193278582429402961044775129507055467003359023290900912857119476, 17306986078986604236447922180440988200852103029519452658980599808670992125088, 13188937242065601189938233945175869194113210620973903647453917247887073581439)


# Pairing of points G2 and C:  (19735667940922659777402175920395455799125563888708961631093487249968872129612, 1976543863057094994989237517814173599120655827589866703826517845909315612857, 19686523416572620016989349096902944934819162198495809257491045534399198954254, 5826646852844954420149583478015267673527445979905768896060072350584178989060, 2064185964405234542610947637037132798744921024553195185441592358018988389207, 8341934863294343910133492936755210611939463215146220944606211376003151106114, 12807669762027938768857302676393862225355612177677457846751491105239425227277, 5741126950795831539169012545403256931813076395529913201048083937620822856065, 11074901068523180915867722424807487877141140784438044188857570704539589417315, 19327019285776193278582429402961044775129507055467003359023290900912857119476, 17306986078986604236447922180440988200852103029519452658980599808670992125088, 13188937242065601189938233945175869194113210620973903647453917247887073581439)


# Is pair_A_B == pair_G2_C?  True
```

## 3. Summary

In this lesson, we discussed Tate Pairing and its variant, Ate Pairing, which are more efficient than Weil Pairing in terms of computation. Ate Pairing has been adopted by Ethereum for pairing computation.