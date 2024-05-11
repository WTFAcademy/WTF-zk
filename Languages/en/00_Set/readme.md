---
title: 00. Sets
tags:
  - zk
  - basic
  - set
---

# WTF zk Tutorial Lecture 0: Sets

Abstract algebra, also known as modern algebra, is an important foundation of modern mathematics. It studies the structural theory of groups, rings, and fields, which are three basic algebraic structures. The concepts of abstract algebra are extensively used in zk theory, so learners should have a basic understanding of abstract algebra.

In this tutorial, we will primarily focus on the foundation of abstract algebra: set theory.

## 1. Definition of Sets

A set is a mathematical model that represents a collection of different objects, called elements, which together form a whole. Concepts such as integers, rational numbers, real numbers, complex numbers, matrices, polynomials, polygons, and many others can all be essentially represented as sets.

> Common set abbreviations: $\mathbb{N}$ represents the set of natural numbers, $\mathbb{Z}$ ("Zahl" is Integer in German) represents the set of integers, $\mathbb{Q}$ represents the set of rational numbers, $\mathbb{R}$ represents the set of real numbers, $\mathbb{C}$ represents the set of complex numbers.

The number of elements in a set is called its cardinality. If the cardinality is finite, the set is called a finite set; otherwise, it is called an infinite set. There is a special type of set that does not contain any elements, called the empty set $\emptyset$. The characteristics of the empty set are:

- The empty set is a proper subset of any non-empty set.
- The empty set is a subset of any set.

## 2. Characteristics of Sets

Determinacy: For a set $S$ and an element $a$, the element either belongs to the set ($a\in S$) or does not belong to the set ($a
 \notin S$). There is no ambiguity.

Distinctness: In a set, every two elements are considered distinct, meaning that each element can only appear once. Sometimes, it is necessary to describe situations where the same element appears multiple times. This can be achieved using a multiset, where elements are allowed to appear multiple times.

```python
S = {1, 1, 2}
for elem in S:
    print(elem)
# 1
# 2
```

Unorderedness: In a set, the elements are considered equal in status, and there is no specific order among them. A total order can be defined on a set, and once a total order is defined, the elements can be sorted according to the order. However, in terms of the nature of a set itself, there is no inherent order among the elements.

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
Consider the sets of integers and rational numbers. There is a relationship between them: all integers are rational numbers, but not all rational numbers are integers. We define the set of integers as a subset of the set of rational numbers, and vice versa, the set of rational numbers as a superset of the set of integers.

Note: A being a subset of B does not require A to be strictly smaller than B. Therefore, we can say that the set of integers is a subset of the set of integers. When A is a subset of B and A is strictly smaller than B, we can further say that A is a proper subset of B.

### Intersection and Union

- Intersection: A set consisting of elements that belong to both set A and set B, denoted as A ∩ B (or B ∩ A).
- Union: A set consisting of all elements that belong to either set A or set B, denoted as A ∪ B (or B ∪ A).

Both intersection and union satisfy the commutative law, associative law, and distributive law.

### Equality/Equivalence

If two sets contain exactly the same elements (regardless of order), they are considered equivalent. Mathematically, if A ⊆ B and B ⊆ A, then A = B.

### Cardinality

As mentioned earlier, the cardinality of a set is defined as the number of elements in the set. In general, the cardinality of a finite set is meaningful, and we denote it as |A|. For infinite sets, if the set is a set of integers, for example, we can express its elements in words, which is called countable infinity. If the set is a set of complex numbers, for example, we cannot count its elements, so it is called uncountable infinity.

## 4. Ordered Pairs

The elements of a set are unordered, but ordered pairs are a new data structure derived from a set. In the programming world, programmers prefer to call them tuples.

How can we generate ordered pairs from an unordered set? The specific implementation is to represent the tuple (a, b) as the set {a, {b}}. It can be observed that the elements of such a set are either individual elements or sets with a cardinality of 1. Therefore, we say that (a, b) ≠ (b, a) because {a, {b}} ≠ {b, {a}}.

Note that the number of elements in an ordered pair (tuple) can be any number.

## 5. Cartesian Product

Given two sets A and B, we can define another set C, where the elements of C are ordered pairs with the first element coming from A and the second element coming from B. This set is called the Cartesian product.

The Cartesian product does not satisfy the commutative law.

## 6. Functions

With the Cartesian product operation, we can define functions from a mathematical perspective. For example, if we need to define a function f that satisfies f(1) = x, f(2) = y, f(3) = z, we only need to define two sets {1, 2, 3} and {x, y, z}, take the Cartesian product of the two sets, and then take a subset of the result to obtain the desired mapping relationship (1, x), (2, y), (3, z).

Therefore, in set theory, a function is defined as a subset of the Cartesian product of the domain set and the codomain set. In other words, as long as we have a domain set and a codomain set, the Cartesian product of the two sets can generate all possible mapping relationships from the domain to the codomain. A function is defined as a subset of these mapping relationships.

> Mathematicians rarely concern themselves with computability. That is, mathematicians define a function between two sets, but they are not concerned about how this function is computed (the specific mathematical formula).
>
> Programmers, on the other hand, believe that all functions are computable and have specific mathematical formulas.

In most cases, the term "function" is equivalent to "mapping". Of course, the definition of a mapping (function) determines its usefulness. For example, if we map everything to 0, this is reasonable, but this kind of mapping is basically useless.

Axiom of Choice: The Cartesian product of a non-empty set of sets is non-empty.

## 7. Injective, Surjective, Bijective

We define a function as a subset of the Cartesian product of two sets, but this subset is not arbitrary and needs to satisfy certain requirements: for a given input, the output of the function is unique.

There are three types of mappings that satisfy the requirements of a function:
- Injective function: Each element in the codomain corresponds to at most one element in the domain (also called preimage). An element in the codomain may not correspond to any element in the domain. However, if multiple elements in the domain correspond to the same element in the codomain, the function is not injective.
- Surjective function: Each element in the codomain corresponds to at least one element in the domain. If there is an element in the codomain that has no corresponding preimage, the function is not surjective.
- Bijective function: A function is bijective if and only if it is both injective and surjective.

For the above mappings, the most important thing is how to define the domain and codomain. Different choices of domain and codomain will result in different mappings.

Bijective and surjective mappings are also important when discussing the concepts of isomorphism and homomorphism, so please remember these basic definitions.

## 8. Relations

Relations are a very subtle concept, and you will often come across this concept when reading ZKP-related papers. In fact, we have already encountered relations in the descriptions above, such as intersection, union, subset, and equality between sets.

Mathematically, a relation is defined as "a subset of the Cartesian product of two sets". It can be seen that this definition is identical to the definition of a function (or mapping).

Since a relation involves a definite relationship between two sets, it is also called a binary relation, which will be mentioned again in the study of group, ring, and field theories.
