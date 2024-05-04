---
title: Lecture 11. Group
tags:
  - zk
  - basic
  - abstract algebra
  - group theory
  - group
---

# WTF zk Tutorial Lesson 11: Group

Before we continue with advanced number theory, we need to understand abstract algebra concepts, including groups, rings, and fields. In this lecture, we will introduce the basics of group theory, including the definition of a group and its fundamental properties.

## 1. Abstract Algebra

The term "abstract algebra" is called "abstract" because it is an independent algebraic theory abstracted from specific mathematical structures. In abstract algebra, we look at the universal properties and patterns of algebraic structures instead of specific algebraic systems (such as real numbers or complex fields).

Specifically, abstract algebra starts with the general properties of algebraic structures and studies concepts such as sets, operations, and algebraic equations. It abstracts the study of various algebraic structures into a common algebraic theory, such as the concepts of groups, rings, fields, and so on. Through this abstract method, abstract algebra can reveal the commonalities between different algebraic systems, providing a more general perspective that allows us to understand and compare the relationships between different mathematical structures.

## 2. Group

A group is an abstract algebraic structure that consists of a set and a binary operation. A group is usually represented as $(G, 🐔)$, where $G$ represents the set of the group and $🐔$ represents the group's binary operation. In this tutorial, we discuss the concepts of abstract algebra in more depth. To represent the abstract group, we denote it as $(G, 🐔)$, where $🐔$ represents the binary operation, read as "g operation".

However, not every combination of a set and a binary operation can be called a group. It must satisfy four fundamental properties:

1. **Closure:** For any elements $A$ and $B$ in the Group, $A 🐔 B$ still belongs to the Group.

2. **Associativity:** The result of the operation of elements in a group does not depend on the order of calculation, that is, $(A 🐔 B) 🐔 C = A 🐔 (B 🐔 C)$

3. **Identity Element:** There exists a special element $E$ in the group, such that it does not change the value when operated with any element of the group, that is, $A 🐔 E=E 🐔 A=A$, similar to $0$ in integer addition.

4. **Inverse Element:** For every element in the group, there exists another element called the inverse element, and the result of their operation is the identity element $E$, that is, $A 🐔 A'=A' 🐔 A=E$. The element $A'$ is called the inverse element of $A$ and is denoted as $A^{-1}$.

We use these four fundamental properties to determine whether a set with a binary operation is a group. Here are a few examples.

Additional notes:

> 1. If a set and its binary operation satisfy only closure, it is called a "Magma".
> 2. If a "Magma" also satisfies associativity, it is called a "Semigroup".
> 3. If a "Semigroup" also has an identity element, it is called a "Monoid".
> 4. If a "Monoid" also has inverse elements for all elements, it is called a "Group".

### 2.1 $(\mathbb{Z}, +)$

Consider the set of integers $\mathbb{Z}$ and the addition operation:

1. The sum of two integers is still an integer, satisfying closure.

2. Addition of integers also satisfies associativity.

3. The identity element is $0$, and adding $0$ to any integer leaves the integer unchanged.

4. The inverse element of an integer is its negative, for example, the inverse of $5$ is $-5$.

Therefore, the set of integers $\mathbb{Z}$ with addition operation possesses the properties of a group and forms the group of integer addition.

### 2.2 $(\mathbb{Z}, \times)$

Consider the set of integers $\mathbb{Z}$ and the multiplication operation:

1. The product of two integers is still an integer, satisfying closure.

2. Multiplication of integers also satisfies associativity.

3. The identity element is $1$, and multiplying any integer by $1$ leaves the integer unchanged.

4. Except for $1$ and $-1$, other elements do not have inverse elements. For example, $2 \times 0.5 = 1$, but $0.5$ is not an integer.

Therefore, the set of integers $\mathbb{Z}$ with the multiplication operation does not possess the properties of a group and does not form a group.

### 2.3 $(\mathbb{R}, \times)$

Consider the set of real numbers $\mathbb{R}$ and the multiplication operation:

1. The product of two real numbers is still a real number, satisfying closure.

2. Multiplication of real numbers also satisfies associativity.

3. The identity element is $1$, and multiplying any real number by $1$ leaves the real number unchanged.

4. Except for $0$, all other real numbers have inverse elements, which are their reciprocals. However, $0$ does not have an inverse element.

Therefore, the set of real numbers $\mathbb{R}$ with the multiplication operation does not possess the properties of a group and does not form a group. However, if we exclude $0$ from the set of real numbers, denoted as $\mathbb{R} \setminus \{0\}$, and combine it with the multiplication operation, it does possess the properties of a group. Therefore, $(\mathbb{R}\setminus \{0\}, \times)$ is a group.

### 2.4 $(\mathbb{Z}_n^*, \times)$

Consider the unit set modulo $n$ denoted as $\mathbb{Z}_n^*$ and the multiplication operation:

1. The multiplication in the unit set modulo $n$ is closed.

2. Multiplication in modular arithmetic satisfies associativity.

3. The identity element is $1$, and multiplying any unit by $1$ leaves it unchanged.

4. Every element in the unit set modulo $n$ has an inverse element, and their product is $1$.

Therefore, the unit set modulo $n$, denoted as $\mathbb{Z}_n^*$, with the multiplication operation satisfies the properties of a group. It is often called the group of integer modulo $n$ multiplication.

### 2.5 Trivial Group

A trivial group refers to a group that contains only one element, which is its identity element $E$. The operation is defined as $E 🐔 E=E$. The trivial group satisfies four fundamental properties of a group, try to verify it.

## 3. Properties of Groups

From the four fundamental properties of a group, we can derive some important properties that all groups possess:

- **Unique Identity Element:** The identity element of a group is unique.

<details><summary>Click here to expand proof 👀</summary>

We prove by contradiction. First, assume that the group $(G, 🐔)$ has two identity elements $E$ and $E'$. According to the definition of the identity element, the product of the identity element with any element is equal to itself, that is, $E 🐔 E'=E=E'$ (which can be understood as $E$ $🐔$ identity element $E'$ equals $E$, or $E'$ $🐔$ identity element $E$ equals $E'$), which means $E=E'$. This leads to a contradiction. Therefore, the identity element in a group is unique.

</details>

- **Unique Inverse Element:** The inverse element of each element in the group is unique.

<details><summary>Click to expand proof 👀</summary>

We prove by contradiction. Suppose the group $(G, 🐔)$ has an element $A$ with two distinct inverse elements $B$ and $C$, namely $A 🐔 B=E$ and $A 🐔 C=E$. By multiplying both sides of $A 🐔 B=E$ by $C$, we have $C 🐔 A 🐔 B=E 🐔 C$. Since $C 🐔 A=E$, the equation can be simplified to $E 🐔 B=E 🐔 C$. According to the definition of the identity element, any element operated by the identity element is equal to itself. Therefore, we have $B=C$, which contradicts our assumption. Thus, the inverse element of each element in a group is unique.

</details>

- **Cancellation Law:** For any elements $a, b, c$ in the group, if $ab = ac$ or $ba = ca$, then $b = c$.

<details><summary>Click to expand proof 👀</summary>

We can multiply both sides of $ab = ac$ by the inverse element of $a$ on the left to obtain $b=c$.

Similarly, in the case of $ba = ca$, we can multiply both sides by the inverse element of $a$ on the right to obtain $b=c$.

</details>

## 4. Finite Groups and Infinite Groups

A finite group refers to a group in which the number of elements is finite, such as $(\mathbb{Z}_n^*, +)$. Finite groups are mainly used in cryptography, so they are our focus of study.

An infinite group refers to a group in which the number of elements is infinite, such as $(\mathbb{Z}, +)$ and $(\mathbb{R},+)$.

## 5. Summary

In this lecture, we introduced abstract algebra, the basic definition, and the properties of groups. Many zero-knowledge proof algorithms are based on group theory, so it is important to grasp this concept.
