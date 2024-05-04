---
title: Lecture 13. Cosets and Lagrange's Theorem
tags:
  - zk
  - basic
  - abstract algebra
  - group theory
  - coset
---

# WTF zk Tutorial Lesson 13: Cosets and Lagrange's Theorem

In group theory, cosets are an important concept for describing translations or transformations within a group. Understanding cosets helps us study the symmetry and structure of groups. This tutorial will introduce the definition and properties of cosets, as well as Lagrange's Theorem.

## 1. Cosets

In group theory, a subset of a group together with the operation on its elements forms a set called a coset. Cosets are not groups themselves, but they allow us to decompose a group into disjoint sets of equal size, serving as a fundamental tool for studying groups and forming the basis of Lagrange's Theorem.

**Definition of Cosets:** Given a group $(G, 🐔)$ and one of its subgroups $(H, 🐔)$, for an element $a$ in $G$, we define the operation of cosets of $H$ with respect to $a$ as 🦆 operation i.e. $a 🦆 H = \{a 🐔 h \mid h \in H\}$. This represents the set obtained by operating $🐔$ between $a$ and each element of $H$, and the resulting set $a 🦆 H$ is called coset. For simplicity, we omit the $🦆$ symbol and denote cosets as $aH$.

> **Note:** The operation $🐔$ is an operation between **elements** of the group, and the result is an element, while the operation $🦆$ is an operation between an **element and a subgroup** of the group. Its effect is to operate $🐔$ between the element and each element of the subgroup, and the result is a set. You can see the operation $🦆$ as 🐔 operation between elements and sets.

Similarly, we can define another coset $Ha = \{h 🐔 a \mid h \in H\}$.

Since groups do not necessarily satisfy the commutative law, the above two cosets may not be equal. However, since most groups used in cryptography satisfy the commutative law, we do not distinguish between the above two cosets in this tutorial and simply refer to them as cosets.

For example, in the additive group of integers, the subgroup $3\mathbb{Z}=\{...,-6,-3,0,3,6,...\}$ and the element $1$ yield the coset $1+3\mathbb{Z} =\{...,-5,-2,1,4,7,...\}$. Similarly, using the element $2$ yields the coset $2+3\mathbb{Z} =\{...,-4,-1,2,5,8,...\}$, and so on. You can keep on trying, but you will find that the resulting cosets will repeat and lead to a cycle.

Another example is in the additive group $Z_6$. The subgroup $Z_6 = \{0,1,2,3,4,5\}$ and the element $1$ yield the coset $\{0,2,4\}$ (the same coset is obtained when using the elements $2$ or $4$). Similarly, using the element $1$ yields the coset $\{1,3,5\}$ (the same coset is obtained when using the elements $3$ or $5$).

## 2. Properties of Cosets

**1. Cosets Partition the Entire Group, and Each Element Belongs to Some Coset:** If $H$ is a subgroup of $G$ and $a \in G$, then $a \in aH$. The proof is straightforward, as the subgroup $H$ must contain the identity element $e$. Thus, $aH$ must contain $ae = a$, indicating that $a$ belongs to this coset.

**2. Cosets Produced by Subgroup and Subgroup Elements Operation Equal the Subgroup Itself:** If $H$ is a subgroup of $G$ and $a \in G$, then $aH = H$ if and only if $a \in H$. This also means that the subgroup $H$ itself is a coset.

<details><summary>Click to expand the proof</summary>

**Sufficiency:** Since $a \in H$, according to the closure property of groups, all elements in $aH$ belong to $H$, so $aH \subseteq H$. On the other hand, for any $b \in H$, according to the subgroup property, there exists $a^{-1}b \in H$. Multiplying both sides by $a$, we have $aa^{-1}b \in aH$, which implies $b \in aH$. Thus, for any $b \in H$, we have $b \in aH$, and therefore $H \subseteq aH$. Hence, $H = aH$.

**Necessity:** Since $aH = H$, $a$ is in $H$. Since the identity element $e$ is also in subgroup $H$, there exists $b \in H$ such that $ab = e$, implying $a = b^{-1}$. According to the existence of inverse elements in groups, $a = b^{-1} \in H$. Therefore, $a \in H$. Hence proved.

</details>

**3. Equality of Cosets is Equivalent to the Inclusion of the Inverse Element in the Subgroup:** If $H$ is a subgroup of $G$ and $a, b \in G$, then cosets $aH = bH$ if and only if $a^{-1}b \in H$.

<details><summary>Click to expand the proof</summary>

**Sufficiency:** Since $aH = bH$, and $b \in bH$, there exists $h \in H$ such that $ah = b$. Since $a, b \in G$, the inverse element of $a$ exists. Multiplying both sides by $a^{-1}$, we get $h = a^{-1}b$, so $a^{-1}b \in H$.

**Necessity:** Given $a^{-1}b \in H$, there exists $h \in H$ such that $a^{-1}b = h$. Multiplying both sides by $a$, we obtain $b = ah$. Multiplying both sides by $H$, we have $bH = ahH$. Since $h \in H$, we have $hH = H$, so $bH = aH$.

</details>

**4. Disjoint Property of Cosets: Two Cosets of a Subgroup Do Not Intersect i.e. Their Intersection is Empty:** If $H$ is a subgroup of $G$ and $a, b \in G$, if $aH \neq bH$, then $aH \cap bH = \varnothing$.

<details><summary>Click to expand the proof</summary>

We prove by contradiction. Suppose $aH \neq bH$, but $aH$ and $bH$ have a common element $h$. Then there exist $h_1, h_2 \in H$ such that $h = ah_1 = bh_2$, implying $ah_1 = bh_2$. Multiplying both sides by $a^{-1}$, we get $h_1 = a^{-1}b$, so $a^{-1}b \in H$. A contradiction arises as we initially assumed $aH \neq bH$, yet $aH$ and $bH$ have a common element. Thus, if $aH \neq bH$, then $aH$ and $bH$ have no common elements i.e. $aH \cap bH = \varnothing$.

</details>

**5. One-to-One Correspondence Between Subgroup Elements and Cosets, with an Equal Number of Elements (Equinumerosity):** $|H|=|aH|$.

<details><summary>Click to expand the proof</summary>

For subgroup $H$ and coset $aH$, we want to prove that they are equinumerous, meaning there exists a bijection $f: H \to aH$.

Consider the mapping $f: H \to bH$, where $f(h) = ah$ defined on $H$. We need to verify that $f$ is a bijection i.e. it is a one-to-one correspondence.

**1. Injectivity:** For any $x_1, x_2 \in H$, if $f(x_1) = f(x_2)$, then $x_1 = x_2$.

Suppose $f(x_1) = f(x_2)$, which implies $ax_1 = ax_2$. Since $a$ is a group element with an inverse, multiplying both sides by the inverse yields $x_1 = x_2$. Thus, proved.

**2. Surjectivity:** For any $y \in aH$, there exists $x \in H$ such that $f(x) = y$.

Since $y \in aH$, there exists $h \in H$ such that $y = ah$. Let $x = a^{-1} y$, then $f(x) = a a^{-1} y = y$. Therefore, $f$ is surjective.

From injectivity and surjectivity, $f$ is a bijection. Hence, $H$ and $aH$ are equinumerous, meaning their elements correspond one-to-one, and they have the same number of elements.

</details>

Using the subgroup $H=\{1,4\}$ of the multiplicative group $Z^*_5$ as an example, let's verify these properties. According to the previous calculations, we know its cosets are $1H = 4H = \{1,4\}$ and $2H = 3H = \{2,3\}$.

- **Property 1:** Elements 1 and 4 belong to the coset $\{1,4\}$, and elements 2 and 3 belong to the coset $\{2,3\}$. The cosets partition the entire group, and each element belongs to some coset.

- **Property 2:** The cosets produced by elements 1 and 4 of the subgroup equal the subgroup itself, $H=\{1,4\}$.

- **Property 3:** $1H = 4H = \{1,4\}$, and $1^{-1} \times 4 = 4 \in H$. Also, $2H = 3H = \{2,3\}$, and $2^{-1} \times 3 = 4 \in H$

- **Property 4:** Two cosets of a subgroup either coincide or disjoint.

- **Property 5:** The number of elements in the subgroup and the cosets is the same, which is 2.

## 3. Congruence Relations

In number theory, congruence relations are a fundamental and important concept. Now, we'll discuss how to extend congruence relations to group theory using the concept of cosets.

### 3.1 Definition

In a group $G$, if elements $a$ and $b$ belong to the same coset constructed by a subset $H$, we say $a$ and $b$ are congruent modulo $H$, denoted as $a \equiv b \pmod{H}$.

### 3.2 Necessary and Sufficient Conditions for Congruence

Next, we introduce the necessary and sufficient conditions for $a \equiv b \pmod{H}$.

**1. Existence of $h \in H$ such that $a=bh$, or equivalently, $b^{-1}a = h$.**

<details><summary>Click to expand proof 🧐</summary>

**Sufficiency**

Given $a \equiv b \pmod{H}$, there exists $h \in H$ such that $b^{-1}a = h$. Multiplying both sides by $b$ yields $a = bh$.

**Necessity**

If there exists $h \in H$ such that $a=bh$, multiplying both sides by $b^{-1}$ gives $b^{-1}a = h$. Thus, $aH = bH$. Since $a \in aH$ and $b \in bH$, they belong to the same coset.

</details>

**2. $b \in aH$**

<details><summary>Click to expand proof 🧐</summary>

**Sufficiency**

Referring to the previous proof, we have $aH = bH$. Since $b \in bH$, it follows that $b \in aH$.

**Necessity**

Given $b \in aH$, and since $b \in bH$, it implies that the intersection of $aH$ and $bH$ is non-empty, hence $aH = bH$. Since $a \in aH$ and $b \in bH$, they belong to the same coset.

</details>

**3. $bH = aH$**

<details><summary>Click to expand proof 🧐</summary>

The previous section has shown the exact same proof.

</details>

### 3.3 Equivalence Relation

Congruence relations remain an equivalence relation in group theory, preserving some important properties:

- **Reflexivity:** For any $a \in G$, we have $a \equiv a \pmod{H}$.
- **Symmetry:** If $a \equiv b \pmod{H}$, then $b \equiv a \pmod{H}$.
- **Transitivity:** If $a \equiv b \pmod{H}$ and $b \equiv c \pmod{H}$, then $a \equiv c \pmod{H}$.

Thus, cosets act similar to residue classes in modular arithmetic, dividing the elements of a group into different equivalence classes.

As an example, consider the subgroup $H=\{1,4\}$ of the multiplicative group $Z^*_5$. Its cosets divide the group into two classes: $\{1,4\}$ and $\{2,3\}$.

Another example is the subgroup $3\mathbb{Z}=\{..., -6,-3,0,3,6,...\}$ of the integer addition group. Its cosets divide the group into:

$$
0+3\mathbb{Z} =\{..., -6,-3,0,3,6,...\}
$$

$$
1+3\mathbb{Z} =\{..., -5,-2,1,4,7,...\}
$$

$$
2+3\mathbb{Z} =\{..., -4,-1,2,5,8,...\}
$$

These three cosets correspond exactly to residue classes modulo 3, dividing all integers into different equivalence classes based on the remainder after division by 3.

## 4. Lagrange's Theorem

Lagrange's Theorem is a fundamental theorem in group theory, stating that if $G$ is a finite group and $H$ is a subgroup of $G$, then the order (number of elements) of $H$ divides the order of $G$ i.e. $|G| = |H| \cdot |G:H|$, where $G:H$ is a positive integer called the index of $H$ in $G$.

<details><summary>Click to expand proof 🧐</summary>

$G$ is a finite group, and the cosets constructed by the subgroup $H$ are pairwise disjoint, partitioning the entire group.

We can construct a set of $n$ disjoint cosets $g_1H, g_2H, ..., g_nH$ that partition the entire group. Then $|G| = |g_1H| + |g_2H| + ... + |g_nH|$. Since each coset has the same order as the subgroup, we have $|G| = |H| + |H| + ... + |H| = n|H|$. We denote the positive integer $n$ as $G:H$, called the index of $H$ in $G$.

</details>

Lagrange's Theorem helps us narrow down the possibilities for subgroups since the order of a subgroup must divide the order of the whole group. Subgroups whose orders do not divide the order of the whole group are not valid. For example, in the multiplicative group $Z^*_5$, whose order is 4, the subset $\{1,2,3\}$ is not a subgroup since its order is 3, which does not divide 4. However, the subgroup $\{1,4\}$ has an order of 2, which divides 4 and thus satisfies the condition.

It's important to note that the inverse of Lagrange's Theorem doesn't necessarily hold:

1. Even if the order of $H$ divides the order of $G$, $H$ may not be a subgroup; its subgroup properties still need to be verified.
2. Given a divisor $d$ of $|G|$, there may not exist a subgroup $H$ such that $|H| = d$.

## 5. Revisiting Fermat's Little Theorem

Previously, we learned Fermat's Little Theorem in number theory. Now, let's revisit it:

If $p$ is a prime number, then for any integer $a$,

$$
a^{p-1} \equiv 1 \pmod{p}
$$

Now, let's use equinumerosity of cosets to prove Fermat's Little Theorem. Since $p$ is a prime, $\mathbb{Z}_p^*=\{1,2,...,p-1\}$ with multiplication forms a group modulo $p$.

For any integer $a$, $a \mod{p} \in \mathbb{Z}^* _p$. We construct cosets by operating it with $\mathbb{Z}^* _p$, obtaining $a\mathbb{Z}^* _p = \{a,2a,...,(p-1)a\}$. Since ${a \mod{p}} \in \mathbb{Z}^* _p$, it follows that $a\mathbb{Z}^* _p = \mathbb{Z}^* _p$.

Multiplying all elements in these cosets, we get:

$$
a \cdot 2a \cdot ... \cdot (p-1)a \equiv 1 \cdot 2 \cdot ... \cdot (p-1) \pmod{p}
$$

This simplifies to:

$$
a^{p-1} (p-1)! \equiv (p-1)! \pmod{p}
$$

Cancelling $(p-1)!$ from both sides, we get Fermat's Little Theorem:

$$
a^{p-1} \equiv 1 \pmod{p}
$$

## 6. Summary

In this lesson, we introduced cosets and Lagrange's Theorem. Cosets, generated by operating a subset with elements, are not groups themselves but partition the group into disjoint sets of equal size. They are fundamental tools in studying groups and should be well understood.

[^1]: "Cardinality" and "order" are related but slightly different concepts in group theory: 1. **Cardinality:** The "cardinality" refers to the cardinality of the set of elements in a group i.e. the number of elements in the group. It represents the size of the group. Cardinality is typically used to describe the number of elements in a group without involving the structure or properties of the group. For example, if a group G has 5 elements, we can say the cardinality of G is 5. 2. **Order:** The "order" is typically used to describe the number of elements in a subgroup or of an element that has some specific property. The order can represent the size of a subgroup. For example, if a subgroup H has 3 elements, we can say the order of H is 3. It can also represent the order of an element, especially in cyclic groups, where the order of an element indicates the minimum number of times it needs to be multiplied to generate the identity element. In summary, cardinality is typically used to describe the size of the entire group, while order can be used to describe the size of subgroups or elements and is often used in specific contexts. Both are important terms in describing groups and their constituents.
