---
title: Draft. Sigma Protocol
tags:
  - zk
---

# WTF zk 教程第 Draft 讲：Sigma Protocol

本讲将介绍一个非常简洁优雅的 zkp 协议，并搭配 [CryptoHack](https://cryptohack.org/challenges/zkp/)上的习题帮助大家了解协议工作细节，进而加深对 zkp 协议的基础特性和概念的理解。

## 1. 协议

这个协议是由 Schnorr 基于离散对数难题假设而提出，因此也有人称之为 Schnorr 协议。

令 $q$ 是一个 [safe prime](https://en.wikipedia.org/wiki/Safe_and_Sophie_Germain_primes)，即 $p=2q+1$ 也是一个质数，且 $g$ 是整数模 $N$ 群 （参见[第 9 讲](https://github.com/WTFAcademy/WTF-zk/tree/main/09_Unit)） $Z^*_p$ 中阶为 $q$ 的元素。（根据拉格朗日定理推论：素数阶群一定是循环群。那么，这个 $g$ 就是 $Z^*_p$ 的循环子群 $\langle g \rangle
$ 的生成元）

假设证明者 $\mathcal{P}$ 随机从 $Z_q$ 中选取一个元素 $w$，计算并公开宣称 $a = g^w\pmod p$ 。任意验证者 $\mathcal{V}$ 获得 $p, q, g, h$ 后，可以做如下检查：

- $p, q$ 是质数；
- $g, h$ 的阶都为 $q$。

根据拉格朗日定理：子群的阶一定是群阶的因子。并且 $p=2q+1$，那么， $Z_p^*$ 中只有一个阶为 $q$ 的子群。这就意味着 $h\in \langle g \rangle
$

$\mathcal{P}$ 和 $\mathcal{V}$ 执行零知识证明协议内容如下：

1. $\mathcal{P}$ 随机从 $Z_q$ 中选取一个元素 $r$，计算 $a = g^r\pmod p$ 并发送给 $\mathcal{V}$。
2. $\mathcal{V}$ 随机从 $Z_{2^t}$ 中选取一个挑战值 $e$，并发送给 $\mathcal{P}$。这里的 t 是一个固定值，满足 $2^t < q$
3. $\mathcal{P}$ 发送 $z=r+ew\pmod q$ 给 $\mathcal{V}$，然后 $\mathcal{V}$ 检查 $g^z=ah^e$ ， $p, q$ 是质数，以及 $g, h$ 的阶都为 $q$。

如果协议通过检查，那么 $\mathcal{V}$ 可以相信  $\mathcal{P}$ 所宣称的：它知道一个数 $w$ ，且 $a = g^w$ 。但  $\mathcal{P}$ 并没有从中获取到任何关于 $w$ 的知识。

## 2. Completeness

完备性是指**诚实的双方**完整的执行协议，则协议将会通过。

那么只需要考虑等式 $g^z=ah^e$，有：

$$
g^{r+ew}=g^rg^{we}
$$

显然成立。这是一个协议应具备的最基本的属性，否则协议不具备可用性。

Practice: 大家可以做做 [CryptoHack](https://cryptohack.org/challenges/zkp/) 的 Proof of Knowledge 这道题，本质上就是需要你自己作为证明者去诚实完成协议内容。

<details><summary>My Solution 👀</summary>

这里我选择使用 [pwntools](https://docs.pwntools.com/en/stable/) 去写 python 脚本执行交互，而不是使用 netcat（nc）工具建立网络连接了。 

```python
from pwn import *
from random import randint
import json

# Diffie-Hellman group (512 bits)
# p = 2*q + 1 where p,q are both prime, and 2 modulo p generates a group of order q
P = 0x1ed344181da88cae8dc37a08feae447ba3da7f788d271953299e5f093df7aaca987c9f653ed7e43bad576cc5d22290f61f32680736be4144642f8bea6f5bf55ef
q = 0xf69a20c0ed4465746e1bd047f57223dd1ed3fbc46938ca994cf2f849efbd5654c3e4fb29f6bf21dd6abb662e911487b0f9934039b5f20a23217c5f537adfaaf7
g = 2


# w,y for the relation `g^w = y mod P` we want to prove knowledge of
# w = random.randint(0,q)
# y = pow(g,w,P)
w = 0x5a0f15a6a725003c3f65238d5f8ae4641f6bf07ebf349705b7f1feda2c2b051475e33f6747f4c8dc13cd63b9dd9f0d0dd87e27307ef262ba68d21a238be00e83
y = 0x514c8f56336411e75d5fa8c5d30efccb825ada9f5bf3f6eb64b5045bacf6b8969690077c84bea95aab74c24131f900f83adf2bfe59b80c5a0d77e8a9601454e5

conn = remote('socket.cryptohack.org', 13425)

print(conn.recvline())

r = randint(0, q)
a = pow(g, r, P)
# print(a)
msg = '{"a": 0}'
msg = json.loads(msg)
msg["a"] = a
conn.sendline(json.dumps(msg).encode())

conn.recvuntil(b': ')
e = int(conn.recvuntil(b', ', drop=True))
print(conn.recvline())

z = (r + e * w)  % q
msg = '{"z": 0}'
msg = json.loads(msg)
msg["z"] = z
conn.sendline(json.dumps(msg).encode())

conn.recvline()
```

</details>

## 3. Knowledge Soundness

零知识证明协议还需具备可靠性（Soundness）。我们把协议双方发送的消息 $(a, e, z)$ 称为一个 transcript 。

Knowledge Soundness 一个非形式化定义为：对于一个没有知识 $w$ 的恶意的证明者 $\mathcal{P^*}$，如果给定关于同一个 claim 的两个可通过协议的 transcripts $(a, e, z)$ 和 $(a, e', z')$，那么 $\mathcal{V}$ 可以构造一个提取器（Extractor）恢复（或者提取）出知识 $w$。

我们有：

$$
g^z=ah^e \pmod p\\
g^{z'}=ah^{e'}\pmod p
$$

由于循环群 $<g>$ 中不存在元素 0，则两式相除，有：

$$
g^{z-z'}=h^{e-e'} \pmod p
$$

由于 $g, h$ 都是阶数都为 q，则把两边同时上升到 $q$ 次幂，有：

$$
h=g^{(z-z')(e-e')^{-1}}
$$

即有： $w=(z-z')(e-e')^{-1} \pmod q$

这就是说，一个不知道 $w$ 的恶意证明者 $\mathcal{P^*}$ ，最多只能正确的响应 $\mathcal{V}$ 一次质询，否则 $\mathcal{V}$ 就可以通过两次质询恢复出知识 $w$，当然 $\mathcal{P}$ 也能恢复出知识。这与假设相悖。

因此恶意证明者只能响应那一个 query $e$ ，因此协议出错的概率为 $1/{2^t}$。如果选取安全参数，这个概率是可忽略的。

于是，我们可以得到结论：Sigma 协议中， $\mathcal{P}$ 能以不可忽略的概率说服 $\mathcal{V}$ 相信它拥有知识 $w$，并且 $\mathcal{V}$ 可以恢复（或者说提取）出来知识。

> 这里需要特别强调 Soundness 和 Knowledge Soundness之间的区别：
> - Soundness: Verifier 可以相信 Prover 中拥有可以通过协议的证明（proof），但不要求 Prover 一定有相应的知识（knowledge）。
> - Knowledge Soundness: Verifier 可以相信 Prover 中拥有知识。
>
> KS 是一个比 Soundness 更强的概念，因为Prover拥有知识，则一定可以生成相应证明。因此 KS 蕴含 Soundness，反之不一定成立。
> 
> 在之后的学习【Hyper Plonk】中，我们会知道：对于某些 oracle 关系的PIOP零知识证明协议，Soundness 可以直接推出 KS 。这在安全性证明中是很用的，因为我们只需要证 Soundness 即可。

Practice: 大家可以做做 [CryptoHack](https://cryptohack.org/challenges/zkp/) 的 Special Soundness 这道题，你需要作为 $\mathcal{V}$ 来恢复出证明者 $\mathcal{P}$ 的知识。

<details><summary>My Solution 👀</summary>

```python
from pwn import *
from random import randint
from Crypto.Util.number import long_to_bytes, inverse
import json

P = 0x1ed344181da88cae8dc37a08feae447ba3da7f788d271953299e5f093df7aaca987c9f653ed7e43bad576cc5d22290f61f32680736be4144642f8bea6f5bf55ef
q = 0xf69a20c0ed4465746e1bd047f57223dd1ed3fbc46938ca994cf2f849efbd5654c3e4fb29f6bf21dd6abb662e911487b0f9934039b5f20a23217c5f537adfaaf7
g = 2


conn = remote('socket.cryptohack.org', 13426)

print(conn.recvline())

e1 = randint(0, 2^511)
msg = '{"e": 0}'
msg = json.loads(msg)
msg["e"] = e1
conn.sendline(json.dumps(msg).encode())

msg = json.loads(conn.recvline().decode())
a1 = msg["a"]
y = msg["y"] # y = pow(g,flag,P)=g^w

msg = json.loads(conn.recvline().decode())
z1 = msg["z"]

e2 = randint(0, 2^511)
msg = '{"e": 0}'
msg = json.loads(msg)
msg["e"] = e2
conn.sendline(json.dumps(msg).encode())

msg = json.loads(conn.recvline().decode())
a2 = msg["a2"]
assert a1 == a2

msg = json.loads(conn.recvline().decode())
z2 = msg["z2"]

flag = (z1 - z2) * inverse(e1 - e2, q) % q
print(long_to_bytes(flag))
```
</details>

## 4. Honest Verifier Zero Knowledge

这是一个冗长的概念，比我们之前所预期的零知识性还加了一个前缀，我们来拆分解读：

- Honest Verifier：这个特性是说 Verifier 会严格遵循协议要求，随机挑选合适位数的 $e$，而与协议的其他值无关。
- Zero Knowledge：这个特性是说 Verifier 无法从协议过程中获取有关知识 $w$ 的任何信息。

为了证明零知识性，我们需要引入一个概念 “Simulator” ，译为模拟器，它的作用是模拟 Prover 的行为，但是它不具有知识。Verifier 会给模拟器 $S$ 正常按照协议规定发送随机数 $e$ ，如果模拟器同样可以像 Prover 一样产生可通过协议检查的 transcript，且整个协议过程和 Prover 与 Verifier 在真实世界中是不可区分的。那么就称这个协议是零知识的。

注意，这个模拟器在真实世界中是不存在的，只存在于理想世界中，因为它为了满足 Verifier 的检查，需要具备「超能力」。这种超能力可能是时光回溯（rewinding），或者其他不涉及知识 $w$ 的任何能力。对于 Verifier 而言，它的交互的对象表现得让它无法区分身处哪一个世界。

> 不可区分性这个概念非常重要，在正式证明中，我们需要从 transcript 的每个消息的概率分布（distribute）的角度去证明两个世界是不可区分的。进一步的，我们可以分为三种：
>
> - 计算不可区分：如果两个世界中消息的概率分布相差很大，但是作为弱计算能力 Verifier 无法感知到这一差距。我们称这样的两个世界是计算不可区分的。
> - 统计不可区分：如果两个世界中消息的概率分布相差很小，即使作为强计算能力 Verifier （比如无穷算力）无法感知到这一差距。我们称这样的两个世界是统计不可区分的。
> - 完美不可区分：如果两个世界中消息的概率分布没有差距，则称这样的两个世界是完美不可区分的。

现在，我们身处理想世界，体验一下模拟器的超能力。在真实世界中，Prover 需要首先向 Verifier 发送 $a$ ，然后 Verifier 再随机选择并发送 $e$，最后 Prover 发送 $z$。这样的设计是有重要含义的，因为如果 Verifier 可以先发送 $e$ ，Prover 再发送 $a, z$。那么任意的恶意 Prover 总是能够通过 Verifier 的质询。这样的协议设计下 Prover 具有**优势**，总是可以欺骗 Verifier。

具体欺骗步骤如下：

1. $\mathcal{V}$ 首先发送 $e(e\in Z_{2^t})$
2. $\mathcal{P}$ 随机选取 $z\in Z_q$，计算 $a = g^z / h^e \pmod p$
3. $\mathcal{V}$ 验证等式 $g^z=ah^e$。（显然成立）

而在理想世界中，模拟器没有知识但拥有超能力，允许它可以时光回溯，当它收到 Verifier 的质询挑战 $e$ 后，它选择时光回溯，把它第一步发送给 Verifier 的 $a$ 调整为可以通过本次质询的值。从而可以骗过 Verifier 的检测。这样的超能力是的模拟器具备了优势，即使没有知识，也能欺通过 Verifier 的挑战。

因此，对于诚实 Verifier，如果存在这样的模拟器，验证者不会学习到任何在本地无法有效计算的额外内容，除了“$\mathcal{P}$ 知道 $w$ ”这一事实。

> 注意，超能力不会使得 Verifier 少获取到任何协议中的信息，这是一种证明零知识性的常用工具。

Sigma 协议中的模拟器的优势是可以“随心所欲”的选取 $a, z$，但其他协议的模拟器可能会采取 `programming random oracle` 或者带陷门的 `common reference string` 或者其他能够带来优势的技术。

Practice: 同样的，在[CryptoHack](https://cryptohack.org/challenges/zkp/) 的 Honest Verifier Zero Knowledge 这道题，你需要作为一个具有上述优势的模拟器，来跟 Verifier 交互，并通过 Verifier 的验证。

<details><summary>My Solution 👀</summary>

```python
from pwn import *
from random import randint
from Crypto.Util.number import inverse
import json

P = 0x1ed344181da88cae8dc37a08feae447ba3da7f788d271953299e5f093df7aaca987c9f653ed7e43bad576cc5d22290f61f32680736be4144642f8bea6f5bf55ef
q = 0xf69a20c0ed4465746e1bd047f57223dd1ed3fbc46938ca994cf2f849efbd5654c3e4fb29f6bf21dd6abb662e911487b0f9934039b5f20a23217c5f537adfaaf7
g = 2


conn = remote('socket.cryptohack.org', 13427)

print(conn.recvline())

msg = json.loads(conn.recvline().decode())
e = msg["e"]
y = msg["y"] # y = pow(g,flag,P)=g^w

z = randint(0, q)
a = pow(g, z, P) * pow(y, -e, P) % P

msg = '{"a": 0, "e": 0, "z": 0}'
msg = json.loads(msg)
msg["a"] = a
msg["e"] = e
msg["z"] = z
conn.sendline(json.dumps(msg).encode())

print(conn.recvline())
```

</details>

## 5. Non-interactive

经过前 3 小节，我们了解了 zkp 协议最基本的三个性质，这一节我们来学习如何使用 Fiat-Shamir 变换把协议做成非交互式。

回顾整个协议，Verifier 需要给 Prover 发送一个随机值 $e$，协议中是存在交互行为。这在很多场景中是无法做到的，比如 web3 智能合约无法与外部世界交互。

Fiat 和 Shamir 观察到：可以要求 Prover 对协议的第一个消息进行 hash，hash 输出的值作为第二步 Verifier 发送的随机值。经过如此转换，协议的安全性不变。

有人可能会问，难道 Prover 不可以做恶吗？

当然可以，Prover 可以通过暴力穷举所有的 $a$ 经过 hash 之后的输出 $e$，找到它想要的目标 $a$ ，然后根据第三节的计算优势伪造一个合法的证明从而说服 Verifier。但是需要注意，根据之前的学习，协议的 knowledge soundness 特性确定对知识 $w$ 的 Prover 最多只能用有效的 $z$ 回复同一个 $e$ 。给定一个 $a$， Prover 暴力碰撞到这样一个有效通过协议的 transcript $(a, e=hash(a), z)$ 在最坏情况下需要 $2^t$ 次方次查询。对于算力有限的 Prover ，作弊成功的概率是可忽略的。

在使用 fiat-shamir 变换时，需要特别注意 hash 函数输入的选取。一般情况下，我们希望对所有的公共参数和第一条消息进行 hash。在很多复杂协议中，没有选择把所有的输入进行 hash，使得恶意的 Prover 容易找到合法的 transcript ，进而伪造证明，完成攻击。著名的案例有：[Frozen-Heart](https://blog.trailofbits.com/2022/04/13/part-1-coordinated-disclosure-of-vulnerabilities-affecting-girault-bulletproofs-and-plonk/ )。

更深入地，在采用 fiat-shamir 变换时，如果 $e=hash(a)$ 对于同一个 $a$ 保持一致，那么我们无法找到一个提取器来提取知识 $w$。密码学家通常把 hash 函数建模成所谓 RO (Random Oracle)。RO 在首次接收一个新输入时，会随机输出一个比特串；而当第二次或者更多次接收到相同输入时，则会输出与第一次相同的比特串。Fiat-Shamir 变换下的非交互式零知识证明系统一般而言在 ROM 下被证明是安全的，因为无法构造第 3 节的提取器提取出知识 $w$。如果对这一部分感兴趣，可以研究一下 23 年欧密上的 [Fiat-Shamir Bulletproofs are Non-Malleable](https://eprint.iacr.org/2023/147.pdf).

经过 fiat-shamir 变换之后，协议中关于 Verifier 的输入被全部删除，这意味着，恶意的 Verifier 无法对协议做任何破坏。因此，fiat-shamir变换之后，sigma协议由 Honest Verifier Zero Knowledge 转换成了对任意恶意 Verifier 都做到了 Zero Knowledge。

> Public coin：在某些文献，你也许可以看到 `public-coin` ，这其实就是在说可以运用 fiat-shamir 变换把做成非交互式的。
>
> 注意：public coin 和 honest verifier 二者不是等价的关系，它们定义了两个不同的假设模型。一般而言，public coin 用于非交互式上下文，而 honest verifier 用于零知识上下文。在 Public coin 模型下，所有的 Verifier （不管是否恶意）都可以参与，而 Honest verifier 模型只允许诚实 Verifier 参与。
>
> 总之：public coin 模型假设比 honest verifier 模型假设更弱，安全性更强。

Practice: 继续练习题 Non-Interactive。你需要实现一个非交互版本的 sigma 协议中 Prover 的工作流程。

<details><summary>My Solution 👀</summary>

```python
from pwn import *
from random import randint
from Crypto.Util.number import inverse, bytes_to_long
import json
from hashlib import sha512


P = 0x1ed344181da88cae8dc37a08feae447ba3da7f788d271953299e5f093df7aaca987c9f653ed7e43bad576cc5d22290f61f32680736be4144642f8bea6f5bf55ef
q = 0xf69a20c0ed4465746e1bd047f57223dd1ed3fbc46938ca994cf2f849efbd5654c3e4fb29f6bf21dd6abb662e911487b0f9934039b5f20a23217c5f537adfaaf7
g = 2

w = 0xdb968f9220c879b58b71c0b70d54ef73d31b1627868921dfc25f68b0b9495628b5a0ea35a80d6fd4f2f0e452116e125dc5e44508b1aaec89891dddf9a677ddc0

conn = remote('socket.cryptohack.org', 13428)

print(conn.recvline())

msg = json.loads(conn.recvline().decode())
y = msg["y"]

r = randint(1, q - 1)
a = pow(g, r, P)
e = bytes_to_long(sha512(str(a).encode()).digest()) % 2**511
z = (r + w * e) % q

msg = '{"a": 0, "e": 0, "z": 0}'
msg = json.loads(msg)
msg["a"] = a
msg["e"] = e
msg["z"] = z
conn.sendline(json.dumps(msg).encode())

print(conn.recvline())
```
</details>

## 总结

本讲我们通过学习 Sigma 协议（也可以称为 Schnorr 协议）了解了 ZKP 方案的基本特性，还通过 Fiat-Shamir 变换使得协议具备非交互性。这样一个简洁优雅的协议其实蕴含着非常多的细节，可以帮助我们进一步掌握 ZKP ，包括辨析 Public coin 和 Honest Verifier，理解 Fiat-Shamir 变换与 ROM 的联系等。

Schnorr 协议还有非常多的变种方案，也值得学习。推荐 Trial Of Bit 的 [ZkDocs](https://www.zkdocs.com/) 网站进行拓展阅读。

