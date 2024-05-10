---
title: 18. Direct Product of Groups
tags:
  - zk
  - abstract algebra
  - group theory
  - direct product
---

# WTF zk Tutorial Lesson 18: Direct Product of Groups

In this lesson, we introduce the direct product of groups, which can combine simple groups to form complex ones. Furthermore, we will revisit the Chinese Remainder Theorem and prove the Chinese Remainder Mapping through it.

## 1. Direct Product of Groups

The direct product of groups is a combination of the operations of two or more groups and can be used to generate a new group.

**Definition:** Given two groups $(G, 🐔)$ and $(H, 🦆)$, their direct product $G \times H$ is a new group consisting of all possible ordered pairs $(g, h)$, where $g \in G$ and $h \in H$. The operation of $G \times H$ is denoted by $🐶$, and for any $g_1, g_2 \in G$ and $h_1, h_2 \in H$,

$$
(g_1, h_1) 🐶 (g_2, h_2) = (g_1 🐔 g_1, h_1 🦆 h_2)
$$

$(G \times H, 🐶)$ satisfies the 4 basic properties of a group:

1. **Closure:** Any elements $(g_1, h_1), (g_2, h_2)$ belong to $G \times H$, and $(g_1, h_1) 🐶 (g_2, h_2) = (g_1 🐔 g_1, h_1 🦆 h_2)$ also belongs to $G \times H$.

2. **Associativity:** Inherited from groups $G$ and $H$.

3. **Existence of Identity Element:** The identity element of $G \times H$ is $(e_g, e_h)$.

4. **Existence of Inverse Element:** For each element $(g, h)$ in the group, there exists an inverse element $(g, h)^{-1} = (g^{-1}, h^{-1})$, such that $(g, h) 🐶 (g^{-1}, h^{-1}) = (e_g, e_h)$.

For example, the direct product $\mathbb{Z}^2$ of two integers' additive groups is the additive group formed by all integer vectors $(x,y)$. The operation is vector addition, given by $(x_1, y_1) + (x_2, y_2) = (x_1 + x_2, y_1 + y_2)$.

Another example is the direct product $\mathbb{Z}_3 \times \mathbb{Z}_5$ of $\mathbb{Z}_3$ and $\mathbb{Z}_5$, which consists of all possible ordered pairs $(x, y)$, where $x \in \mathbb{Z}_3$ and $y \in \mathbb{Z}_5$. The order (number of elements) of this direct product group is $15$, which equals $3 \times 5$.

## 2. Properties of Direct Product

**Property 1. The order of the direct product of two groups equals the product of their orders.** That is, $|G \times H| = |G||H|$.

<details><summary>Click to expand proof👀</summary>

According to the definition, the direct product $G \times H$ consists of all possible ordered pairs $(g, h)$, where $g \in G$ and $h \in H$. For each element in $G$, we can construct $|H|$ different elements in $G \times H$. Since there are $|G|$ different elements in group $G$, $G \times H$ has $|G||H|$ elements, i.e., $|G \times H| = |G||H|$. Proof completed.

</details>

$|\mathbb{Z}_3| = 3$, $|\mathbb{Z}_5| = 5$, so $|\mathbb{Z}_3 \times \mathbb{Z}_5| = 15$.

**Property 2. The order of the element $(g, h)$ in the direct product $G \times H$ is the least common multiple of $|g|$ and $|h|$.** That is, $|(g,h)| = \text{lcm}(|g|,|h|)$. Particularly, if $|g|$ and $|h|$ are coprime, then the order of $(g, h)$ is $|g||h|$.

<details><summary>Click to expand proof👀</summary>

Let $k = |(g,h)|$ be the smallest integer such that $(g,h)^k = (e_g, e_h)$. Since $(g,h)^k = (g^k, h^k)$, we have $g^k = e_g$ and $h^k = e_h$. Thus, $k$ divides both $|g|$ and $|h|$, and as $k$ is the smallest integer satisfying this condition, we have $k = \text{lcm}(|g|,|h|)$. Proof completed.

If $|g|$ and $|h|$ are coprime, then $\text{lcm}(|g|,|h|) = |g||h|$. Proof completed.

</details>

In $\mathbb{Z}_3$, the order of element 1 is $|1| = 3$; in $\mathbb{Z}_5$, the order of element 1 is $|1| = 5$. Since $\gcd(3,5) = 1$, in $\mathbb{Z}_3 \times \mathbb{Z}_5$, the order of element 1 is $|1| = 3 \times 5 = 15$.

**Property 3. If groups $G$ and $H$ are cyclic groups with orders $|G|$ and $|H|$, respectively, then the direct product $G \times H$ is cyclic if and only if $|G|$ and $|H|$ are coprime.**

<details><summary>Click to expand proof👀</summary>

**Necessity**

Let $G = \left \langle \, x \, \right \rangle$ and $H = \left \langle \, y \, \right \rangle$ be cyclic groups with orders $|G| = m$ and $|H| = n$, respectively, where $m$ and $n$ are coprime. Suppose $|(x, y)| = k$, then $(x,y)^k = (x^k, y^k) = (e_G, e_H)$.

Thus, $x^k = e_G$ and $y^k = e_H$, implying $m | k$ and $n | k$. As $\gcd(m,n) = 1$, we have $mn | k$.

Also, $(x,y)^{mn} = (x^k, y^k) = (e_G, e_H)$, which implies $k | mn$. Therefore, the order $|(x, y)| = k = mn$. By Property 1, $|G \times H| = |G||H| = mn$. Hence, the element $(x,y)$ generates the entire group, and $G \times H$ is cyclic. Proof completed.

**Sufficiency**

Let $|G| = m$ and $|H| = n$. Assume $G \times H = \left \langle \, (x,y) \, \right \rangle$ is cyclic. According to Property 1, $|G \times H| = |G||H| = mn$. As the order of a cyclic group is equal to the order of its generator, we have $|(x,y)| = mn$. By Property 2, $|(x,y)| = \text{lcm}(|x|, |y|)$. Thus, $\text{lcm}(|x|, |y|) = mn$.

Using the relationship between the greatest common divisor and the least common multiple, we have $|x||y| = \gcd(|x||y|) \text{lcm}(|x|, |y|) = \gcd(|x||y|) mn$. Since $|x| \leq m$ and $|y| \leq n$, we have $|x||y| \leq mn$. Therefore, the equation holds if and only if $\gcd(|x||y|) = 1$, implying that $m$ and $n$ are coprime. Proof completed.

</details>

The direct product $\mathbb{Z}_3 \times \mathbb{Z}_5$ is cyclic, generated by $(1,1)$, with an order of $15$.

## 3. Revisiting the Chinese Remainder Theorem

In elementary number theory, we introduced the Chinese Remainder Theorem, which can be used to solve systems of congruences. Let's briefly review:

Given integers $m_1, m_2,...,m_n$ pairwise coprime (for $i \ne j$, $\gcd(m_i,m_j) = 1$), the system of equations contains $n$ equations:

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

The system has a unique solution modulo $M=m_1 \cdot m_2 \cdot... \cdot m_n$:

$$
x \equiv \sum_{i=1}^{n}{a_ib_ib_i'} \pmod{M}
$$

where $b_i = M/m_i$ (i.e., the product of all modulus except $m_i$), and $b_i' = b_i^{-1} \pmod{m_i}$ (i.e., the inverse of $b_i$ modulo $m_i$).

Now we can better understand the Chinese Remainder Theorem through group isomorphism and direct products:

If $m_i$ are pairwise coprime, then the mapping $f: x \mod M \to (x \mod m_1,..., x \mod m_n)$ defines an isomorphism from $Z_M$ to $Z_{m_1} \times ... \times Z_{m_n}$. This mapping is also called the Chinese Remainder Mapping.

<details><summary>Click to expand proof👀</summary>

**Homomorphism**

Firstly, we prove that $f$ is a group homomorphism. For any $a, b \in \mathbb{Z}_M$, we have $f(a+b) = a+b \mod M =  (a+b \mod m_1,..., a+b \mod m_n) = (a \mod m_1,..., a \mod m_n) + (b \mod m_1,..., b \mod m_n) = f(a) + f(b)$. Therefore, $f$ is a group homomorphism. Proof completed.

**Isomorphism**

Since $m_i$ are pairwise coprime, $Z_{m_i}$ are all cyclic groups with orders $m_i$. We can easily generalize Property 3 of direct products to $n$ groups, leading to the conclusion that $Z_{m_1} \times ... \times Z_{m_n}$ is cyclic with an order of $M = m_1 \cdot m_2 \cdot... \cdot m_n$. Applying the isomorphism property of cyclic groups, any finite cyclic group of order $M$ is isomorphic to the additive group $Z_M$ of integers modulo $M$. Hence, $Z_M$ is isomorphic to $Z_{m_1} \times ... \times Z_{m_n}$. Proof completed.

</details>

Since $Z_M$ and $Z_{m_1} \times ... \times Z_{m_n}$ are isomorphic, their elements correspond one-to-one, implying that there exists a unique solution modulo $M$ for the system of congruences.

## 4. Summary

In this chapter, we introduced the direct product of groups, a method to generate a complex group from several simple ones. By utilizing the properties of group direct products, we revisited the Chinese Remainder Theorem and understood why systems of congruences with coprime moduli have unique solutions from the perspective of group theory.
