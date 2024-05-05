---
title: 00. Sets
tags:
  - zk
  - basic
  - set
---

# WTF zk Tutorial Part 0: Sets

Abstract algebra, also known as modern algebra, is an important foundation of modern mathematics. It studies the structural theory of three fundamental algebraic structures: groups, rings, and fields. Abstract algebra concepts are extensively used in zk theory, so learners should have a basic understanding of abstract algebra.

In this tutorial, we will focus on the fundamentals of abstract algebra, specifically set theory.

## 1. Definition of Sets

A set is a mathematical model of a collection of different objects, called elements. Concepts such as integers, rational numbers, real numbers, complex numbers, matrices, polynomials, polygons, and many others can be thought of as sets.

> Common set abbreviations: $\mathbb{N}$ represents the set of natural numbers, $\mathbb{Z}$ represents the set of integers, $\mathbb{Q}$ represents the set of rational numbers, $\mathbb{R}$ represents the set of real numbers, $\mathbb{C}$ represents the set of complex numbers.

The number of elements in a set is called the cardinality of the set. If the cardinality is finite, the set is called a finite set; otherwise, it is an infinite set. There is a special type of set that does not contain any elements, called the empty set $\emptyset$. It has the following characteristics:

- The empty set is a proper subset of any non-empty set.
- The empty set is a subset of any set.

## 2. Characteristics of Sets

Determinism: Given a set $S$ and an element $a$, the element either belongs to the set ($a\in S$) or does not belong to the set ($a\notin S$). There is no ambiguity.

Distinctness: In a set, each element is considered distinct, meaning that each element can only appear once. Sometimes it is necessary to describe a situation where the same element appears multiple times. This can be done using a multiset, where elements are allowed to appear multiple times.

```python
S = {1, 1, 2}
for elem in S:
    print(elem)
# 1
# 2
```

Unorderedness: In a set, the position of each element is irrelevant, and the elements are unordered. Although an order relation can be defined on a set, the inherent nature of a set itself does not have a specific order among its elements.

```python
S = {'0xaa', 123, 'a', 0.123}

# Unorderedness
for elem in S:
    print(elem)
# 0xaa
# 0.123
# 123
# a
```

## 3. Basic Relations Between Sets

### Subset and Superset
Consider the sets of integers and rational numbers. There is a relationship between them: all integers are rational numbers, but not all rational numbers are integers. We define: the set of integers is a subset of the set of rational numbers, and conversely, the set of rational numbers is a superset of the set of integers.

Note: $A$ is a subset of $B$ does not require $A$ to be strictly smaller than $B$. Therefore, we can say that the set of integers is a subset of itself. When $A$ is a subset of $B$ and $A$ is strictly smaller than $B$, we can further say that $A$ is a proper subset of $B$.

### Intersection and Union

- Intersection: The set containing elements that belong to both $A$ and $B$ is denoted as $A\bigcap B$ (or $B \bigcap A$).
- Union: The set containing all elements that belong to either set $A$ or set $B$ is denoted as $A\bigcup B$ (or $B\bigcup A$).

Both intersection and union follow the commutative, associative, and distributive laws.

### Equality/Equivalence

If two sets contain exactly the same elements (without considering the order), they are considered equivalent. Mathematically, if $A \subseteq B \wedge B \subseteq A$, then $A=B$.

### Cardinality

As mentioned earlier, the number of elements in a set is called its cardinality. The cardinality of a finite set is meaningful and is denoted as $|A|$. For infinite sets, if it can be put in one-to-one correspondence with the set of integers, it is called countably infinite; if it cannot be counted, it is called uncountably infinite.

## 4. Ordered Pairs

The elements of a set are unordered, but ordered pairs are a new data structure generated from a set. In the programming world, programmers commonly refer to them as tuples.

So how do we generate ordered pairs from an unordered set? The specific implementation is to represent the tuple $(a, b)$ as a set in the form of $\{a, \{b\}\}$. It can be seen that the elements of such a set are either individual elements or sets with a cardinality of 1. Therefore, we say $(a, b)\neq(b,a)$ because $\{\{a, \{b\}\}\neq\{b,\{a\}\}$.

Note that the number of elements in an ordered pair (tuple) can be any number.

## 5. Cartesian Product

Given two sets $A$ and $B$, we can define another set $C$, where the elements of $C$ are ordered pairs with the first element from set $A$ and the second element from set $B$. This set is called the Cartesian product.

The Cartesian product does not follow the commutative law.

## 6. Functions

With the Cartesian product operation, we can define functions from a mathematical perspective. For example, if we need to define a function $f$ such that $f(1)=x,f(2)=y, f(3)=z$, we only need to define two sets $\{1, 2, 3\}$ and $\{x, y, z\}$, take the Cartesian product of the two sets, and take a subset of the result to obtain the desired mapping relationship $(1, x), (2, y), (3, z)$.

Therefore, in set theory, a function is a subset of the Cartesian product of the domain set and the codomain set. In other words, as long as we have a domain set and a codomain set, we can obtain all possible mapping relationships from the domain to the codomain by taking the Cartesian product of the two sets. A function is defined as a subset of these mapping relationships.

> Mathematicians are not concerned with the computability of functions. They define a function between two sets without specifying how the function is computed (the specific mathematical formula).
>
> On the other hand, programmers believe that all functions are computable and have specific mathematical formulas.

In most cases, the term "function" is equivalent to "mapping". However, the definition of a mapping (function) determines its usefulness. For example, if we map everything to 0, it is a valid function but not very useful.

Axiom of Choice: The Cartesian product of a collection of non-empty sets is non-empty.

## 7. Injective, Surjective, and Bijective Functions

We define a function as a subset of the Cartesian product of two sets, but this subset is not arbitrary; it needs to satisfy a restriction: for a given input, the output of the function is unique.

There are three types of mappings that satisfy this restriction:
- Injective function: Each element in the codomain is associated with at most one preimage (also called an inverse image) in the domain. Elements in the codomain may not have any corresponding preimage in the domain. However, if multiple preimages in the domain correspond to the same element in the codomain, then the function is not injective.
- Surjective function: Each element in the codomain is associated with at least one element in the domain. If there is an element in the codomain that has no corresponding preimage, the function is not surjective.
- Bijective function: A function is bijective if and only if it is both injective and surjective.

The choice of domain and codomain determines the specific mappings for these types of functions.

Bijective and surjective functions are also important when discussing the concepts of isomorphism and homomorphism, so please remember these basic definitions.

## 8. Relations

Relations are a subtle concept and often encountered when reading papers related to ZKP. In fact, we have already encountered relations in the descriptions above, such as intersection, union, subset, and equality, which are all relations between sets.

Mathematically, a relation is defined as "a subset of the Cartesian product of two sets". It can be seen that this definition is similar to the definition of a function (or mapping).

Since it involves a relationship between two sets, it is also called a binary relation. This will be mentioned again in the study of group, ring, and field theories.