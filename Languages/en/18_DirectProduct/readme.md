First, we prove that $f$ is a group homomorphism. For any $a, b \in \mathbb{Z}_M$, we have $f(a+b) = a+b \mod M =  (a+b \mod m_1,..., a+b \mod m_n) = (a \mod m_1,..., a \mod m_n) + (b \mod m_1,..., b \mod m_n) = f(a) + f(b)$. Therefore, $f$ is a group homomorphism. Proof completed.

**Isomorphism**

The $m_i$'s are pairwise coprime, and $Z_{m_i}$ is a cyclic group with order $m_i$. We can easily generalize property 3 of direct product to the case of $n$ groups, and get the result that $Z_{m_1} \times ... \times Z_{m_n}$ is a cyclic group with order $M = m_1 \cdot m_2 \cdot... \cdot m_n$. Using the isomorphism property of cyclic groups, any finite cyclic group of order $M$ is isomorphic to the additive group $Z_M$ of integers modulo $M$. Therefore, $Z_M$ is isomorphic to $Z_{m_1} \times ... \times Z_{m_n}$. Proof completed.

Due to the isomorphism between $Z_M$ and $Z_{m_1} \times ... \times Z_{m_n}$, their elements correspond one-to-one. Therefore, the system of congruences has a unique solution modulo M.

## 4. Summary

In this lesson, we introduced the direct product of groups, which is a way to generate a complex group using several simple groups. By using the properties of group direct product, we revisited the Chinese Remainder Theorem and understood why a system of congruences with coprime moduli has a unique solution from the perspective of group theory.
title: 18. Direct Product of Groups
tags:
  - zk
  - abstract algebra
  - group theory
  - direct product
---

# WTF zk Tutorial 18: Direct Product of Groups

In this tutorial, we introduce the direct product of groups, which can generate complex groups from simple groups. Furthermore, we will revisit the Chinese Remainder Theorem and prove the Chinese Remainder Mapping using it.

## 1. Direct Product of Groups

The direct product of groups is a combination of the operations of two or more groups, which can be used to generate a new group.

**Definition:** Given two groups $(G, 🐔)$ and $(H, 🦆)$, their direct product $G \times H$ is a new group consisting of all possible ordered pairs $(g, h)$, where $g \in G$ and $h \in H$. The operation on $G \times H$ is denoted by $🐶$, and for any $g_1, g_2 \in G$ and $h_1, h_2 \in H$,

$$
(g_1, h_1) 🐶 (g_2, h_2) = (g_1 🐔 g_1, h_1 🦆 h_2)
$$

$(G \times H, 🐶)$ satisfies the four fundamental properties of a group:

1. **Closure:** For any elements $(g_1, h_1)$ and $(g_2, h_2)$ belonging to $G \times H$, $(g_1, h_1) 🐶 (g_2, h_2) = (g_1 🐔 g_1, h_1 🦆 h_2)$ still belongs to $G \times H$.

2. **Associativity:** Inherited from groups $G$ and $H$.

3. **Identity Element:** The identity element of $G \times H$ is $(e_g, e_h)$.

4. **Inverse Element:** For every element $(g, h)$ in the group, there exists an inverse element $(g, h)^{-1} = (g^{-1}, h^{-1})$ such that $(g, h) 🐶 (g^{-1}, h^{-1}) = (e_g, e_h)$.

For example, the direct product of two additive groups of integers, $\mathbb{Z}^2$, is the additive group formed by all integer vectors $(x,y)$. The operation is vector addition, given by $(x_1, y_1) + (x_2, y_2) = (x_1 + x_2, y_1 + y_2)$.

Another example is the direct product of $\mathbb{Z}_3$ and $\mathbb{Z}_5$, denoted $\mathbb{Z}_3 \times \mathbb{Z}_5$, which consists of all possible ordered pairs $(x, y)$, where $x \in \mathbb{Z}_3$ and $y \in \mathbb{Z}_5$. The order (number of elements) of this direct product group is $15$, which is equal to $3 \times 5$.

## 2. Properties of the Direct Product

**Property 1: The order of the direct product of two groups is equal to the product of their orders.** That is, $|G \times H| = |G||H|$.

<details><summary>Click to expand the proof👀</summary>

According to the definition, the direct product $G \times H$ consists of all possible ordered pairs $(g, h)$, where $g \in G$ and $h \in H$. For each element in $G$, we can construct $|H|$ different elements in $G \times H$. There are $|G|$ distinct elements in group $G$. Therefore, $G \times H$ has $|G||H|$ elements, which means $|G \times H| = |G||H|$. Proof complete.

</details>

$|\mathbb{Z}_3| = 3$, $|\mathbb{Z}_5| = 5$, so $|\mathbb{Z}_3 \times \mathbb{Z}_5| = 15$.

**Property 2: The order of an element $(g, h)$ in the direct product $G \times H$ is the least common multiple of $|g|$ and $|h|$.** That is, $|(g,h)| = \text{lcm}(|g|,|h|)$. In particular, if $|g|$ and $|h|$ are coprime, then the order of $(g, h)$ is $|g||h|$.

<details><summary>Click to expand the proof👀</summary>

Let $k = |(g,h)|$ be the smallest positive integer such that $(g,h)^k = (e_g, e_h)$. Since $(g,h)^k = (g^k, h^k)$, we have $g^k = e_g$ and $h^k = e_h$. Thus, $k$ is a common multiple of $|g|$ and $|h|$, and since it is the smallest such multiple, $k = \text{lcm}(|g|,|h|)$. Proof complete.

If $|g|$ and $|h|$ are coprime, then $\text{lcm}(|g|,|h|) = |g||h|$. Proof complete.

</details>

In $\mathbb{Z}_3$, the order of element $1$ is $|1| = 3$; in $\mathbb{Z}_5$, the order of element $1$ is $|1| = 5$. Since $\gcd(3,5) = 1$, the order of element $1$ in $\mathbb{Z}_3 \times \mathbb{Z}_5$ is $|1| = 3 \times 5 = 15$.

**Property 3: If the groups $G$ and $H$ are cyclic groups with orders $|G|$ and $|H|$ respectively, then the direct product $G \times H$ is a cyclic group if and only if $|G|$ and $|H|$ are coprime.**

<details><summary>Click to expand the proof👀</summary>

**Necessity**

Let $G = \left \langle \, x \, \right \rangle$ and $H = \left \langle \, y \, \right \rangle$ be cyclic groups with orders $|G| = m$ and $|H| = n$, where $m$ and $n$ are coprime. Suppose $|(x, y)| = k$, then we have $(x,y)^k = (x^k, y^k) = (e_G, e_H)$.

This implies $x^k = e_G$ and $y^k = e_H$. According to the property of the order of an element, we have $m|k$ and $n|k$. Since $\gcd(m,n) = 1$, we have $mn|k$.

Also, $(x,y)^{mn} = (x^k, y^k) = (e_G, e_H)$, so $k|mn$. Therefore, the order of the element $|(x, y)| = k = mn$. Using Property 1, we have $|G \times H| = |G||H| = mn$. Thus, the element $(x,y)$ can generate the entire group, and $G \times H$ is a cyclic group. Proof complete.

**Sufficiency**

$|G| = m$ and $|H| = n$. Suppose $G \times H = \left \langle \, (x,y) \, \right \rangle$ is a cyclic group. According to Property 1, we have $|G \times H| = |G||H| = mn$. Since the order of a cyclic group is equal to the order of its generating element, we have $|(x,y)| = mn$. According to Property 2, we have $|(x,y)| = \text{lcm}(|x|, |y|)$. Thus, $\text{lcm}(|x|, |y|) = mn$.

Using the relationship between the greatest common divisor and the least common multiple, we have $|x||y| = \gcd(|x||y|) \text{lcm}(|x|, |y|) = \gcd(|x||y|) mn$. And since $|x| \leq m$ and $|y| \leq n$, we have $|x||y| \leq mn$. Therefore, the equation holds if and only if $\gcd(|x||y|) = 1$, which means $m$ and $n$ are coprime. Proof complete.

</details>

The direct product $\mathbb{Z}_3 \times \mathbb{Z}_5$ is a cyclic group with the generator $(1,1)$ and order $15$.

## 3. Revisiting the Chinese Remainder Theorem

In number theory, we learned about the Chinese Remainder Theorem, which can be used to solve systems of congruences. Let's briefly review it:

For a set of integers $m_1, m_2, ..., m_n$ that are pairwise coprime (for $i \ne j$, $\gcd(m_i,m_j) = 1$), the system of congruences consists of $n$ equations:

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

The system has a unique solution modulo $M=m_1 \cdot m_2 \cdot ... \cdot m_n$:

$$
x \equiv \sum_{i=1}^{n}{a_ib_ib_i'} \pmod{M}
$$

where $b_i = M/m_i$ (the product of all modulus except $m_i$) and $b_i' = b_i^{-1} \pmod{m_i}$ (the inverse of $b_i$ modulo $m_i$).

Now we can better understand the Chinese Remainder Theorem through group isomorphism and direct product:

If $m_i$ are pairwise coprime, then the mapping $f: x \mod M \to (x \mod m_1, ..., x \mod m_n)$ defines an isomorphism between $Z_M$ and $Z_{m_1} \times ... \times Z_{m_n}$. This mapping is also known as the Chinese Remainder Mapping.

<details><summary>Click to expand the proof👀</summary>

**Homomorphism**