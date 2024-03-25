---
title: 32. 椭圆曲线加密
tags:
  - zk
  - abstract algebra
  - elliptic curve
  - group theory
  - finite field
  - discrete logarithm
  - diffie-hellman
  - elgamal
  - ecdsa
---

# WTF zk 教程第 32 讲：椭圆曲线密码学

这一讲，我们将介绍椭圆曲线密码学中的两个经典算法：椭圆曲线 Diffie-Hellman 算法（ECDH），椭圆曲线 Elgamal 算法（EC Elgamal），和椭圆曲线数字签名算法（ECDSA）。它们都是椭圆曲线和传统公钥加密技术的结合，能够在更短的密钥长度下提供更高的安全性。

如果你不了解 Diffie-Hellman 算法或 Elgamal 算法，可以阅读 WTF zk [里程碑02](https://github.com/WTFAcademy/WTF-zk/blob/main/MS02_DH/readme.md)和[里程碑03](https://github.com/WTFAcademy/WTF-zk/blob/main/MS03_ElGamal/readme.md)。

## 1. 椭圆曲线密码学

椭圆曲线密码学（ECC）是一种基于椭圆曲线数学理论的密码学方法，以椭圆曲线上的点加法和标量乘法为基础。ECC 的优势在于它能在较短的密钥长度下提供与传统公钥加密体系相同或更高的安全性。

- **密钥长度**：ECC 相比于传统的密码学算法，能够在更短的密钥长度下提供相同或更高的安全级别。例如，256位的 ECDH 密钥提供的安全性相当于约3072位的传统 Diffie-Hellman 密钥。
- **计算效率**：由于较小的密钥长度，ECC 通常在计算上更为高效。
- **带宽和存储**：由于密钥长度较短，ECC 在网络传输和存储上也更为高效。

## 2. ECDH算法

ECDH 算法是一种基于椭圆曲线的 Diffie-Hellman 密钥交换协议。它利用椭圆曲线离散对数问题（ECDLP）的难解性来实现安全的密钥交换，使得即使在公开信道上，攻击者也无法轻易推断出交换的密钥。

ECDH算法被广泛应用于许多安全通信标准和协议中，包括TLS/SSL安全传输协议、安全的即时通讯应用，和加密货币钱包。

### 2.1 密钥交换过程

ECDH 算法密钥交换过程和传统的 Diffie-Hellman 算法相似，只不过把整数乘法群换位了有限域上的椭圆曲线。

1. **参数选择**：双方协定使用相同的椭圆曲线参数和基点 $G$。
2. **私钥生成**：Alice 和 Bob 各自随机选择一个私钥 $a$ 和 $b$ 。
3. **公钥计算**：Alice 计算公钥 $A = aG$，Bob 计算公钥 $B = bG$。
4. **密钥共享**：Alice 将 $A$ 发送给 Bob，Bob 将 $B$ 发送给 Alice。
5. **共享密钥计算**：Alice 计算 $S = aB$ ，Bob 计算 $S = bA$。由于椭圆曲线的性质，有 $S = aB = bA = abG$ 成立，因此 Alice 和 Bob 共享相同的密钥 $S$。

### 2.2 代码示例

下面的Python代码中，我们使用`secp256k1`曲线进行 ECDH 密钥交换。

```python
# 椭圆曲线Diffie-Hellman算法 ECDH

from py_ecc.secp256k1 import secp256k1
import os

def generate_keys():
    private_key = int.from_bytes(os.urandom(32), 'big') % secp256k1.N
    public_key = secp256k1.multiply(secp256k1.G, private_key)
    return private_key, public_key

# Alice和Bob生成各自的密钥对
alice_private, alice_public = generate_keys()
bob_private, bob_public = generate_keys()

# 计算共享密钥
shared_secret_alice = secp256k1.multiply(bob_public, alice_private)
shared_secret_bob = secp256k1.multiply(alice_public, bob_private)

if shared_secret_alice == shared_secret_bob:
    print("共享密钥匹配。")
else:        
    print("共享密钥不匹配！")

print(f"Alice私钥: {alice_private}")
print(f"Alice公钥: {alice_public}")

print(f"Bob私钥: {bob_private}")
print(f"Bob公钥: {bob_public}")

print(f"共享密钥: {shared_secret_alice}")

# 共享密钥匹配。
# Alice私钥: 44226773042722162955098193291492534006186517732096623157459837212766793078584
# Alice公钥: (113906392817926084413632896524344771269472367375880032535005632965062391078788, 49665636540644454541653315656482000530366349019751676160955522917215379042285)
# Bob私钥: 51860882402071446551116109914681284224864199234652843480335793819475548437366
# Bob公钥: (52340819409831460217804635786419806447405367609650964443132838196582132856471, 56429557458241459690871510882159471830396052430769816127197158365607969924309)
# 共享密钥: (39817116182924354378808003014233470575110979407770339130416639641795260327693, 42970388080766198583159133018251494914868250846130428856587988974064644921855)
```

### 2.3 注意事项

- **曲线选择**：ECDH 的安全性依赖于椭圆曲线的选择。一些特定的曲线可能存在弱点，因此应选择经过实战检验的曲线。
- **随机数生成**：私钥的安全性依赖于随机数生成的质量，应使用加密安全的随机数生成器来生成私钥。
- **公钥验证**：在实际应用中，接收方应验证收到的公钥确实来自于合法的发送方，以防止中间人攻击。

## 3. EC ElGamal算法

椭圆曲线ElGamal加密算法（EC ElGamal）是融合椭圆曲线密码学（ECC）和ElGamal加密体系的一种公钥加密算法。它利用椭圆曲线离散对数问题（ECDLP）的难解性来实现安全的消息加密。

我们假设 Alice 要通过 EC ElGamal 算法跟 Bob 通信。

### 3.1 密钥生成

首先，Bob 需要生成密钥：

1. **选择椭圆曲线和基点**：选择一个椭圆曲线 $E$ 和其上的基点 $G$。
2. **生成私钥和公钥**：选择一个随机数 $x$ 作为私钥，计算公钥 $Y = xG$。

公钥为 $(E, G, Y)$，是公开的；私钥为 $x$，不公开。

### 3.2 加密

接下来，Alice 要用公钥加密消息明文 $M$，其中 $M$ 是椭圆曲线上的一个点：

1. 选择一个随机数 $k$。
2. 计算点 $C_1 = kG$。
3. 计算点 $C_2 = M + kY$。
4. 密文是点对 $(C_1, C_2)$。

随机数 $k$ 在每次加密都会变换，保证了 EC ElGamal 算法即使加密相同的明文也会输出不同的临时密文。在加密操作中，随机数 $k$ 是隐私的，而密文 $(C_1, C_2)$是公开的。

### 3.3 解密

Bob 收到密文 $(C_1, C_2)$ 后，需要使用私钥 $x$ 进行解密：

1. 计算点 $M' = C_2 - xC_1$。

计算得到的点 $M'$ 即为原始消息明文 $M$。

### 3.4 代码示例

下面的Python代码中，我们使用`secp256k1`曲线进行 EC Elgamal 加密。

```python
from py_ecc.secp256k1 import secp256k1

def elgamal_encrypt(G, Y, M):
    k = randint(1, secp256k1.N - 1)
    C1 = secp256k1.multiply(G, k)
    C2 = secp256k1.add(M, secp256k1.multiply(Y, k))
    return (C1, C2)

def elgamal_decrypt(C1, C2, x):
    # 使用私钥x计算xC1
    xC1 = secp256k1.multiply(C1, x)
    # 计算M = C2 - xC1
    M = secp256k1.add(C2, (xC1[0], -xC1[1]))
    return M

# 示例参数
p = secp256k1.N
G = secp256k1.G

# 生成密钥对
x, Y = generate_keys()

# 假设消息M是曲线上的一个点，这里简单选择G作为示例
M = G
print("原始消息明文:", M)

# 加密
C1, C2 = elgamal_encrypt(G, Y, M)
print("加密后的消息:", (C1, C2))

# 解密
M_decrypted = elgamal_decrypt(C1, C2, x)
print("解密后的消息:", M_decrypted)

# 验证
assert M == M_decrypted, "解密失败！"
print("消息成功解密！")

# 示例输出
# 原始消息明文: (55066263022277343669578718895168534326250603453777594175500187360389116729240, 32670510020758816978083085130507043184471273380659243275938904335757337482424)
# 加密后的消息: ((87298472810248234319752437423707505477343664832890363292431829216099637291919, 39528614830056678009484946030376271359657183017625571564228160252781333158439), (67113196324182438503834247973075313606138491143388276462715763950508942145812, 59499979624168470896804403233074133393632477568643779021536973756576878140912))
# 解密后的消息: (55066263022277343669578718895168534326250603453777594175500187360389116729240, 32670510020758816978083085130507043184471273380659243275938904335757337482424)
# 消息成功解密！
```

## 4. ECDSA

ECDSA（椭圆曲线数字签名算法）是椭圆曲线密码学中的一种常用数字签名算法，它利用 ECDLP 的难解性来确保签名的安全性，常被用于以太坊的智能合约中，见 [WTF Solidity 第37讲](https://github.com/AmazingAng/WTF-Solidity/blob/main/37_Signature/readme.md)。

我们假设 Bob 使用 ECDSA 进行签名，然后 Alic 验证。主要三个步骤：密钥生成、签名、验证签名。


### 4.1 密钥生成

首先，Bob 需要生成密钥：

1. **选择椭圆曲线和基点**：选择一个椭圆曲线 $E$ 和其上的基点 $G$，并计算基点的阶 $n$，即 $nG = O$。
2. **生成私钥和公钥**：选择一个随机数 $x$ 作为私钥，计算公钥 $Y = xG$。

公钥为 $(E, G, Y)$，是公开的；私钥为 $x$，不公开。

### 4.2 签名

接下来，Bob 要使用刚刚生成的私钥 $x$ 进行签名：

1. **消息哈希**：计算消息 $M$ 的哈希值 $H(M)$

2. **选择随机数**：生成一个随机数 $k$，确保 $1 < k < p-1$。

3. **计算 r**：通过随机数 $k$ 计算点 $P = kG$，将点 $P$ 的横坐标记为 $r$。

3. **生成签名**：计算 $s=k^{-1}(H(M)+xr) \mod n$，其中 $n$ 是基点 $G$ 的阶。生成的签名为 $(r, s)$。

生成签名要确保生成随机生成 $k$，不然私钥可能会泄露。另外，如果 $r$ 或 $s$ 为零，则需要重新生成随机数 $k$。

### 4.3 验证签名

这一步，Alice 利用消息原文 $M$ 和公钥 $Y$ 来验证签名的有效性。

1. **计算消息哈希**：计算 $H(M)$。

2. **计算 $u_1$ 和 $u_2$**：计算 $u_1=H(m)s^{-1} \mod n$ 和 $u_2=rs^{-1} \mod n$。

3. **验证签名**：计算点 $P'=u_1G+u_2Y$，如果 $P'$ 的横坐标等于 $r$，则签名有效。

### 4.4 算法正确性

咱们来看下为什么正确签名得到的 $P'$ 横坐标会和 $r$ 相等：

$$
P'=u_1G+u_2Y = u_1G+u_2xG
$$

使用标量乘法的分配律，有：

$$
P'= (u_1+u_2x)G
$$

展开 $u_1$ 和 $u_2$，有：

$$
P'=u_1G+u_2Y = (H(m)s^{-1} + rxs^{-1})G = (H(m) + rx)s^{-1}G
$$

展开 $s$，有

$$
P'=u_1G+u_2Y = (H(m) + rx)(k^{-1}(H(M)+xr))^{-1}G = kG = P
$$

因此，正确签名得到的 $P'$ 的横坐标与 $r$ 相等。

### 4.5 代码示例

下面的Python代码中，我们使用`secp256k1`曲线来实现ECDSA的签名和验证过程：

```python
# ECDSA

from py_ecc.secp256k1 import secp256k1
import os
import hashlib

def generate_keys():
    # 生成私钥
    private_key = os.urandom(32)
    private_key_int = int.from_bytes(private_key, 'big') % secp256k1.N
    # 生成公钥
    public_key = secp256k1.multiply(secp256k1.G, private_key_int)
    return private_key_int, public_key

def ecdsa_sign(message, private_key):
    # 对消息进行哈希处理
    message_hash = hashlib.sha256(message).digest()
    message_hash_int = int.from_bytes(message_hash, 'big')
    
    k = int.from_bytes(os.urandom(32), 'big') % secp256k1.N
    R = secp256k1.multiply(secp256k1.G, k)
    r = R[0] % secp256k1.N
    s = ((message_hash_int + r * private_key) * secp256k1.inv(k, secp256k1.N)) % secp256k1.N
    
    return (r, s)

def ecdsa_verify(message, signature, public_key):
    r, s = signature
    message_hash = hashlib.sha256(message).digest()
    message_hash_int = int.from_bytes(message_hash, 'big')
    
    w = secp256k1.inv(s, secp256k1.N)
    u1 = (message_hash_int * w) % secp256k1.N
    u2 = (r * w) % secp256k1.N
    
    P = secp256k1.add(secp256k1.multiply(secp256k1.G, u1), secp256k1.multiply(public_key, u2))
    
    return r == P[0] % secp256k1.N

# 示例
x, Y = generate_keys()
M = b"Hello, ECDSA with secp256k1!"
print("原始消息明文:", M)

signature = ecdsa_sign(M, x)
print("签名:", signature)

valid = ecdsa_verify(M, signature, Y)
print("签名验证结果:", valid)
```

## 4. 总结

这一讲，我们介绍了椭圆曲线密码学中的两个经典算法：ECDH 和 EC Elgamal。它们都是椭圆曲线和传统公钥密码学算法的结合，可以在较短的密钥长度下提供更高的安全性，非常适合区块链和零知识证明的使用场景。