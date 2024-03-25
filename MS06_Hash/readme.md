---
title: Milestone 06. 哈希函数
tags:
  - zk
  - basic
  - cryptography
  - hash
  - pedersen hash
  - hash to curve
  - quadratic residual
---

# WTF zk 教程 里程碑 06：哈希函数

在这一讲中，我们将深入探讨哈希函数（hash function），特别是哈希函数和椭圆曲线的结合，包括 hash-to-curve 和 Pedersen Hash。

## 1. 什么是哈希函数？

哈希函数是一种算法，它将任意长度的输入（通常称为“消息”）映射为固定长度的字符串，这个字符串称为哈希值或摘要。最常用的哈希函数是 SHA256，它将任意长度的输入转化为256位（32字节）的哈希值，被广泛用于加密、数据完整性校验和数字签名等场景。

一个好的哈希函数应满足以下特性：

- **确定性**：相同的输入始终产生相同的输出。
- **单向性**：对任何输入，哈希函数都能在短时间内返回其哈希值；但是从哈希值逆向推导出输入信息是计算上不可行的。这使得哈希值可以很好的隐藏原始输入。
- **抗碰撞性**：给定两个不同的输入，它们具有相同的输出（即碰撞）的概率几乎为零。比如字符串 apple，apples，和 zpple 差别不大，但它们的哈希却完全不一样。
- **绑定性**：输入数据的微小变化将导致输出哈希值的巨大变化，这使得对数据的任何更改都很容易被发现。

```python
# Hash function : sha256
from hashlib import sha256

def get_hash(message_string):
    return sha256(message_string.encode('utf-8')).hexdigest()

print("apple 的哈希:", get_hash("apple"))
print("apples 的哈希:", get_hash("apples"))
print("zpple 的哈希:", get_hash("zpple"))

# apple 的哈希: 3a7bd3e2360a3d29eea436fcfb7e44c735d117c42d1c1835420b6b9942dd4f1b
# apples 的哈希: f5903f51e341a783e69ffc2d9b335048716f5f040a782a2764cd4e728b0f74d9
# zpple 的哈希: 2d198bd02ab5e8a7260f50db5dea5672c03151c3febcf3d2ec129263d4f299bd
```

## 2. Hash-to-curve

在椭圆曲线密码学中，hash-to-curve（哈希到曲线）方法可以将消息通过哈希函数映射到椭圆曲线上的一个点。在一些椭圆曲线加密算法，例如 ECDSA 和EC ElGamal，我们需要将消息哈希为椭圆曲线上的一个确定的点，会用到 hash-to-curve 方法。

为什么需要 hash-to-curve？直接计算消息的哈希不行吗？

不一定行，因为如果我们直接将消息的哈希作为点的横坐标 $x$，然后通过椭圆曲线方程 $y^2 = x^3 + ax + b$ 得到 $y^2$。这样计算的 $y^2$ 可能不是模 $p$ 下二次剩余，这时椭圆曲线上不存在横坐标为 $x$ 的点。因此，我们需要用特殊的方法将消息映射到椭圆曲线上。

## 2.1 Try-and-increment

Try-and-increment（尝试并递增）是一个常用的 hash-to-curve 方法，它的思路很简单，基本步骤包括：

1. **选择一个哈希函数**：通常会选择一个抗碰撞性强的哈希函数，如 SHA-256。

2. **初始化计数器**：初始化一个计数器 $c = 0$。

3. **计算消息哈希**：将消息 $M$ 和计数器 $c$ 拼接到一起，然后进行哈希处理，得到一个哈希值 $H(M|c)$，其中 $|$ 代表拼接。

4. **尝试构造点**：将哈希值视为椭圆曲线上点 $P(x,y)$ 的横坐标，并通过椭圆曲线方程计算 $y^2$。

5. **检查点有效性**：对于每个生成的点，检查它是否满足椭圆曲线方程，即 $y^2$ 是否为二次剩余。如果满足，就接受这个点作为哈希的结果。如果不满足，就将计数器 $c$ 递增 1，然后重复步骤 3-5。

在下面的python示例中，我们使用 try-and-increment 方法，将字符串 `'Example message'` 哈希到 secp256k1 上的一个点： 

```python
# Hash to curve
# Try-And-Increment method

from hashlib import sha256
from py_ecc.secp256k1 import secp256k1

def hash_to_curve_try_and_increment(message):
    # 计数器
    counter = 0
    while True:
        # 计算 message 和 counter 的 hash
        data = message + counter.to_bytes(32, 'big')
        hash_digest = sha256(data).digest()

        # 从 hash 计算 x 坐标
        x = int.from_bytes(hash_digest, 'big') % secp256k1.P

        # 尝试通过椭圆曲线方程 y^2 = x^3 + ax + b,计算 y^2
        y_squared = (pow(x, 3, secp256k1.P) + secp256k1.A * x + secp256k1.B) % secp256k1.P
        
        # 计算 y^2 在模 p 下的平方根，如果有的话（对于 secp256k1，p % 4 = 3，可以用这个方法计算）
        y = pow(y_squared, (secp256k1.P + 1) // 4, secp256k1.P)

        # 如果 y^2 = y_squared，说明 y^2 是二次剩余， (x, y) 是椭圆曲线上的点，返回它
        # 如果不是，则 counter 加一，再试一次
        if pow(y, 2, secp256k1.P) == y_squared:

            # y^2 有两个平方根 y 和 -y，我们利用 hash 的最后一位决定 y 的符号
            sign_bit = hash_digest[-1] & 1
            if sign_bit == 1:
                y = secp256k1.P - y  # Use -y

            return (x, y)

        counter += 1

# 示例
message = 'Example message'.encode('utf-8')
point_on_curve = hash_to_curve_try_and_increment(message)
print(f"Point on secp256k1 curve: {point_on_curve}")

# 输出
# Point on secp256k1 curve: (75672206050705717597513752332592681441562708170391675094677140490692301502235, 2079954378639550643990441934946533201466680551826647417569849183466717633402)
```

## 3. Pedersen Hash

Pedersen 哈希是一种哈希函数，它利用了椭圆曲线上的两个生成点（也称为基点）来实现。它具有隐藏性和绑定性两个主要特性，常用语零知识证明算法。

假设我们想要哈希一个消息 $m$，我们可以选择一个随机数 $r$ 作为盲因子（blinding factor），然后使用以下公式来构造哈希值 $H$：

$$
H = rG + mP
$$

这里，点 $G$ 是 secp256k1 的生成点，点 $P$ 是通过 hash-to-curve 得到的点， $r$ 是随机生成的盲因子，而 $m$ 是我们想要哈希的消息。注意，这里的基点 $G$ 和 $P$ 要独立生成，即不能存在一个较小的 $k$，使得 $P = kG$。


在下面的python示例中，我们使用 secp256k1 曲线上的基点 $G$ 和 hash-to-curve 方法得到的点 P 作为两个基点，构造了一个简单的 Pedersen 哈希函数。


```python
from py_ecc.secp256k1 import secp256k1
import os

def pedersen_hash(G, P, m, r):
    """
    利用 secp256k1 上的两个点 G 和 P 计算 Pedersen hash
    :param G: secp256k1 生成点
    :param P: 通过 hash-to-curve 生成的点
    :param m: 消息
    :param r: 随机数
    :return: The Pedersen hash as a point on the secp256k1 curve.
    """
    hash_point = secp256k1.add(secp256k1.multiply(G, m), secp256k1.multiply(P, r))
    return hash_point

def message_to_int(message):
    """将消息转换为int"""
    message_hash = sha256(message.encode('utf-8')).digest()
    return int.from_bytes(message_hash, 'big')

# 示例
G = secp256k1.G
P = (75672206050705717597513752332592681441562708170391675094677140490692301502235, 2079954378639550643990441934946533201466680551826647417569849183466717633402)
m = message_to_int('Example message')
r = int.from_bytes(os.urandom(32), 'big') % secp256k1.N  # Random blinding factor
print(f"随机数r: {r}")
# 随机数r: 73024396533133913522992000700997978493545300935845156062873113842229351634806

hash_point = pedersen_hash(G, P, m, r)
print(f"Pedersen hash: {hash_point}")
# Pedersen hash: (61158186220483422500680232915115660637414963516696475985433668859480078549697, 19925636506537717141567615179623096875787300022679479682581994441236159884610)
```

## 4. 总结

这一讲，我们介绍了哈希函数，它在密码学和数据安全中占据着核心地位。SHA-256 是最常用哈希函数，Pedersen哈希常被用于零知识证明。有些加密算法要求消息映射到椭圆曲线上，我们需要用到 hash-to-curve 方法。
