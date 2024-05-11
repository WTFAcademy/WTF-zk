# WTF zk

[English Version](https://github.com/WTFAcademy/WTF-zk/blob/main/Languages/en/README.md)

零知识证明（zero-knowledge proof）入门教程，目的是让仅有高中数学基础的人也能入门zk。我们会使用python复现一些算法，所以你也需要学python。

> 我们最近在学习zero-knowledge proof，巩固一下细节，也写一个“WTF zk极简入门”，供小白们使用（编程大佬可以另找教程），每周更新1-3讲。

## 数学基础

### 第1章 数论入门

**第1讲 整数运算基础**：[Code](./01_Integer/Integer.ipynb) | [教程](./01_Integer/readme.md) 

**第2讲 质数基础**：[Code](./02_Prime/Prime.ipynb) | [教程](./02_Prime/readme.md) 

**第3讲 欧几里得算法**：[Code](./03_Euclidean/Euclidean.ipynb) | [教程](./03_Euclidean/readme.md) 

**第4讲 拓展欧几里得算法**：[Code](./04_EEA/EEA.ipynb) | [教程](./04_EEA/readme.md) 

**第5讲 模运算基础**：[Code](./05_Modular/Modular.ipynb) | [教程](./05_Modular/readme.md) 

**第6讲 模运算除法**：[Code](./06_Division/Division.ipynb) | [教程](./06_Division/readme.md) 

**第7讲 费马小定理**：[Code](./07_Exp/Exp.ipynb) | [教程](./07_Exp/readme.md) 

**第8讲 中国剩余定理**：[Code](./08_Remainder/Remainder.ipynb) | [教程](./08_Remainder/readme.md) 

**第9讲 欧拉函数**：[Code](./09_Unit/Unit.ipynb) | [教程](./09_Unit/readme.md) 

**第10讲 欧拉定理**：[Code](./10_Euler/Euler.ipynb) | [教程](./10_Euler/readme.md) 

**里程碑01 RSA算法** [Code](./MS01_RSA/RSA.ipynb) | [教程](./MS01_RSA/readme.md) | [论文](./papers/RSA_paper.pdf)

### 第2章 抽象代数: 群论

**第11讲 群**： [教程](./11_Group/readme.md) 

**第12讲 子群**： [教程](./12_Subgroup/readme.md) 

**第13讲 陪集和拉格朗日定理**： [教程](./13_Coset/readme.md) 

**第14讲 正规子群和商群**： [教程](./14_Quotient/readme.md) 

**第15讲 同态和同构**： [教程](./15_Homomorphism/readme.md) 

**第16讲 Abel群**： [教程](./16_Abel/readme.md) 

**第17讲 循环群**： [教程](./17_Cyclic/readme.md) 

**第18讲 群的直积**： [教程](./18_DirectProduct/readme.md) 

**第19讲 离散对数问题**： [教程](./19_DLP/readme.md) 

**里程碑02 Diffie-Hellman 密钥交换算法** [Code](./MS02_DH/Difie_Hellman.ipynb) | [教程](./MS02_DH/readme.md) | [论文](./papers/Diffie_Hellman.pdf)

**里程碑03 ElGamal 加密和签名算法** [Code](./MS03_ElGamal/ElGamal.ipynb) | [教程](./MS03_ElGamal/readme.md) | [论文](./papers/ElGamal.pdf)

### 第3章 抽象代数: 环和域

**第20讲 环**： [教程](./20_Ring/readme.md) 

**第21讲 理想和商环**： [教程](./21_Ideal/readme.md) 

**第22讲 环同态和同构**： [教程](./22_RingHomo/readme.md) 

**第23讲 域**： [教程](./23_Field/readme.md) 

**第24讲 多项式基础**： [教程](./24_Polynomial/readme.md) 

**第25讲 多项式环**： [教程](./25_PolyRing/readme.md) 

**第26讲 域扩展**： [教程](./26_FieldExtension/readme.md) 

**第27讲 有限域**： [教程](./27_GaloisField/readme.md) 

**第28讲 二次剩余**： [教程](./28_Quadratic/readme.md) 

**里程碑04 Goldwasser-Micali (GM) 算法** [Code](./MS04_ProbEncryption/GM.ipynb) | [教程](./MS04_ProbEncryption/readme.md) | [论文](./papers/Probabilistic_Encryption.pdf)

**里程碑05 初探零知识证明** [教程](./MS05_zkExample/readme.md) | [论文](./papers/The_Knowledge_Complexity_Of_Interactive_Proof_Systems.pdf)

### 第4章 椭圆曲线

**第29讲 椭圆曲线基础**：[Code](./29_EllipticCurve/EllipticCurve.ipynb) | [教程](./29_EllipticCurve/readme.md) 

**第30讲 有限域上的椭圆曲线**：[Code](./30_FiniteEC/FiniteEC.ipynb) | [教程](./30_FiniteEC/readme.md) 

**第31讲 椭圆曲线离散对数问题**：[Code](./31_ECDLP/ECDLP.ipynb) | [教程](./31_ECDLP/readme.md) 

**第32讲 椭圆曲线密码学**：[Code](./32_ECC/ECC.ipynb) | [教程](./32_ECC/readme.md) 

**第33讲 扩域上的椭圆曲线**：[教程](./33_ECExtension/readme.md) 

**第34讲 双线性配对基础**：[教程](./34_Pairing/readme.md) 

**第35讲 挠群和除子**：[Code](./35_TorsionGroup/TorsionGroup.sage) | [教程](./35_TorsionGroup/readme.md) 

**第36讲 Weil 配对**：[教程](./36_WeilPairing/readme.md) 

**第37讲 Miller 算法**：[Code](./37_MillerAlgo/WeilPairing.sage) | [教程](./37_MillerAlgo/readme.md) 

**第38讲 Tate 配对**：[Code](./38_TatePairing/Ate.ipynb) | [教程](./38_TatePairing/readme.md) 

**第39讲 扩域上的 Weil 配对**：[教程](./39_PairingExtension/readme.md) 

**第40讲 常用椭圆曲线**：[Code](./40_PopularCurves/40_PopularCurves.ipynb) | [教程](./40_PopularCurves/readme.md) 

**里程碑06 哈希函数 Hash** [Code](./MS06_Hash/Hash.ipynb) | [教程](./MS06_Hash/readme.md)

**里程碑07 身份基加密 IBE** [Code](./MS07_IBE/IBE.ipynb) | [教程](./MS07_IBE/readme.md)

## WTF zk贡献者
<div align="center">
  <h4 align="center">
    贡献者是WTF学院的基石
  </h4>
  <a href="https://github.com/WTFAcademy/WTF-zk/graphs/contributors">
    <img src="https://contrib.rocks/image?repo=WTFAcademy/WTF-zk" />
  </a>
</div>

## WTF zk赞助商

![](./img/full_logo_zksync-black.png)

## Reference

1. [Moonmath Manual by LeastAuthority](https://github.com/LeastAuthority/moonmath-manual)

2. [zk-learning MOOC](https://zk-learning.org/)

3. [The RareSkills Book of Zero Knowledge](https://www.rareskills.io/zk-book)

4. [Number Theory Notes](https://crypto.stanford.edu/pbc/notes/numbertheory/)

5. [密码学的数学基础](https://space.bilibili.com/552018206/channel/collectiondetail?sid=436262)

6. [Cryptography 101 for Blockchain Developers by OpenZeppelin](https://www.youtube.com/watch?v=9TFEBuANioo)

7. Vitalik's blogs: [Weil Pairing](https://medium.com/@VitalikButerin/exploring-elliptic-curve-pairings-c73c1864e627)