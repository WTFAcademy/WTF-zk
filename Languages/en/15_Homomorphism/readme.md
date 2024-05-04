# WTF zk Tutorial Lesson 15: Homomorphism and Isomorphism

Up until now, we have been focusing on the internal relations of groups: groups, subgroups, cosets, and quotient groups. In this tutorial, we will study the relationship between two groups and introduce the concepts of homomorphism and isomorphism.

## 1. Group Homomorphism

Group homomorphism literally means that two groups have similar forms. For two groups $(G, 🐔)$ and $(H, 🐑)$, if the function $f: G \to H$ satisfies the condition for $a, b \in G$:

$$
f(a 🐔 b) = f(a) 🐑 f(b)
$$

, then we say that there exists a group homomorphism $f$ from $G$ to $H$.

> For simplicity, we will refer to it as "homomorphism" instead of "group homomorphism".

The left side of the equation means that we first perform the operation of $a$ and $b$ in the group $G$, and then map the result to the group $H$ using $f$. The right side of the equation means that we first map the elements $a$ and $b$ of group $G$ to the group $H$, and then perform the operation on the derived elements in $H$. In group homomorphism, both methods lead to the same result. Therefore, homomorphism establishes a connection between two groups while preserving the basic operation structure of the group.

For example, let $G = \set{R, +}$ be the group of real number addition, and $H = \set{R_{+}, \times}$ be the group of positive real number multiplication. Then the exponential function $f(x) = e^x$ is a homomorphism from $G$ to $H$, because for $a, b \in R$, we have $f(a+b) = e^{a+b} = e^ae^b = f(a)f(b)$, which satisfies the definition of homomorphism.

Another example is let $G = \set{\mathbb{Z}, +}$ be the group of integer addition, and $H = \set{\mathbb{Z}^*_n, +}$ be the group of integer addition modulo $n$. Define the function $f(x) \equiv x \pmod{n}$ as a homomorphism from $G$ to $H$. For $a, b \in \mathbb{Z}$, we have $f(a+b) = a+b \pmod{n} = a  \pmod{n} + b  \pmod{n} =f(a) + f(b)$, which satisfies the definition of homomorphism.

### 1.1 Properties

Group homomorphisms have some very nice properties. If $f: (G, 🐔) \to (H, 🐑)$ is a group homomorphism, then:

**1. The identity element is preserved:** $f(e_G) = e_H$, where $e_G$ and $e_H$ are the identity elements of groups $G$ and $H$ respectively.

<details><summary>Click to expand proof👀</summary>

According to the property of the identity element, for any $a \in G$, we have $f(a 🐔 e_G) = f(a) 🐑 e_H$. According to the property of group homomorphism, we have $f(a 🐔 e_G) = f(a) 🐑 f(e_G) = f(a) 🐑 e_H$. By eliminating $f(a)$ on both sides of the equation, we have $f(e_G) = e_H$. Proof completed.

</details>

**2. The inverse element is preserved:** $f(a ^{-1}) = f(a)^{-1}$.

<details><summary>Click to expand proof👀</summary>

$f(e_G) = f(a a ^{-1}) = f(a)f(a ^{-1}) = e_H$. Proof completed.

</details>

**3. Subgroups are preserved:** If $X$ is a subgroup of $G$, then $f(X)$ is a subgroup of $H$, where $f(X) = \set{f(x) \mid x \in X}$.

<details><summary>Click to expand proof👀</summary>

According to the method of [subgroup check](https://github.com/WTFAcademy/WTF-zk/tree/main/12_Subgroup#3-%E5%AD%90%E7%BE%A4%E7%9A%84%E6%A3%80%E9%AA%8C) mentioned earlier, for any $a, b \in X$, we have $f(a), f(b) \in f(X)$, therefore $f(a) 🐑 f(b)^{-1} = f(a) 🐑 f(b^{-1})  = f(a 🐔 b^{-1})$. Since $a 🐔 b^{-1} \in X$, we have $f(a 🐔 b^{-1}) \in f(X)$. Therefore, if $X$ is a subgroup of $G$, then $f(X)$ is a subgroup of $H$. Proof completed.

</details>

**4. The inverse theorem of preserved subgroups:** If $f(X)$ is a subgroup of $H$, then $X$ is a subgroup of $G$.

<details><summary>Click to expand proof👀</summary>

According to the method of [subgroup check](https://github.com/WTFAcademy/WTF-zk/tree/main/12_Subgroup#3-%E5%AD%90%E7%BE%A4%E7%9A%84%E6%A3%80%E9%AA%8C) mentioned earlier, for any $f(a), f(b) \in f(X)$, and if $f(X)$ is a subgroup of $H$, we have $f(a 🐔 b^{-1}) = f(a) 🐑 f(b)^{-1} \in f(X)$. Therefore, $a 🐔 b^{-1} \in X$, $X$ is a subgroup of $G$. Proof completed.

</details>

To summarize, if two groups have a homomorphism between them, then their identity elements, inverse elements, and the structure of subgroups are preserved by the homomorphism. From the perspective of group theory, these two groups are similar.

### 1.2 Examples

Let's use an example of an exponential function(take $e$ as the base) to help understand the properties of homomorphisms:
- Preservation of the identity element: In $G = \set{R, +}$, 0 is the identity element, so $f(0) = e^0 = 1$ is the identity element of $H = \set{R_{+}, \times}$.
- Preservation of the inverse element: In $G$, $-1$ and $1$ are inverse elements, so $f(-1) = 1/e$ and $f(1) = e$ are inverse elements in $H$.
- Preservation of subgroups and inverse subgroups: The group of integer addition $(\mathbb{Z}, +)$ is a subgroup of $G$, so $f(Z) = \set{,..., e^{-2}, e^{-1}, 1, e, e^{2}, ...}$ is a subgroup of $H$. And vice versa.

## 2. Image and Kernel

Group homomorphisms determine two important subgroups: the image and the kernel. Next, we will learn about them. But let's first review the concepts of image and pre-image for functions:
- The image $f(A)$ of a mapping $f$ is the set of values obtained by applying the mapping to the domain $A$, represented as $\set{ f(a) \mid a \in A }$.
- The pre-image $f^{-1}(y)$ of a mapping is the inverse operation of the mapping, representing all possible pre-images of a given element in the codomain, i.e., $\set{ x \in A \mid f(x) = y }$.

The image describes the output range, while the pre-image describes all possible inputs of the mapping for a given output.

### 2.1 Image of a Homomorphism

For a group homomorphism $: G \to H$, the image is the set of all elements in group $G$ that are mapped by the function $f$. The image of a homomorphism is usually denoted by $\text{Im}(f)$:

$$
\text{Im}(f) = f(G) =  \{ f(a) \mid a \in G \}
$$

Specifically, the image is the set of all elements of the form $f(a)$, where $a$ is an element in group $G$.

### 2.2 Kernel of a Homomorphism

The kernel of a homomorphism is another important concept in group homomorphisms. It refers to the pre-image of the identity element of group $H$ in group $G$, in other words, the kernel is a subset of group $G$ where the elements are mapped to the identity element in $H$. The kernel of a homomorphism is usually denoted by $\text{Ker}(f)$ and defined as:

$$
\text{Ker}(f) = f^{-1}(e_H) = \set{ a \in G \mid f(a) = e_H }
$$

Since $\set{e_H}$ is the trivial subgroup of group $H$, according to the property of preserved subgroups by homomorphism, the kernel of a homomorphism is a subgroup of group $G$, reflecting the part of group $G$ that is mapped to the identity element in the homomorphism.

### 2.3 Properties

**1. The image $\text{Im}(f)$ is a subgroup of group $H$.**

<details><summary>Click to expand proof👀</summary>

The group $G$ is its own trivial subgroup. According to the preservation property of subgroups by homomorphisms, $\text{Im}(f) = f(G)$ is a subgroup of $H$. Proof completed.

</details>

**2. The kernel $\text{Ker}(f)$ is a subgroup of group $G$.**

<details><summary>Click to expand proof👀</summary>

$\set{e_H}$ is the trivial subgroup of group $H$. According to the inverse property of preserved subgroups by homomorphisms, $\text{Ker}(f) = f^{-1}(e_H)$ is a subgroup of $G$. Proof completed.

</details>

**3. The kernel is a normal subgroup:** The kernel $\text{Ker}(f)$ is a normal subgroup of group $G$.

<details><summary>Click to expand proof👀</summary>

The left and right cosets of a normal subgroup are equal. Let's observe the cosets of $\text{Ker}(f)$: For any $a \in G$, the left coset is $a\text{Ker}(f) = \set{ah \mid h \in \text{Ker}(f)}$. According to the homomorphism definition, $f(a h a^{-1}) = f(a) f(h) f(a^{-1}) = f(a) e_H f(a)^{-1} = f(a)f(a)^{-1} = e_H$, so there exists $h' \in \text{Ker}(f)$ such that $ah = h'a$, i.e., $ah = h'a$. Therefore, $aH = Ha$, the left and right cosets are the same. The kernel $\text{Ker}(f)$ is a normal subgroup of group $G$. Proof completed.

</details>
To summarize, the kernel and image of a homomorphism have nice properties, respectively being subgroups of $G$ and $H$. Specifically, the kernel is a normal subgroup of $G$. Based on what we learned in the previous lesson, we can construct a quotient group using the kernel, assigning elements of group $G$ to equivalence classes, further characterizing the relationship between $G$ and $H$. This introduces the first isomorphism theorem that we will discuss.

## 3. Classification of Group Homomorphisms

Based on whether the homomorphism $f$ is an injection, surjection, or bijection, we can classify homomorphisms as injective homomorphisms, surjective homomorphisms, and isomorphisms. First, let's review what injections, surjections, and bijections are.

In mathematics, injections, surjections, and bijections are properties that describe the mapping (function) between sets.

1. **Injective (Injection):**
   A mapping $f: A \rightarrow B$ is called injective if for any distinct elements $a_1$ and $a_2$ in set $A$, we have $f(a_1) \neq f(a_2)$. In other words, different elements are mapped to different values.

2. **Surjective (Surjection):**
   A mapping $f: A \rightarrow B$ is called surjective if for every element $b$ in set $B$, there is at least one element $a$ in set $A$ such that $f(a) = b$. In other words, the range of the mapping is equal to the target set.

3. **Bijective (Bijection):**
   A mapping $f: A \rightarrow B$ is called bijective if it is both injective and surjective. In other words, each element has a unique mapping and every element is mapped to.

Next, let's learn how to determine the type of a homomorphism.

**1. Necessary and Sufficient Condition for an Injective Homomorphism (i.e., mapping $f$ is injective): The kernel of the homomorphism consists only of the identity element $e_G$ of group $G$, i.e., the kernel $\text{Ker}(f)=\{e_G\}$.**

<details><summary>Click to expand the proof 👀</summary>

**Sufficiency**

In an injective homomorphism, $f$ is injective, i.e., for $a, b \in G$, $f(a) \neq f(b)$. Using proof by contradiction, assume there exist distinct $a,b \in \text{Ker}(f)$ such that $f(a) = f(b) = e_G$, which contradicts the fact that $f$ is injective. Therefore, if $f$ is an injective homomorphism, the kernel $\text{Ker}(f)$ consists only of the identity element $e_G$. Proof completed.

**Necessity**

Again, using proof by contradiction, assume there exist $a, b \in G$ such that $a \neq b$ and $f(a) = f(b)$. Their inverses in $H$ are also equal, i.e., $f(a)^{-1} = f(b) ^{-1}$. According to the group homomorphism, $f(b^{-1}a) = f(b)^{-1} f(a) = f(b)^{-1} f(b) = e_H$. According to the definition of the kernel, $b^{-1}a \in \text{Ker}(f)$. Since $a \neq b$, we have $b^{-1}a \neq e$. In other words, the kernel of the homomorphism contains at least two elements, $e$ and $b^{-1}a$, contradicting the fact that the kernel of the homomorphism consists only of the identity element of group $G$. Therefore, there does not exist $a \neq b$ such that $f(a) = f(b)$. Proof completed.

</details>

**2. Necessary and Sufficient Condition for a Surjective Homomorphism (i.e., mapping $f$ is surjective): The image of the homomorphism $\text{Im}(f)$ is equal to the group $H$ itself, i.e., $\text{Im}(f) = H$.**

<details><summary>Click to expand the proof 👀</summary>

According to the definitions of image and surjective homomorphism, we can easily obtain this result.

</details>

**3. Necessary and Sufficient Condition for an Isomorphism (i.e., mapping $f$ is bijective): The kernel of the homomorphism consists only of the identity element $e_G$ of group $G$, and the image of the homomorphism $\text{Im}(f)$ is equal to the group $H$ itself, denoted as $G \cong H$.**

<details><summary>Click to expand the proof 👀</summary>

According to the definition, when $f$ is both an injective homomorphism and a surjective homomorphism, it is called an isomorphism. The result can be obtained easily based on the previous two properties.

</details>

To summarize, the necessary and sufficient condition for an injective homomorphism reflects the importance of the kernel and the identity element: it is easy to deduce that the kernel of an injective homomorphism only consists of the identity element because if there were other elements mapping to $e_H$, it would not be an injection. However, deducing an injective homomorphism from a kernel that only consists of the identity element is a bit more complicated. We can start from its contrapositive: if a homomorphism is not an injective homomorphism, if a mapping is not an injection, then the kernel of the homomorphism does not only consist of the identity element. The proof is also intuitive: if $f(a) = f(b)$ for $a \neq b$, according to the homomorphism, $b^{-1}a \neq e_G$ will also enter the kernel, "contaminating" it. This also reflects the importance of the kernel and the identity element in homomorphisms. The sufficient condition for a surjective homomorphism is straightforward and requires no further explanation.

## 4. The First Isomorphism Theorem

If two groups are isomorphic, from the perspective of group theory, they are essentially the same because they have the same group properties, such as order and subgroup structure.

The first isomorphism theorem connects group homomorphisms with quotient groups. It is defined as follows:

If $f: G \to H$ is a group homomorphism, then the quotient group constructed by the kernel is isomorphic to the image of the homomorphism, i.e., $G/\text{Ker}(f) \cong \text{Im}(f)$, where the isomorphism mapping is $\hat{f}(x\text{Ker}(f)) = f(x)$.

<details><summary>Click to expand the proof 👀</summary>

We have derived that the kernel of the homomorphism $\text{Ker}(f)$ is a normal subgroup of $G$, so we can define an operation rule in the quotient group $G/\text{Ker}(f)$ that is consistent with $G$. For the sake of simplicity, let $K$ replace $\text{Ker}(f)$.

First, we need to prove that $\hat{f}: G \to K$ is a homomorphism. For any $a, b \in G$, we have $\hat{f}(aK) \hat{f}(bK) = f(a)(b) = f(ab) = \hat{f}(abK)$, hence $\hat{f}$ is a homomorphism.

Next, we prove that $\hat{f}$ is an injection. For any $a, b \in G$ and $\hat{f}(aK) = \hat{f}(bK)$, we have $f(a) = f(b)$, therefore, $f(ab^{-1}) = f(a) f(b)^{-1} = e_H$, according to the definition of the kernel, $ab^{-1} \in K$. According to the property of coset equality, $aK = bK$. Therefore, if $\hat{f}(aK) = \hat{f}(bK)$, then $aK = bK$, and $\hat{f}$ is an injection.

Finally, we prove that $\hat{f}$ is a surjection. For any $a \in G$, $\hat{f}(aK) = f(a)$. According to the definition of the image of the homomorphism, the range of $f(a)$ is $\text{Im}(f)$, therefore, $\hat{f}$ is a surjection.

Proof completed.

</details>

Let's intuitively understand the first isomorphism theorem. It states that the quotient group constructed by the kernel, $G/\text{Ker}(f)$, is isomorphic to the image of the homomorphism $\text{Im}(f)$. In other words, they have the same properties of a homomorphism, being both an injective homomorphism and a surjective homomorphism. The surjective homomorphism is easy to understand: since the cosets partition the entire group, the quotient group $G/\text{Ker}(f)$ consists of cosets and naturally divides the entire $G$, so its range is also $\text{Im}(f)$, which means it is surjective. What about the injective homomorphism? The identity element of the quotient group $G/\text{Ker}(f)$ is $\text{Ker}(f)$, and the kernel is also $\text{Ker}(f)$, so the kernel consists only of the identity element. According to the necessary and sufficient condition for an injective homomorphism, this homomorphism is an injective homomorphism. The clever thing is that even if the kernel of group $G$ contains elements other than $e_G$, in the quotient group $G/\text{Ker}(f)$, they all fall into the identity element $\text{Ker}(f)$ (the elements of the quotient group are cosets, which are sets), so it becomes an injective homomorphism. It's really clever!

![](./img/15-1.jpeg)

As shown in the above picture, the isomorphism mapping $\varphi$ from $G$ to $\varphi(G)$ can be decomposed into a surjective mapping $\pi:G \to G/\text{Ker}(\varphi)$ and an injective mapping $\psi:G/\text{Ker}(\varphi) \to \varphi(G)$. That is, $\varphi = \pi \circ \psi$.

If you still don't have an intuitive understanding of the first isomorphism theorem, you can read [this article](https://www.math3ma.com/blog/the-first-isomorphism-theorem-intuitively).

## 5. Summary

In this lesson, we introduced group homomorphisms and isomorphisms. Homomorphisms can be understood as two groups having similar structures, and isomorphisms mean the two groups have the same structure. The first isomorphism theorem connects groups, subgroups, cosets, quotient groups, homomorphisms, and isomorphisms together elegantly. It is very satisfying and enjoyable to learn.
