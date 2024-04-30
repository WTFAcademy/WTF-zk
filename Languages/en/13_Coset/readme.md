- **Property 4:** Two cosets of a subgroup H are either the same or disjoint.

- **Property 5:** The number of elements in a subgroup and its cosets is 2.

## 3. Congruence Relation

In number theory, congruence relation is a fundamental and important concept. Now we will extend the congruence relation to group theory using the concept of cosets.

### 3.1 Definition

In a group G, if elements a and b belong to the same coset constructed by a subset H, we say that a and b are congruent modulo H, denoted as a ≡ b (mod H).

### 3.2 Necessary and Sufficient Condition for Congruence

Next, we introduce the necessary and sufficient condition for a ≡ b (mod H).

**1. There exists an h ∈ H such that a=bh holds, which can also be written as b⁻¹a = h**

<details><summary>Click to expand proof👀</summary>

**Sufficiency**

According to a ≡ b (mod H), there exists h ∈ H such that b⁻¹a = h. Multiplying both sides by b, we get a = bh. Proof completed.

**Necessity**

There exists h ∈ H such that a=bh holds. Multiplying both sides by b⁻¹, we have b⁻¹a = h, hence aH = bH. Moreover, since a ∈ aH, b ∈ bH, they belong to the same coset. Proof completed.

</details>

**2. b ∈ aH**

<details><summary>Click to expand proof👀</summary>

**Sufficiency**

According to the previous proof, we have aH = bH and b ∈ bH, so b ∈ aH.

**Necessity**

According to b ∈ aH, since b ∈ bH, the intersection of aH and bH is not empty, so aH = bH. Moreover, since a ∈ aH, b ∈ bH, they belong to the same coset. Proof completed.

</details>

**3. bH = aH**

<details><summary>Click to expand proof👀</summary>

The necessary and sufficient condition for equal cosets has been proven in the previous section, and it is the same as here.

</details>

### 3.3 Equivalence Relation

Congruence relation remains an equivalence relation in group theory and maintains some important properties:

- **Reflexivity:** For any a ∈ G, a ≡ a (mod H) holds.
- **Symmetry:** If a ≡ b (mod H), then b ≡ a (mod H).
- **Transitivity:** If a ≡ b (mod H) and b ≡ c (mod H), then a ≡ c (mod H).

Therefore, cosets are similar to residue classes in modular arithmetic and can divide the elements in a group into different equivalence classes.

Let's take the example of the subgroup H={1,4} of the multiplicative group Z⁎₅. Its cosets divide the group into two classes: {1,4} and {2,3}.

Let's also take the example of the subgroup 3Z={...,-6,-3,0,3,6,...} of the additive group of integers. Its cosets divide the group into:

0+3Z = {...,-6,-3,0,3,6,...}

1+3Z = {...,-5,-2,1,4,7,...}

2+3Z = {...,-4,-1,2,5,8,...}

These three cosets correspond exactly to the residue classes modulo 3, dividing all integers into different equivalence classes based on the remainder after division by 3.

## 4. Lagrange's Theorem

Lagrange's theorem is a fundamental theorem in group theory. It states that if G is a finite group and H is a subgroup of G, then the order (number of elements) of H must divide the order of G[^1], i.e., |G| = |H| * |G:H|, where G:H is a positive integer called the index of H in G.

<details><summary>Click to expand proof👀</summary>

G is a finite group, and the cosets constructed by the subgroup H are disjoint and partition the entire group.

We can construct a set of n disjoint cosets g₁H, g₂H, ..., gₙH that partition the entire group. Then we have |G| = |g₁H| + |g₂H| + ... + |gₙH|. Since the order of each coset is equal to the number of subgroups, we have |G| = |H| + |H| + ... + |H| = n|H|. We denote the positive integer n as G:H, which is called the index of H in G. Proof completed.

</details>

Lagrange's theorem can help us narrow down the range of subgroups because the order of a subgroup must divide the order of the parent group. Those that cannot divide are definitely not subgroups. Taking the multiplicative group Z⁎₅ as an example, its order is 4, so the subset {1,2,3} is definitely not a subgroup because its order is 3, which cannot divide 4. On the other hand, the subgroup {1,4} has an order of 2, which can divide 4 and meets the condition.

It is important to note that the converse of Lagrange's theorem does not necessarily hold:

1. Even if the order of H divides the order of G, H is not necessarily a subgroup, and we still need to verify the properties of a subgroup.

2. If d is a divisor of |G|, it does not necessarily imply the existence of a subgroup H with |H|=d.

## 5. Review of Fermat's Little Theorem

Previously, we learned Fermat's Little Theorem in the foundation of number theory, and now let's review it:

If p is a prime number, then for any integer a, we have a^(p-1) ≡ 1 (mod p).

Now, using the equinumerosity of cosets, we prove Fermat's Little Theorem. Since p is a prime number, Zₚ⁎ = {1,2,...,p-1} together with multiplication forms the multiplicative group of integers modulo p.

For any integer a, we have a mod p ∈ Zₚ⁎. We use it to operate with Zₚ⁎ and generate the coset aZₚ⁎ = {a,2a,...,(p-1)a}. Since {a mod p} ∈ Zₚ⁎, we have aZₚ⁎ = Zₚ⁎.

If we multiply all the elements in these cosets, we get:

a ⋅ 2a ⋅ ... ⋅ (p-1)a ≡ 1 ⋅ 2 ⋅ ... ⋅ (p-1) (mod p)

Simplifying, we get:

a^(p-1)(p-1)! ≡ (p-1)! (mod p)

Canceling (p-1)!, we obtain Fermat's Little Theorem:

a^(p-1) ≡ 1 (mod p)

## 6. Summary

In this lesson, we introduced cosets and Lagrange's theorem. Cosets are sets generated by subsets and elements of a group, they are not groups themselves but can decompose a group into disjoint sets of equal cardinality. They are essential tools in the study of groups, and we should grasp them well.

[^1]: "Cardinality" and "order" are related but slightly different concepts in group theory: 
1. Cardinality: "Cardinality" refers to the cardinality of the set of elements in a group, i.e., the number of elements in the group. It represents the size of the group. Cardinality is often used to describe the number of elements in a group without considering the structure or properties of the group. For example, if a group G has 5 elements, we can say that the cardinality of G is 5. 
2. Order: "Order" is often used to describe the number of certain properties of a subgroup or an element. Order can represent the size of a subgroup. For example, if a subgroup H has 3 elements, we can say that the order of H is 3. It can also be used to represent the order of an element, particularly in cyclic groups, where the order of an element represents the minimum number of times the element needs to be multiplied to generate the identity element. In summary, cardinality is often used to describe the size of the entire group, while order can be used to describe the size of subgroups or elements, typically in specific contexts. Both concepts are important terms used to describe groups and their components in group theory.
# WTF zk Tutorial 13: Cosets and Lagrange's Theorem

In group theory, cosets are an important concept for describing translations or transformations in a group. Understanding cosets helps us study the symmetry and structure of a group. This tutorial will introduce the definition and properties of cosets, as well as Lagrange's Theorem.

## 1. Cosets

In group theory, a subset of a group together with the operation of the elements forms a set called a coset. Cosets are not groups themselves, but they allow us to partition a group into disjoint, equally-sized subsets. They are a fundamental tool for studying groups and form the basis of Lagrange's Theorem.

**Definition of Cosets**: Given a group $(G, 🐔)$ and its subgroup $(H, 🐔)$, for an element $a$ in $G$, we define the left coset of $H$ with respect to $a$ as $a🦆H = \{a🐔h \mid h \in H\}$. This means that each element $h$ in $H$ is operated with $a$ using the operation 🐔, and the resulting new set $a🦆H$ is called the left coset. To simplify, we omit the 🦆 symbol and denote the left coset as $aH$.

> **Note**: The operation 🐔 is the operation between **elements** in a group, and the result is an element. The operation 🦆 is the operation between an element and a **subgroup** in a group, and it results in a set. You can think of the operation 🦆 as an operation between elements and sets.

Similarly, we can define the right coset $Ha = \{h🐔a \mid h \in H\}$.

Since groups do not necessarily satisfy the commutative law, the left and right cosets may not be equal. However, most groups used in cryptography satisfy the commutative law, so in this tutorial, we consider them together and refer to them as cosets.

For example, let's consider the subgroup $3\mathbb{Z}=\{...,-6,-3,0,3,6,...\}$ of the additive group of integers and the element 1 for addition. The resulting coset is $1+3\mathbb{Z} =\{...,-5,-2,1,4,7,...\}$. If we use the element 2, the coset is $2+3\mathbb{Z} =\{...,-4,-1,2,5,8,...\}$. If we use the element 3, the coset is $3+3\mathbb{Z} =\{...,-6,-3,0,3,6,...\}$, which is the same as the subgroup $3\mathbb{Z}$ itself, and is also equal to the coset obtained by adding 0 to $3\mathbb{Z}$. If we use the element 4, the coset is $4+3\mathbb{Z} =\{...,-5,-2,1,4,7,...\}$, which is equal to the coset $1+3\mathbb{Z}$. You can continue trying, but the resulting cosets will repeat and form a loop.

Let's consider another example, the subgroup $\{0,2,4\}$ of the additive group $Z_6$, and the element 0 for addition. The resulting coset is $\{0,2,4\}$ (the same coset is obtained by adding 2 or 4 to it). If we use the element 1, the coset is $\{1,3,5\}$ (the same coset is obtained by adding 3 or 5 to it).

For the last example, let's consider the multiplicative group $Z^*_5 = \{1,2,3,4\}$ with the subgroup $H = \{1,4\}$ and the element 1 for multiplication. The resulting coset is $\{1,4\}$. If we perform the operation with 2, we get $\{2, 3\}$. If we use 3, we get $\{2, 3\}$. If we use 4, we get $\{1,4\}$.

## 2. Properties of Cosets

**1. Cosets partition the entire group, and each element belongs to a coset**: If $H$ is a subgroup of $G$ and $a \in G$, then $a \in aH$. The proof is simple because the subgroup $H$ contains the identity element $e$, so $aH$ must also contain $ae = a$, and therefore $a$ belongs to this coset.

**2. Cosets obtained from the subgroup and the elements of the subgroup are equal to the subgroup itself**: If $H$ is a subgroup of $G$ and $a \in G$, then $aH = H$ if and only if $a \in H$. This also means that the subgroup $H$ is also a coset itself.

<details><summary>Click to expand proof👀</summary>

**Sufficiency**: Since $a \in H$, according to the closure property of the group, all the elements in $aH$ belong to $H$, so $aH \subseteq H$. On the other hand, for any $b \in H$, according to the properties of subgroups, there exists $a^{-1}b \in H$. Multiplying both sides by $a$, we have $aa^{-1}b \in aH$, that is, $b \in aH$. In other words, for any $b \in H$, $b \in aH$, so $H \subseteq aH$. Therefore, $H = aH$, and the sufficiency is proved.

**Necessity**: Since $a \in G$, $aH = H$ holds. Because the identity element $e$ is also in subgroup $H$, there exists $b \in H$ such that $ab = e$, so $a = b^{-1}$. According to the existence of inverse elements in a group, $a = b^{-1} \in H$, that is, $a \in H$. The necessity is proved.

</details>

**3. Necessary and Sufficient Condition for Cosets to be Equal**: If $H$ is a subgroup of $G$ and $a, b \in G$, then $aH = bH$ if and only if $a^{-1}b \in H$.

<details><summary>Click to expand proof👀</summary>

**Sufficiency**: Since $aH = bH$ and $b \in bH$, there exists $h \in H$ such that $ah = b$. Since $a, b \in G$, the inverse element of $a$ exists. Multiplying both sides by $a^{-1}$, we have $h = a^{-1}b$, so $a^{-1}b \in H$. The sufficiency is proved.

**Necessity**: Given $a^{-1}b \in H$, there exists $h \in H$ such that $a^{-1}b = h$. Multiplying both sides by $a$, we get $b = ah$. Multiplying both sides by $H$, we have $bH = ahH$. Since $h \in H$, we have $hH = H$, so $bH = aH$. The necessity is proved.

</details>

**4. Disjoint Property of Cosets: Two cosets of a subgroup either are equal or have empty intersection**: If $H$ is a subgroup of $G$ and $a, b \in G$, if $aH \neq bH$, then $aH \cap bH = \varnothing$.

<details><summary>Click to expand proof👀</summary>

We use proof by contradiction. Let's assume that $aH \neq bH$ but $aH$ and $bH$ have a common element $h$. Then, we have $h_1, h_2 \in H$ such that $h = ah_1 = bh_2$, which implies $ah_1 = bh_2$. Multiplying both sides of the equation by $a^{-1}$, we have $h = a^{-1}bh_2$, and hence $ahH = bHh_2H$. Since $h_1, h_2 \in H$, we have $h_1H = h_2H = H$, so $aH = bH$, which contradicts our assumption that $aH \neq bH$. Therefore, if $aH \neq bH$, then $aH$ and $bH$ do not have any common elements, i.e., $aH \cap bH = \varnothing$. The proof is complete.

</details>

**5. One-to-One Correspondence between Cosets of a Subgroup and Elements of the Subgroup, and They Have the Same Cardinality [^1]**: $|H|=|aH|$.

<details><summary>Click to expand proof👀</summary>

For a subgroup $H$ and a coset $aH$, we want to prove that they have the same cardinality, i.e., there exists a bijection $f: H \to aH$.

Consider the mapping $f: H \to bH$ defined on $H$, where $f(h) = ah$. We need to verify that $f$ is a bijection, i.e., it is a one-to-one correspondence.

1. **Injection**: For any $x_1, x_2 \in H$, if $f(x_1) = f(x_2)$, then $x_1 = x_2$.

   Suppose $f(x_1) = f(x_2)$, that is, $ax_1 = a x_2$. Since $a$ is an element in the group, it has an inverse. Multiplying both sides by the inverse of $a$, we get $x_1 = x_2$. The injection is proved.

2. **Surjection**: For any $y \in aH$, there exists $x \in H$ such that $f(x) = y$.

   Since $y \in aH$, there exists $h \in H$ such that $y = ah$. Let $x = a^{-1} y$, then $f(x) = a a^{-1} y = y$. Therefore, $f$ is a surjection.

Based on injection and surjection, we can conclude that $f$ is a bijection, and thus $H$ and $aH$ have the same cardinality, and their elements correspond to each other one-to-one.

</details>

Let's use the subgroup $H=\{1,4\}$ of the multiplicative group $Z^*_5$ as an example to check these properties. As we calculated before, we know the cosets are $1H = 4H = \{1,4\}$ and $2H = 3H = \{2,3\}$.

- **Property 1**: Elements 1 and 4 belong to the coset $\{1,4\}$, and elements 2 and 3 belong to the coset $\{2,3\}$. The cosets partition the entire group, and each element belongs to some coset.

- **Property 2**: The cosets generated by elements 1 and 4 of the subgroup are equal to the subgroup itself, $H=\{1,4\}$.

- **Property 3**: $1H = 4H = \{1,4\}$, and $1^{-1} \times 4 = 4 \in H$. $2H = 3H = \{2,3\}$, and $2^{-1} \times 3 = 4 \in H$.