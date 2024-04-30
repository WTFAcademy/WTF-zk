设 $a$ 和 $b$ 是环 $R$ 中的元素。

首先证明 $(-a)b = -(ab)$：

$(-a)b + ab = (-a + a)b$ （使用分配律）

$(-a)b + ab = 0b$ （由 $-a + a = 0$）

$(-a)b + ab = 0$ （由乘法零元性质）

因此，$(-a)b = -(ab)$。

接下来证明 $a(-b) = -(ab)$：

$a(-b) + ab = a(-b + b)$ （使用分配律）

$a(-b) + ab = a0$ （由 $-b + b = 0$）

$a(-b) + ab = 0$ （由乘法零元性质）

因此，$a(-b) = -(ab)$。

综上所述，$(-a)b = -(ab) = a(-b)$。

证毕。

</details>

**性质7. 环中的乘法逆元不一定存在，即不是每个元素都有乘法逆元。**

在一个环中，并不是每个元素都存在乘法逆元。只有非零元素且可逆的元素才有乘法逆元。
First, let's prove that $(-a)b = -(ab)$, which is essentially proving that $ab$ and $(-a)b$ are inverse elements. According to the distributive property, we have $(-a)b + ab = (-a + a)b= 0b = 0$, thus $ab$ and $(-a)b$ are inverse elements, and $(-a)b = -(ab)$ holds.

Using the same method, we can prove that $ab$ and $a(-b)$ are also inverse elements, thus $-(ab) = a(-b)$.

Therefore, we have $(-a)b = -(ab) = a(-b)$. Q.E.D.

</details>

**Property 7: Elements $a$ and $b$ are elements in the ring $R$, we have $(-a)b = -(ab) = a(-b) = - (-a)(-b)$.**

<details><summary>Click to expand proof👀</summary>

First, let's prove that $(-a)b = -(ab)$, which is essentially proving that $ab$ and $(-a)b$ are inverse elements. According to the distributive property, we have $(-a)b + ab = (-a + a)b = 0b = 0$, thus $ab$ and $(-a)b$ are inverse elements, and $(-a)b = -(ab)$ holds.

Using the same method, we can prove that $ab$ and $a(-b)$ are also inverse elements, thus $-(ab) = a(-b)$.

Next, we prove that $-(ab) = -(-a)(-b)$, which is to prove that $-ab$ and $(-a)(-b)$ are inverse elements. According to the distributive property, we have $-ab + (-a)(-b) = -a(b-b) = -a0= 0$, thus they are inverse elements, and $-(ab) = -(-a)(-b)$ holds.

Therefore, we have $(-a)b = -(ab) = a(-b) = - (-a)(-b)$. Q.E.D.

</details>

We can use the integer ring and the integer modulo n ring as examples to understand these properties.

## 5. Subring

For a ring $(R, +, \cdot)$, if $S$ is a non-empty subset of $R$, and $S$, +, and $\cdot$ also form a ring, then we call $S$ a **subring** of $R$.

We can use the following conditions to determine if the ring $S$ is a subring of $R$:

1. **Closure under addition:** For any $a, b \in S$, we have $a+b \in S$.
2. **Preservation of zero element:** The zero element of $R$ is also in $S$, i.e. $0_R = 0_S$.
3. **Existence of additive inverse:** For any $a \in S$, we have $-a \in S$.
4. **Closure under multiplication:** For any $a, b \in S$, we have $ab \in S$.
5. **Existence of (multiplicative) identity element:** $S$ has a multiplicative identity element.

Alternatively:

1. **Closure under subtraction (criteria for subgroups):** For any $a, b \in S$, we have $a+b \in S$.
2. **Closure under multiplication:** For any $a, b \in S$, we have $ab \in S$.
3. **Existence of (multiplicative) identity element:** $S$ has a multiplicative identity element.

## 6. Summary

In this lesson, we introduced the basic definition and properties of rings, and learned about some examples of rings. Rings are an important concept in abstract algebra and provide a foundation for further learning.