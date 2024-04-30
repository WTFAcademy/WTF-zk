现在考虑任意 $a, b \in H$。根据逆元存在的性质，$b^{-1} \in H$。由封闭性的性质，$a 🐔 b^{-1} \in H$。证毕。

**必要性（ $\Leftarrow$）：**

假设对于任意 $a, b \in H$，都有 $a 🐔 b^{-1} \in H$。我们需要证明 $H$ 满足子群的定义。

根据定义，我们需要证明：

1. $H$ 是 $G$ 的子集。
2. $H$ 对于群运算 $🐔$ 构成一个群。
3. $H$ 满足群的四个基本性质：封闭性、结合律、存在单位元、存在逆元。

首先，根据假设，对于任意 $a \in H$，有 $a 🐔 e^{-1} = a 🐔 e = a \in H$，这意味着 $H$ 包含 $G$ 的单位元 $e$，即 $e \in H$。

其次，对于任意 $a, b \in H$，根据假设，$a 🐔 b^{-1} \in H$。由结合律的性质，$(a 🐔 b^{-1}) 🐔 b = a 🐔 (b^{-1} 🐔 b) = a 🐔 e = a \in H$，这意味着 $H$ 对于群运算 $🐔$ 是封闭的。

再次，对于任意 $a \in H$，根据假设，$a 🐔 a^{-1} \in H$。由逆元存在的性质，$a 🐔 a^{-1} = e \in H$。因此，对于每个 $a \in H$，都存在其逆元 $a^{-1} \in H$。

最后，由于 $H$ 是 $G$ 的子集，所有的基本性质都满足。因此，$H$ 满足子群的定义。证毕。

</details>

使用这个方法，我们可以更方便地检验一个集合是否为给定群的子群。
Let $c = b^{-1}$. Since $c \in H$, according to closure, $a🐔c \in H$, that is, $a🐔b^{-1} \in H$. Sufficiency is proven.

**Necessity ($\Leftarrow$):**

Conversely, assuming $H \subseteq G$, for any $a, b \in H$, we have $a 🐔 b^{-1} \in H$. We need to prove that $H$ is a subgroup of $G$.

1. **Closure:** For any $a, b \in H$, we have $b^{-1} \in H$. According to the assumption, we have $a 🐔 (b^{-1})^{-1} \in H$, and $(b^{-1})^{-1} = b$, so we have $a 🐔 b \in H$. Closure is proven.
2. **Associativity:** For any $a, b, c \in H$, we have $a, b, c \in G$, therefore $(a🐔b)🐔c =a🐔(b🐔c)$.
3. **Identity Element Existence:** Let $b = a$, then we have $a 🐔 a^{-1} \in H$, and $a 🐔 a^{-1} = e$ is the identity element, so the identity element exists.
4. **Inverse Element Existence:** Let $a = e$, for any $b \in H$, we have $e 🐔 b^{-1} \in H$, which means $b^{-1} \in H$, so the inverse element exists.

In conclusion, $H$ satisfies the 4 properties of group axioms and $H \subseteq G$, therefore $H$ is a subgroup of $G$.

Q.E.D.

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