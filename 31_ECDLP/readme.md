---
title: 31. 椭圆曲线离散对数问题
tags:
  - zk
  - abstract algebra
  - elliptic curve
  - group theory
  - finite field
  - discrete logarithm
---

# WTF zk 教程第 31 讲：椭圆曲线离散对数问题

椭圆曲线离散对数问题（ECDLP）是椭圆曲线密码学（ECC）的基础。这一讲，我们将将介绍ECDLP的定义和难度。

## 1. 标量乘法

首先，我们要介绍椭圆曲线中的标量乘法，即找到 $Q = kP = P + P + ... + P$ （k个P相加），其中 $k$ 是一个整数，$P$ 是椭圆曲线上的一个点。这个运算是通过不断地将点 $P$ 加到自身来实现的。

举个例子，给定有限域上的椭圆曲线 $y^2 = x^3 - x + 1 \mod 13$ 和曲线上的点 $P(0, 1)$，求 $Q = 3P = P + P + P$。

首先，我们先利用倍点公式计算 $2P = (x_2, y_2)$，斜率为 $\lambda = \frac{3 \cdot 0^2 - 1 }{2 \cdot 1} = -1\cdot 7 = 6 \mod 13$，横坐标 $x_2 = \lambda^2 - 2x = 36- 2 \cdot 0 = 10 \mod 13$，纵坐标 $y_2 = \lambda(x - x_2) - y = 6 \cdot (0 - 10) - 1 = 4 \mod 13$，因此 $2P = (10, 4)$。

接下来，我们利用点加公式计算 $3P = (x_3, y_3) = 2P + P$，斜率 $\lambda = \frac{y_2 - y}{x_2 - x} = \frac{4 - 1}{10 - 0} = 3 \cdot 4 = 12 \mod 13$，横坐标 $x_3 =  \lambda^2 - x - x_2 = 144 - 0 - 10 = 4 \mod 13$，纵坐标 $y_3 = \lambda(x - x_3) - y = 12 (0-4) - 1 = 3 \mod 13$。因此，我们得到最终结果 $3P = (4,3)$。


### 1.1 Double-And-Add算法

Double-And-Add是实现标量乘法的一个高效算法。它通过将 $k$ 表示为二进制形式，然后应用倍加和点加运算来减少所需的加法次数，快速计算 $Q = nP$。

比如我们计算 $9P$ 时，先将 9 转换为二进制 1001，也就是说：

$$
9P = 1 \cdot 8P + 0 \cdot 4P + 0 \cdot 2P + 1 \cdot P
$$
 
然后，我们分别计算 $2P = P + P$， $4P = 2P + 2P$， $8P = 4P + 4P$，然后再计算 $9P = 8P + 1P$ 即可。

使用Double-And-Add算法，可以把原先需要 n 步的计算减少到 $2\log{n}$ 步，非常高效。

### 1.2 代码实现

下面，我们用python实现Double-And-Add算法。给定有限域上的椭圆曲线 $y^2 = x^3 - x + 1 \mod 13$ 和曲线上的点 $P(0, 1)$，求 $Q = 9P$，计算结果为 $(7,8)$。

```python
from sympy import mod_inverse

# 重新定义椭圆曲线参数和点P
p = 13
a = -1
b = 1
P = (0, 1)

# 定义椭圆曲线上的点加法和点翻倍操作
# 定义加法运算
def elliptic_curve_addition(P, Q, a, p):
    if P == ('inf', 'inf'):
        return Q
    if Q == ('inf', 'inf'):
        return P
    if P[0] == Q[0] and (P[1] != Q[1] or P[1] == 0):
        # P + Q = O (无穷远点) 如果它们是垂直对称的点或P是切点
        return ('inf', 'inf')
    if P == Q:
        # 点翻倍
        lambda_ = (3 * P[0]**2 + a) * mod_inverse(2 * P[1], p) % p
    else:
        # 点加法
        lambda_ = (Q[1] - P[1]) * mod_inverse(Q[0] - P[0], p) % p

    x3 = (lambda_**2 - P[0] - Q[0]) % p
    y3 = (lambda_ * (P[0] - x3) - P[1]) % p

    return (x3, y3)

def ecc_double_and_add(P, k, a, p):
    """Double-And-Add algorithm for scalar multiplication on elliptic curves."""
    result = ('inf', 'inf')  # 无穷远点
    addend = P

    while k:
        if k & 1:
            result = elliptic_curve_addition(result, addend, a, p)
        addend = elliptic_curve_addition(addend, addend, a, p)
        k >>= 1
    return result

# 测试Double-And-Add算法
# 选择一个标量k = 9进行标量乘法测试
k = 9
result = ecc_double_and_add(P, k, a, p)

result
# (7, 8)
```

## 2. 椭圆曲线离散对数问题（ECDLP）

之前我们学习过离散对数问题（DLP）：对于乘法群 $\mathbb{F}^*_p$，给定生成元 $g$ 和整数 $a$，找到离散对数 $x$ 使得 $a \equiv g^x \pmod{n}$ 成立。这个问题在计算上是困难的。

现在，我们可以把这个难题搬到椭圆曲线上，它就变成了椭圆曲线离散对数问题（ECDLP）：对于有限域 $\mathbb{F}_p$ 上的椭圆曲线点群 $E(\mathbb{F}_p)$，给定椭圆曲线上的点 $P$ 和 $Q$，找到使得 $Q = kP$ 成立的离散对数 $k = \log_P{Q}$。这个问题在计算上也是困难的。因为虽然在椭圆曲线上的运算是加法，但它非常复杂，包含多个模运算中的加法和乘法，因此，ECDLP甚至比DLP更加困难。

举个例子，对于椭圆曲线 $y^2 = x^3 - x + 1 \mod 13$ 和曲线上的点 $P(0, 1)$，使用Double-And-Add算法计算 $Q = 9P$ 很容易，等于 $(7, 8)$；但是给定 $P(0,1)$ 和 $Q(7, 8)$，求解离散对数 $k = \log_P{Q}$，却很困难，没有高效的算法。

### 2.1 性质

下面，我们介绍一些椭圆曲线离散对数的性质，以椭圆曲线 $y^2 = x^3 - x + 1 \mod 13$ 和曲线上的点 $P(0, 1)$ 为例。

**性质1. 点的阶（order）** 对于椭圆曲线中的点 $P$，满足 $sP = O$ 的最小正整数 $s$ 为点 $P$ 的阶。

举个例子，点 $P(0, 1)$ 的阶为 19，因为 $19P = 0$，且它是满足 $sP = O$ 的最小正整数。

**性质2. 周期性** 椭圆曲线中的点 $P$ 的阶为 $s$，若 $Q = kP$ 成立，那么 $Q = (k + ns)P$ 也成立，其中 $n$ 为任意整数。这也意味着离散对数 $\log_P{Q}$ 是 $\mathbb{Z}/s\mathbb{Z}$ 中的元素，以 $s$ 为周期。

例如， $3P = (4,3)$，那么 $22P = (4,3)$ 和 $41P = (4,3)$ 也成立。

**性质3. 加法同态** 椭圆曲线 $E(\mathbb{F}_p)$ 中的点 $P, Q_1, Q_2$，满足

$$
\log_P{Q_1 + Q_2} = \log_P{Q_1} + \log_P{Q_2}
$$

。这也意味着椭圆曲线离散对数映射 $n = \log_P{Q}$ 是从椭圆曲线 $E(\mathbb{F}_p)$ 到 $\mathbb{Z}/s\mathbb{Z}$ 的群同态。


## 3. ECDLP的难度

解决ECDLP的算法复杂度通常是指数级的，目前最有效的算法复杂度也仅为指数级 $O(\sqrt{p})$。这意味着，尽管存在算法可以解决ECDLP，但它们在实践中并不可行，因为随着椭圆曲线参数的增长，所需的时间将会急剧增加。

相比之下，传统的离散对数（DLP）要简单一些，存在复杂度次指数级的算法解决它，比如[Index Calculus算法](https://en.wikipedia.org/wiki/Index_calculus_algorithm)。因此，当模数 $p$ 相同时，解决ECDLP的难度要比DLP高得多，因此私钥长度相同时，基于ECDLP的加密算法也更难破解，安全程度更高。

下表中给出了相同安全级别下，DLP和ECDLP需要的私钥长度。可以看到，ECDLP仅需要1/10的私钥长度，就可以达到与传统DLP相同的安全性，这也是为什么椭圆曲线被区块链和零知识证明广泛采用。

![](./31-1.png)

但是要注意，不是每条椭圆曲线的离散对数问题都是难解的，大家应该使用经过实战检验的椭圆曲线，比如 secp256k1，alt_bn128，和 bls12_381，而不是自己发明新的。

## 4. 常用椭圆曲线

比特币主要使用了一条椭圆曲线，称为 `secp256k1`。这条曲线定义在一个有限域上，并由SECG（Standards for Efficient Cryptography Group）标准化。`secp256k1`曲线的选择是基于其特定的数学属性，这些属性使得基于该曲线的加密算法既安全又高效。

`secp256k1` 曲线的方程是：

$$
y^2 = x^3 + 7 \mod p
$$

它定义在一个特别选择的有限域 $\mathbb{F}_p$ 上，其中 $p$ 是一个非常大的质数： $p = 2^{256} - 2^{32} - 977$。

比特币的密钥生成、签名和验证过程都依赖于 `secp256k1` 椭圆曲线上的点运算。私钥是一个随机选取的整数，公钥是私钥与曲线上的一个固定基点的标量乘积。交易的签名过程使用了ECDSA（Elliptic Curve Digital Signature Algorithm），该算法同样基于`secp256k1`曲线。

以太坊主要使用了3条椭圆曲线：`secp256k1`，`alt_bn128`，和`bls12_381`，我们会在之后的教程介绍后两条曲线。

在python中，我们可以使用 `py_ecc` 库中的 `secp256k1` 模块来执行椭圆曲线上的基本操作。下面的代码中，我们使用 `secp256k1` 模块，根据给定的私钥计算对应的公钥。这个过程与比特币中从私钥生成公钥的方法本质上是一样的。

```python
# 椭圆曲线 secp256k1 示例
# 利用标量乘法，从私钥生成公钥
from py_ecc.secp256k1 import secp256k1

def generate_public_key(private_key):
    """
    使用secp256k1椭圆曲线，根据给定的私钥生成公钥。
    
    参数:
    private_key (int): 私钥，一个大整数。
    
    返回:
    (int, int): 公钥，椭圆曲线上的点。
    """
    # secp256k1的基点
    G = secp256k1.G
    
    # 计算公钥
    public_key = secp256k1.multiply(G, private_key)
    
    return public_key

# 示例：使用一个随机的私钥
private_key = 123456789  # 在实际应用中，私钥应该是随机生成的大整数，比如 private_key = int(os.urandom(32).hex(), 16)

# 生成公钥
public_key = generate_public_key(private_key)

# 打印结果
print(f"Private Key: {private_key}")
print(f"Public Key: {public_key}")

# 输出
# Private Key: 123456789
# Public Key: (4051293998585674784991639592782214972820158391371785981004352359465450369227, 88166831356626186178414913298033275054086243781277878360288998796587140930350)
```

## 5. 总结

这一讲，我们介绍了椭圆曲线离散对数问题（ECDLP），它可以在同等私钥长度的情况下，提供10倍于传统DLP的安全性，被区块链和零知识证明广泛采用。我们还介绍了比特币和以太坊区块链使用的`secp256k1`曲线，并复现了私钥生成公钥的过程。
