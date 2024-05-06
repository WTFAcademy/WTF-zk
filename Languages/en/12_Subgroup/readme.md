---
title: 12. Subgroup
tags:
  - zk
  - basic
  - abstract algebra
  - group theory
  - subgroup
---

# WTF zk Tutorial Lecture 12: Subgroup

In this lecture, we introduce the concept of a subgroup. A subgroup can be seen as the "child" of a group, consisting of a subset of elements from the group while still satisfying the group's definition. It helps us understand the internal structure of the group.

## 1. Definition of Subgroup

Let $(G, 🐔)$ be a group, and let $H$ be a non-empty subset of $G$. If $H$ also forms a group with respect to the group operation $🐔$, then $(H, 🐔)$ is called a subgroup of $(G, 🐔)$, denoted $(H, 🐔) \leq (G, 🐔)$. Sometimes for convenience, the operation symbol may be omitted when the context is clear, using set notation to represent a group, such as $H \leq G$.

To become a subgroup, the elements of $H$ need to belong to $G$, and additionally, $H$ must satisfy the four fundamental properties of a group: closure, associativity, existence of identity element, and existence of inverses.

Let's understand the concept of subgroup through some examples:

### 1.1 Subgroups of the Integer Additive Group

Consider the integer additive group $(\mathbb{Z}, +)$. We can find some of its subgroups, such as:

- **The Even Integer Group:** It consists of all even integers and forms a group under addition.

  - Closure: The sum of any two even integers is still even.

  - Associativity: Clearly satisfied.

  - Identity element: $0$ is the identity element for integer addition, and it is also the identity element for the even integer group.

  - Inverses: The inverse of each even integer is its additive inverse, which is also an even integer.

The subgroup of even integers satisfies the requirements of closure, associativity, identity element, and inverses, thus it is a subgroup of the integer additive group.

### 1.2 Subgroups of the Multiplicative Group of Positive Integers Modulo 5

Consider the multiplicative group of positive integers modulo 5, denoted $(\mathbb{Z}_5^* , \times)$, where $\mathbb{Z}_5^* = \{1,2,3,4\}$. Its subgroups include:

- **Unit Element Subgroup $\langle 1 \rangle$:** It consists of the unit element $1$. A subgroup containing only the unit element is also called a trivial subgroup.

  - Closure: $1 \times 1 = 1$, which still belongs to the unit element subgroup.

  - Associativity: Clearly satisfied.

  - Identity element: $1$ is the identity element for integer multiplication, and it is also the identity element for the unit element subgroup.

  - Inverses: The inverse of $1$ is $1$, which is also in the unit element subgroup.

- **Subgroup formed by the set $\{1, 4\}$:**

  - Closure: According to the multiplication table for elements in the set $\{1, 4\}$, the result of multiplication still belongs to $\{1, 4\}$.

    | ×   | 1   | 4   |
    | --- | --- | --- |
    | 1   | 1   | 4   |
    | 4   | 4   | 1   |

  - Associativity: Clearly satisfied.

  - Identity element: $1$ is the identity element of the group.

  - Inverses: Modulo 5, the inverse of $1$ is $1$, and the inverse of $4$ is $4$.

- **Subgroup formed by the set $\{1, 2, 3, 4\}$: This subgroup is equal to the multiplicative group of positive integers modulo 5 itself.**

These three subgroups satisfy the requirements of closure, associativity, identity element, and inverses, so they are all subgroups of the multiplicative group of positive integers modulo 5. Now, can the set $\{1,2,3\}$ form a subgroup? Please try to prove it.

### 1.3 Subgroups of the Integer Modulo 6 Additive Group

Consider the integer modulo 6 additive group $(\mathbb{Z}_6,+)$, where $\mathbb{Z}_6 = \{0,1,2,3,4,5\}$. Its subgroups include:

- **Unit Element Subgroup $\langle 0 \rangle$:** It consists of the unit element $0$.

- **Subgroup formed by the set $\{0, 3\}$:**

  - Closure: When any two elements in the set $\{0, 3\}$ are added, the result still belongs to $\{0, 3\}$.

  - Associativity: Clearly satisfied.

  - Identity element: $0$ is the identity element of the group.

  - Inverses: Modulo 6, the additive inverse of $0$ is $0$, and the additive inverse of $3$ is $3$.

- **Subgroup formed by the set $\{0, 2 ,4\}$:**

  - Closure: When any two elements in the set $\{0, 2 ,4\}$ are added, the result still belongs to $\{0, 2 ,4\}$.

  - Associativity: Clearly satisfied.

  - Identity element: $0$ is the identity element of the group.

  - Inverses: Modulo 6, the additive inverse of $0$ is $0$, and $2$ and $4$ are each other's additive inverses.

- **Subgroup formed by the set $\mathbb{Z}_6=\{0,1,2,3,4,5\}$: This subgroup is equal to the original group itself.**

These four subgroups satisfy the requirements of closure, associativity, identity element, and inverses, so they are all subgroups of the integer modulo 6 additive group. Now, can the set $\{0,1,3,5\}$ form a subgroup? Please try to prove it.

## 2. Properties of Subgroups

With the definition of subgroups, we can derive some important properties:

- **The identity element of the original group is also the identity element of the subgroup:** $H \leq G \Longleftrightarrow e_H = e_G$, where $e_H, e_G$ are the identity elements of $H, G$ respectively.

<details><summary>Click to expand the proof 👀</summary>

Let $H$ be a subgroup of group $G$, $e_G$ be the identity element of $G$, and $e_H$ be the identity element of $H$. For any element $h$ in $H$, by the definition of a group:

$h 🐔 e_H = h$

Since $H \leq G$, $e_H$ is also an element of $G$. Thus, $h 🐔 e_H$ is also an operation in $G$. Considering the identity element $e_G$ of $G$, we have:

$h 🐔 e_H = h = h 🐔 e_G$

Canceling $h$ from both sides of the equation, we get $e_H=e_G$, so the identity element of the original group is also the identity element of the subgroup.

</details>

- **If an element $a$ is in the subgroup, then its inverse $a^{-1}$ in the original group is also in the subgroup:**

<details><summary>Click to expand the proof 👀</summary>

Let $H$ be a subgroup of group $G$, $a$ be an element in $H$, $a_G'$ be the inverse of $a$ in $G$, and $a_H'$ be the inverse of $a$ in $H$. We have:

$a 🐔 a_H' = e$

$a 🐔 a_G' = e$

So, $a 🐔 a_H' = a 🐔 a_G'$, and we can cancel $a$ from both sides of the equation to get $a_H' = a_G'$.

</details>

- **The intersection of subgroups is still a subgroup:** If $H_1 \leq G$ and $H_2 \leq G$, then $H_1 \cap H_2 \leq G$. We can use this method to construct subgroups.

> Note that $H_1 \cup H_2$ may not necessarily be a subgroup of $G$, for example, if $2$ and $3$ belong to the union of $2\mathbb{Z}$ (multiples of 2) and $3\mathbb{Z}$ (multiples of 3), their sum $5$ does not belong to the union.

<details><summary>Click to expand the proof 👀</summary>

Consider a group $(G,\cdot)$ and its subgroups $H_1$ and $H_2$:

1. **Closure:** Let $a, b \in H_1 \cap H_2$. Then $a, b \in H_1$ and $a, b \in H_2$. Since $H_1$ is a subgroup of $G$, $a \cdot b \in H_1$. Similarly, since $H_2$ is a subgroup of $G$, $a \cdot b \in H_2$. Therefore, $a \cdot b \in H_1 \cap H_2$. Thus, $H_1 \cap H_2$ is closed under the operation of the group $G$.

2. **Associativity:** Clearly satisfied.

3. **Identity element:** Since $H_1$ and $H_2$ are subgroups of $G$, they both contain the identity element $e$ of $G$. Therefore, their intersection also contains the identity element of $G$, i.e., $e \in H_1 \cap H_2$.

4. **Inverse elements:** Let $a \in H_1 \cap H_2$. Since $H_1$ and $H_2$ are subgroups of $G$, they contain the inverse elements of $a$ in $G$. Therefore, their intersection also contains the inverse element of $a$ in $G$, i.e., $a^{-1} \in H_1 \cap H_2$.

From the properties of closure, associativity, identity element, and inverse elements, we conclude that $H_1 \cap H_2$ satisfies the definition of a subgroup.

</details>

## 3. Testing for Subgroups

In the first section, we used the group axioms to test for subgroups: first, check if it's a subset, then check for closure, associativity, identity element, and inverses. If all are satisfied, it's a subgroup. This method can be cumbersome, so in this section, we introduce a more convenient method for testing subgroups.

Given a group $(G, 🐔)$, let $H$ be a subset of $G$. Then, $H$ is a subgroup of $G$ if and only if for any $a, b \in H$, we have $a 🐔 b^{-1} \in H$.

<details><summary>Click to expand the proof 👀</summary>

Here we prove both sufficiency and necessity.

**Sufficiency ( $\Rightarrow$):**

Assume $H$ is a subgroup of $G$. We need to prove that for any $a, b \in H$, we have $a 🐔 b^{-1} \in H$.

Since $H$ is a subgroup of $G$, it satisfies:

1. **Closure:** For any $a, b \in H$, we have $a 🐔 b \in H$
2. **Existence of inverses:** For any $a \in H$, we have $a^{-1} \in H$

Let $c = b^{-1}$, then $c \in H$. Therefore, by closure, $a 🐔 c \in H$, which means $a 🐔 b^{-1} \in H$.

**Necessity ($\Leftarrow$):**

Conversely, assuming $H \subseteq G$, for any $a, b \in H$, we have $a 🐔 b^{-1} \in H$. We need to prove that $H$ is a subgroup of $G$.

1. **Closure:** For any $a, b \in H$, we have $b^{-1} \in H$. According to the assumption, we have $a 🐔 (b^{-1})^{-1} \in H$, and $(b^{-1})^{-1} = b$, so we have $a 🐔 b \in H$. Closure is proven.
2. **Associativity:** For any $a, b, c \in H$, we have $a, b, c \in G$, therefore $(a 🐔 b) 🐔 c =a 🐔 (b 🐔 c)$.
3. **Identity Element:** Let $b = a$, then we have $a 🐔 a^{-1} \in H$, and $a 🐔 a^{-1} = e$ is the identity element, so the identity element exists.
4. **Inverse Element:** Let $a = e$, for any $b \in H$, we have $e 🐔 b^{-1} \in H$, which means $b^{-1} \in H$, so the inverse element exists.

In conclusion, $H$ satisfies the 4 properties of group axioms and $H \subseteq G$, therefore $H$ is a subgroup of $G$.

</details>

We consider the example of the multiplicative group of positive integers modulo $5$, which corresponds to the set of units modulo $5$ denoted as $\mathbb{Z}_5^* = \{1,2,3,4\}$, with the subset $\mathbb{H} = \{1,4\}$, and the operator being the modulo multiplication. The following table shows the result of $a \cdot b^{-1}$ for any $a, b \in \mathbb{H}$, and it can be observed that they all belong to $\mathbb{H}$, thus satisfying closure.

| $a$ | $b$ | $b^{-1}$ | $a \cdot b^{-1}$ |
| --- | --- | -------- | ---------------- |
| 1   | 1   | 1        | 1                |
| 1   | 4   | 4        | 4                |
| 4   | 1   | 1        | 4                |
| 4   | 4   | 4        | 1                |

## 4. Summary

Subgroup is a key concept in group theory. By constructing subgroups, we can better understand the structure and properties of the parent group. In the following studies, subgroups will provide a solid foundation for us to delve into various properties of groups.
