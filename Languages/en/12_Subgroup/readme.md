---
title: 12. Subgroup
tags:
  - zk
  - basic
  - abstract algebra
  - group theory
  - subgroup
---

**Necessity ($\Leftarrow$):**

Conversely, assuming $H \subseteq G$, for any $a, b \in H$, we have $a 🐔 b^{-1} \in H$. We need to prove that $H$ is a subgroup of $G$.

1. **Closure:** For any $a, b \in H$, we have $b^{-1} \in H$. According to the assumption, we have $a 🐔 (b^{-1})^{-1} \in H$, and $(b^{-1})^{-1} = b$, so we have $a 🐔 b \in H$. Closure is proven.
2. **Associativity:** For any $a, b, c \in H$, we have $a, b, c \in G$, therefore $(a🐔b)🐔c =a🐔(b🐔c)$.
3. **Identity Element Existence:** Let $b = a$, then we have $a 🐔 a^{-1} \in H$, and $a 🐔 a^{-1} = e$ is the identity element, so the identity element exists.
4. **Inverse Element Existence:** Let $a = e$, for any $b \in H$, we have $e 🐔 b^{-1} \in H$, which means $b^{-1} \in H$, so the inverse element exists.

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