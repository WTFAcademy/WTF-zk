---
title: Milestone 07. 身份基加密
tags:
  - zk
  - basic
  - cryptography
  - hash
  - pedersen hash
  - hash to curve
  - quadratic residual
---

# WTF zk 教程 里程碑 07：身份基加密

这一讲，我们将介绍身份基加密（Identity-Based Encryption，IBE），它允许用户以身份信息作为加密系统的公钥，比如邮箱地址。

## 1. 身份基加密

身份基加密（IBE）由 Adi Shamir 在 1984 年提出，主要特点是它允许任何一方使用公开可获取的信息，比如用户的电子邮件地址或域名，作为其公钥。这样，发送方可以直接使用接收方的身份信息加密消息，无需事先获取接收方的公钥。这解决了传统公钥基础设施（PKI）中存在的密钥分发问题。

### 1.1 基本原理

IBE 系统通常包含四个主要部分：

1. **设置**：一个受信任的中心化机构：私钥生成中心（Private Key Generator，PKG），负责验证用户的身份信息，生成对应的私钥，并安全地分发给用户。
2. **提取**：用户向 PKG 证明身份，并获取身份对应的私钥。
3. **加密**：发送方使用接收方的公开身份（如电子邮件地址）和系统的公共参数进行消息加密。
4. **解密**：接收方使用其从 PKG 获取的私钥来解密接收到的消息。

### 1.2 优缺点特点与优势

IBE 系统有以下优点：

- **简化的密钥管理**：不需要像传统公钥系统那样维护和分发证书，因为用户的公钥是其身份信息，如电子邮件地址。这简化了密钥管理和分发过程。
- **即时加密**：发送方可以在不先获取接收方公钥的情况下立即对消息进行加密，只需知道接收方的身份信息即可。
- **延迟私钥生成**：用户的私钥直到第一次需要时才由 PKG 生成和提取，这允许灵活的密钥管理。

同时，它也有一些缺点：

- **中心化**：所有的私钥由一个中心化机构（PKG）生成和分发，如果 PKG 受到攻击，系统的整体安全性就会受到威胁。
- **密钥撤销**：如果一个用户的私钥被泄露，就需要一种机制来撤销这个密钥。但在 IBE 中，公钥基于用户的身份信息（如电子邮件地址），无法在不更改用户身份的情况下更改/撤销公钥。

## 2. Boneh-Franklin IBE方案

虽然 IBE 早在 1984 年被提出，但实用方案直到 2001 年才出现：Boneh 和 Franklin 提出了基于配对的 IBE 方案，解决了传统公钥加密体系中密钥管理和分发的难题。

下面我们以 bls 曲线为例，介绍 IBE 方案中 Alice 给 Bob 发送加密消息的步骤。

### 2.1 设置

这一阶段，私钥生成中心（PKG）选择全局参数，包括：

- 椭圆曲线 bls12_381 参数
- 公共参数：bls中 $E(\mathbb{F}_p)$ 的基点 $G_1$， $E(\mathbb{F}_{p^2})$ 的基点 $G_2$。
- 系统主私钥 $s$ 。
- 系统主公钥 $P^{PKG} = sG_1 \in E(\mathbb{F}_p)$。 
- 双线性配对 $e: E(\mathbb{F}_{p^2}) \times E(\mathbb{F}_p) \to \mathbb{F}_{p^{12}}$
- 哈希函数 $H_1$: 将消息哈希为椭圆曲线 $E(\mathbb{F}_{p^2})$ 上的点。
- 哈希函数 $H_2$: 将配对结果哈希为字节。

### 2.2 提取

Alice 提取公钥和私钥。

- Alice 选择一个基于身份的公钥 $\text{Pub}^{Alice}$，比如邮箱 `"alice@wtf.email"`，使用哈希函数 $H_1$ 将公钥映射到椭圆曲线上的点 $P^{Alice} = H_1(\text{Pub}^{Alice}) \in E(\mathbb{F}_{p^2})$。

- 向 PKG 请求私钥 $Q^{Alice} = s P^{Alice} \in E(\mathbb{F}_{p^2})$。

### 2.3 加密

Bob 根据 Alice 的身份信息对消息 $M$ 进行加密。

- 选择一个明文 $M$ 和一个随机数 $r$。
- 计算点 $P^{Alice} = H_1(\text{Pub}^{Alice})$。
- 计算 $C_1 = rG_1$。
- 计算 $C_2 = M \oplus H_2(e(P^{Alice}, P^{PKG})^r)$，其中 $\oplus$ 指的异或操作。

Bob 发送给 Alice 的密文是 $(C_1, C_2)$。

### 2.4 解密

这一步，Alice 使用私钥 $Q^{Alice}$ 解密密文 $(C_1, C_2)$，解密出的消息 $M' = C_2 \oplus H_2(e(Q^{Alice}, C_1))$。

若加密和解密的步骤正确，Alice 能够解密出正确的明文 $M' = M$。

### 2.5 算法正确性

为什么 $M' = M$？

我们展开 $M'$:

$$
M' = C_2 \oplus H_2(e(Q^{Alice}, C_1))
$$

$$
M' =M \oplus H_2(e(P^{Alice}, P^{PKG})^r) \oplus H_2(e(Q^{Alice}, C_1))
$$

根据异或操作的性质，若 $H_2(e(P^{Alice}, P^{PKG})^r) =  H_2(e(Q^{Alice}, C_1))$，就有 $M' = M$。

请读者根据双线性配对的性质来验证两者是相等的。

### 2.6 代码示例

下面，我们使用 py_ecc 库写一个基于 bls 曲线配对的 IBE 示例，包含了 IBE 的设置、提取、加密、解密这四个步骤。我们简化了验证身份这一步，提供身份就能获得相应的私钥。

```python
from py_ecc.optimized_bls12_381 import G1, G2, multiply, add, pairing, curve_order, FQ2, FQ12
from py_ecc.bls.hash_to_curve import hash_to_G2
from hashlib import sha256
import os

# H1: 将 message 哈希为 G2 曲线上的点
def H1(message, dst=b'WTF-HASH-TO-CURVE-bls12-381'):
    # The DST parameter is domain separation tag for the hash function
    point_projective = hash_to_G2(message, dst, sha256)
    return point_projective

# H2: 将 fq12 element (pairing结果) 哈希为 bytes
def H2(fq12_elem):
    # 将FQ12元素的所有系数转换为字符串并连接
    concatenated_coeffs = ''.join(str(coeff) for coeff in fq12_elem.coeffs)
    # 对连接后的字符串进行SHA256哈希处理
    hash_digest = sha256(concatenated_coeffs.encode()).digest()
    return hash_digest

# 计算两个 bytes 的 xor
def xor_bytes(bytes1, bytes2):
    """XOR two bytes objects together."""
    return bytes(a ^ b for a, b in zip(bytes1, bytes2))

# IBE 加密
def ibe_encrypt(master_pk, user_id, message):
    r = int.from_bytes(os.urandom(32), 'big') % curve_order
    
    # Compute shared secret using pairing
    P_user = H1(user_id.encode())
    shared_secret = pairing(P_user, master_pk)
    C1 = multiply(G1, r)
    C2 = xor_bytes(message, H2(shared_secret ** r))

    return C1, C2

# IBE 解密
def ibe_decrypt(user_sk, C1, C2):
    shared_secret = pairing(user_sk, C1)
    M = xor_bytes(C2, H2(shared_secret))
    return M


# 主密钥生成
master_sk = int.from_bytes(os.urandom(32), 'big') % curve_order
master_pk = multiply(G1, master_sk)

# 根据 Alice id 生成私钥
alice_id = "alice@wtf.email"
alice_sk = multiply(H1(alice_id.encode()), master_sk)

# Bob 编码消息
bob_id = "bob@wtf.email"
message = b"WTF, Alice!"
print("Original message:", message)
C1, C2 = ibe_encrypt(master_pk, alice_id, message)
print("Encryption C1:", C1)
print("Encryption C2:", C2)

# Alice 解码消息
decrypted_message = ibe_decrypt(alice_sk, C1, C2)
print("Decrypted message:", decrypted_message)

# 示例输出
# Original message: b'WTF, Alice!'
# Encryption C1: (725374226968432448365528450463540667799630567526402423184017492362194410232185198007920253993995187216521721662343, 2220163884092685170597202150534200353558680069175326450716109816259628864987790756986054551188110826100753535572404, 578944078995539478898067346383698208062908690132418954413632161636084423626880593706141384237810614307828491209731)
# Encryption C2: b'\xdd\xcfGS\xfa:j\xc2&@\x13'
# Decrypted message: b'WTF, Alice!'
```

## 3. 总结

这一讲，我们介绍了身份基加密，并且实现了一个简单的 Boneh-Franklin IBE方案。身份基加密允许用户以身份信息作为加密系统的公钥，比如邮箱地址，解决了传统公钥基础设施（PKI）中存在的密钥分发问题。
