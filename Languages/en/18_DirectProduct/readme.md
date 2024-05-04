---
title: 18. Direct Product of Groups
tags:
  - zk
  - abstract algebra
  - group theory
  - direct product
---

# Tutorial 18: Direct Product of Groups

In this tutorial, we will explore the direct product of groups, a method of combining simple groups to generate more complex groups. We will also revisit the Chinese Remainder Theorem and prove its connection to the direct product of groups.

## 1. Direct Product of Groups

The direct product of groups combines the operations of two or more groups to form a new group.

**Definition:** Given two groups $(G, \cdot)$ and $(H, \circ)$, their direct product $G \times H$ is a new group consisting of all possible ordered pairs $(g, h)$, where $g \in G$ and $h \in H$. The operation on $G \times H$ is denoted by $*$, and for any $g_1, g_2 \in G$ and $h_1, h_2 \in H$,

$$
(g_1, h_1) * (g_2, h_2) = (g_1 \cdot g_2, h_1 \circ h_2)
$$

The group $(G \times H, *)$ satisfies the four fundamental properties of a group:

1. **Closure:** For any elements $(g_1, h_1), (g_2, h_2)$ belonging to $G \times H$, $(g_1, h_1) * (g_2, h_2) = (g_1 \cdot g_2, h_1 \circ h_2)$ still belongs to $G \times H$.

2. **Associativity:** Inherited from groups $G$ and $H$.

3. **Identity Element:** The identity element of $G \times H$ is $(e_g, e_h)$.

4. **Inverse Element:** For every element $(g, h)$ in the group, there exists an inverse element $(g, h)^{-1} = (g^{-1}, h^{-1})$, such that $(g, h) * (g^{-1}, h^{-1}) = (e_g, e_h)$.

For example, the direct product $\mathbb{Z}^2$ of two additive groups of integers is a group formed by all integer vectors $(x, y)$. The operation is vector addition, given by $(x_1, y_1) + (x_2, y_2) = (x_1 + x_2, y_1 + y_2)$.

Another example is the direct product $\mathbb{Z}_3 \times \mathbb{Z}_5$ of $\mathbb{Z}_3$ and $\mathbb{Z}_5$, which is a set of all possible ordered pairs $(x, y)$, where $x \in \mathbb{Z}_3$ and $y \in \mathbb{Z}_5$. The order (number of elements) of this direct product group is $15$, exactly equal to $3 \times 5$.

## 2. Properties of Direct Product

**Property 1: The order of the direct product of two groups is equal to the product of their orders.** That is, $|G \times H| = |G||H|$.

<details><summary>Click to expand the proof👀</summary>

According to the definition, the direct product $G \times H$ consists of all possible ordered pairs $(g, h)$, where $g \in G$ and $h \in H$. For each element in $G$, we can construct $|H|$ different elements in $G \times H$. Group $G$ has $|G|$ distinct elements in total. Therefore, $G \times H$ has $|G||H|$ elements, i.e., $|G \times H| = |G||H|$. Proof completed.

</details>

$|\mathbb{Z}_3| = 3$, $|\mathbb{Z}_5| = 5$, so $|\mathbb{Z}_3 \times \mathbb{Z}_5| = 15$.

**Property 2: The order of an element $(g, h)$ in the direct product $G \times H$ is the least common multiple of $|g|$ and $|h|$.** That is, $|(g, h)| = \text{lcm}(|g|,|h|)$. In particular, if $|g|$ and $|h|$ are coprime, then the order of $(g, h)$ is $|g||h|$.

<details><summary>Click to expand the proof👀</summary>

Let $k = |(g, h)|$ be the smallest integer such that $(g, h)^k = (e_g, e_h)$. Since $(g, h)^k = (g^k, h^k)$, we have $g^k = e_g$ and $h^k = e_h$. Hence, $k$ is divisible by both $|g|$ and $|h|$. As $k$ is the smallest integer satisfying this condition, we have $k = \text{lcm}(|g|,|h|)$. Proof completed.

If $|g|$ and $|h|$ are coprime, then $\text{lcm}(|g|,|h|) = |g||h|$. Proof completed.

</details>

In $\mathbb{Z}_3$, the order of element $1$ is $|1|= 3$; in $\mathbb{Z}_5$, the order of element $1$ is $|1|= 5$. Since $\gcd(3,5)=1$, the order of element $1$ in $\mathbb{Z}_3 \times \mathbb{Z}_5$ is $|1|= 3 \times 5 = 15$.

**Property 3: If groups $G$ and $H$ are cyclic groups with orders $|G|$ and $|H|$, respectively, then the direct product $G \times H$ is a cyclic group if and only if $|G|$ and $|H|$ are coprime.**

<details><summary>Click to expand the proof👀</summary>

**Necessity:**

Let $G = \left \langle \, x \, \right \rangle$ and $H = \left \langle \, y \, \right \rangle$ be cyclic groups with orders $|G| = m$ and $|H| = n$, respectively, such that $m$ and $n$ are coprime. Let $(x, y)^k = (e_G, e_H)$. Then we have $(x, y)^k = (x^k, y^k) = (e_G, e_H)$.

Therefore, we have $x^k = e_G$ and $y^k = e_H$. According to the properties of the order of elements, we have $m|k$ and $n|k$. As $\gcd(m,n) = 1$, we have $mn|k$.

Also, we have $(x, y)^{mn} = (x^k, y^k) = (e_G, e_H)$, which implies $k|mn$. Thus, the order $|(x, y)| = k = mn$. According to Property 1, we have $|G \times H| = |G||H| = mn$. Therefore, the element $(x, y)$ can generate the entire group $G \times H$, and thus $G \times H$ is a cyclic group. Proof completed.

**Sufficiency:**

$|G| = m$ and $|H| = n$. Assume that $G \times H = \left \langle \, (x, y) \, \right \rangle$ is a cyclic group. According to Property 1, we have $|G \times H| = |G||H| = mn$. Since the order of a cyclic group is equal to the order of its generator, we have $|(x, y)| = mn$. According to Property 2, we have $|(x, y)| = \text{lcm}(|x|, |y|)$. Therefore, $\text{lcm}(|x|, |y|) = mn$.

According to the relationship between the greatest common divisor and the least common multiple, we have $|x||y| = \gcd(|x||y|) \text{lcm}(|x|, |y|) =  \gcd(|x||y|) mn$. As $|x| \leq m$ and $|y| \leq n$, we have $|x||y| \leq mn$. Thus, the equation holds if and only if $\gcd(|x||y|) = 1$, which means $m$ and $n$ are coprime. Proof completed.

</details>

The direct product $\mathbb{Z}_3 \times \mathbb{Z}_5$ is a cyclic group with the generator $(1, 1)$ and order $15$.

## 3. Revisiting the Chinese Remainder Theorem

In number theory, we have learned about the Chinese Remainder Theorem, which can be used to solve systems of congruences. Let's briefly review it:

Given pairwise coprime integers $m_1, m_2,...,m_n$, where $\gcd(m_i,m_j) = 1$ for $i \ne j$, the system of congruences consists of $n$ equations:

$$
x \equiv a_1 \pmod{m_1}
$$

$$
x \equiv a_2 \pmod{m_1}
$$

$$
...
$$

$$
x \equiv a_n \pmod{m_n}
$$

The system of congruences has a unique solution modulo $M=m_1 \cdot m_2 \cdot... \cdot m_n$:

$$
x \equiv \sum_{i=1}^{n}{a_ib_ib_i'} \pmod{M}
$$

where $b_i = M/m_i$ (i.e., the product of all moduli except $m_i$) and $b_i'=b_i^{-1} \pmod{m_i}$ (i.e., the inverse of $b_i$ modulo $m_i$).

Now we can better understand the Chinese Remainder Theorem using the concepts of group isomorphism and direct product:

If $m_i$ are pairwise coprime, then the mapping $f: x \mod M \to (x \mod m_1,..., x \mod m_n)$ defines an isomorphism between the group $Z_M$ and the direct product $Z_{m_1} \times ... \times Z_{m_n}$. This mapping is also known as the Chinese Remainder Isomorphism.

<details><summary>Click to expand the proof👀</summary>

**Homomorphism**

First, we prove that $f$ is a group homomorphism. For any $a, b \in \mathbb{Z}_M$, we have $f(a+b) = a+b \mod M =  (a+b \mod m_1,..., a+b \mod m_n) = (a \mod m_1,..., a \mod m_n) + (b \mod m_1,..., b \mod m_n) = f(a) + f(b)$. Therefore, $f$ is a group homomorphism. Proof completed.

**Isomorphism**

Since $m_i$ are pairwise coprime and $Z_{m_i}$ are cyclic groups with orders $m_i$, we can easily extend Property 3 about direct products to the case of $n$ groups, which implies that $Z_{m_1} \times ... \times Z_{m_n}$ is a cyclic group with order $M = m_1 \cdot m_2 \cdot... \cdot m_n$. Using the isomorphism property of cyclic groups, we know that any finite cyclic group of order $M$ is isomorphic to the additive group $Z_M$. Therefore, $Z_M$ is isomorphic to $Z_{m_1} \times ... \times Z_{m_n}$. Proof completed.

</details>

Since $Z_M$ and $Z_{m_1} \times ... \times Z_{m_n}$ are isomorphic, their elements are in one-to-one correspondence, which means that the system of congruences has a unique solution modulo $M$.

## 4. Summary

In this tutorial, we introduced the direct product of groups, a method of combining simple groups to generate more complex groups. By exploring the properties of the direct product, we gained a better understanding of the Chinese Remainder Theorem and its connection to group theory.