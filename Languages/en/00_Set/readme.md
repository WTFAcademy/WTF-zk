title: 00. Set
tags:
  - zk
  - basic
  - set
---

# WTF Zero-Knowledge Proof Tutorial 00: Set

Abstract algebra, also known as modern algebra, is one of the important foundations of modern mathematics. It studies the algebraic structures of groups, rings, and fields. The concepts of abstract algebra are widely used in zero-knowledge proof (zk) theory, so learners should be familiar with the basic knowledge of abstract algebra.

In this tutorial, we will mainly study the basics of abstract algebra: set theory.

## 1. Definition of Sets

A set is a mathematical model of a collection of different objects, which are called the elements of the set. Integers, rational numbers, real numbers, complex numbers, matrices, polynomials, polygons, and many other concepts are essentially sets.

> Abbreviations commonly used for sets: $\mathbb{N}$ represents the set of natural numbers, $\mathbb{Z}$ represents the set of integers (Zahl in German means Integer), $\mathbb{Q}$ represents the set of rational numbers, $\mathbb{R}$ represents the set of real numbers, and $\mathbb{C}$ represents the set of complex numbers.

The number of elements in a set is defined as the cardinality of the set. When the cardinality is finite, the set is called a finite set; otherwise, it is an infinite set. There is a special type of set that does not contain any elements, called the empty set $\emptyset$, which has the following characteristics:

- The empty set is a proper subset of any non-empty set.
- The empty set is a subset of any set.

## 2. Characteristics of Sets

Determinism: Given a set S and an element a, the element either belongs to the set (a∈S) or does not belong to the set (a∉S). There is no ambiguity.

Uniqueness: In a set, any two elements are considered distinct, and each element can only appear once. Sometimes, it is necessary to describe the situation where the same element appears multiple times, which can be done using multiset, where elements are allowed to appear multiple times.

```python
S = {1, 1, 2}
for elem in S:
    print(elem)
# 1
# 2
```

Unorderedness: In a set, the position of each element is the same, and the elements are unordered. An order relation can be defined on a set, and once defined, the elements can be sorted according to the order relation. However, in terms of the nature of the set itself, there is no inherent order among the elements.

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

## 3. Basic Relationships between Sets

### Subset and Superset
Consider the sets of integers and rational numbers. There seems to be a certain relationship between them: all integers are rational numbers, but not all rational numbers are integers. We define: the set of integers is a subset of the set of rational numbers, and conversely, the set of rational numbers is a superset of the set of integers.

Note: A is a subset of B does not necessarily mean A is strictly smaller than B. Therefore, it can be said that the set of integers is a subset of itself. When A is a subset of B and A is strictly smaller than B, it can be further said that A is a proper subset of B.

### Intersection and Union

- Intersection: The set consisting of elements that belong to both set A and set B, denoted as A∩B (or B∩A).
- Union: The set consisting of all elements that belong to set A or set B, denoted as A∪B (or B∪A).

Both operations follow the commutative, associative, and distributive laws.

### Equality/Equivalence

If two sets contain exactly the same elements (without considering the order), they are considered equivalent. In strict mathematical language, if A ⊆ B and B ⊆ A, then A = B.

### Cardinality

As mentioned earlier, the number of elements in a set is defined as the cardinality. In general, the cardinality of a finite set is meaningful, and it is denoted as |A|. For infinite sets, if it is a set of integers, it can be expressed in words, which is called countably infinite; if it is a set of complex numbers, it is impossible to count its elements, so it is called uncountably infinite.

## 4. Ordered Pairs

The elements of a set are unordered, and ordered pairs are a new data structure derived from sets. In the programming world, programmers prefer to call them tuples.

So how do we generate ordered pairs from an unordered set? The specific implementation is to represent the tuple (a, b) in set form as {a, {b}}. Note that the elements of such a set are either letters or sets with a cardinality of 1. Therefore, we say (a, b) ≠ (b, a) because {{a, {b}}} ≠ {{b, {a}}}.

Note that the number of elements in an ordered pair (tuple) can be any number.

## 5. Cartesian Product

Given two sets A and B, we can define another set C, in which the elements of C are ordered pairs with the first element from A and the second element from B. This set is called the Cartesian product.

The Cartesian product does not follow the commutative law.

## 6. Functions

With the Cartesian product operation, we can define functions from a mathematical perspective. For example, if we need to define a function f such that f(1)=x, f(2)=y, and f(3)=z, we only need to define two sets {1, 2, 3} and {x, y, z}, take the Cartesian product of the two sets, and select a subset of the results to obtain the desired mapping relationship (1, x), (2, y), (3, z).

Therefore, in set theory, a function is a subset of the Cartesian product of a domain set and a codomain set. In other words, as long as we have a domain set and a codomain set, the Cartesian product of the two sets can obtain all possible mapping relationships from the domain to the codomain. A function is defined as a subset of these mapping relationships.

> Mathematicians rarely care about computability. That is, mathematicians define a function between two sets, but they are not concerned about how this function is computed (the specific mathematical formula).
> 
> Programmers, on the other hand, believe that all functions are computable and have specific mathematical formulas.

In most cases, the term function is equivalent to mapping. Of course, the definition of mapping (function) determines its usability. For example, if we map everything to 0, it is reasonable, but such a mapping is generally not useful.

Axiom of Choice: The Cartesian product of a set of non-empty sets is non-empty.

## 7. Injective, Surjective, and Bijective

We define a function as a subset of the Cartesian product of two sets, but this subset is not arbitrary and needs to be restricted: for a given input, the output of the function is unique.

There are three types of mappings that satisfy the requirements of a function:
- Injective function: Each element in the codomain corresponds to at most one element in the domain (also known as the preimage). An element in the codomain can correspond to no element in the domain. However, if multiple elements in the domain correspond to the same element in the codomain, the function does not satisfy injectivity.
- Surjective function: Each element in the codomain corresponds to at least one element in the domain. If there exists an element in the codomain with no corresponding preimage, the function does not satisfy surjectivity.
- Bijective function: A function is bijective if and only if it satisfies both injectivity and surjectivity.

For the above mappings, the most important thing is how to define the domain and codomain. Different choices of domain and codomain will result in different mappings.

Bijective and surjective mappings are also important when discussing the concepts of isomorphism and homomorphism, so please remember these basic definitions.

## 8. Relations

Relations are a very subtle concept, and you will often come across this concept when reading ZKP-related papers. In fact, we have already encountered relations in the descriptions above, such as intersection and union, subset and superset, and equality, which are all relations between sets.

However, mathematically speaking, a relation is defined as "taking a subset of the Cartesian product of two sets". It can be seen that this definition is no different from the definition of a function (or mapping).

Since it involves a definite relationship between two sets, it is also called a binary relation, which will continue to be mentioned in the study of the theory of groups, rings, and fields later.