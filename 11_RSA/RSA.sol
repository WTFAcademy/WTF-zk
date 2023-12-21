// SPDX-License-Identifier: MIT
// by 0xAA
pragma solidity ^0.8.0;

contract RSA {
    // 模数幂运算的预编译合约地址为 0x05，详情: https://www.evm.codes/precompiled#0x05?fork=shanghai

    // 使用公钥加密
    function encrypt(uint message, uint e, uint n) public returns (uint) {
        // RSA加密: cipher = message^e mod n
        return modExp(message, e, n);
    }

    // 使用私钥解密
    function decrypt(uint cipher, uint d, uint n) public returns (uint) {
        // RSA解密: message = cipher^d mod n
        return modExp(cipher, d, n);
    }

    function modExp(uint256 base, uint256 exponent, uint256 modulus) public returns (uint256 result) {
        assembly {
            // Free memory pointer
            let pointer := mload(0x40)

            // 长度 base, exponent and modulus. 0x20 == 32 bytes
            mstore(pointer, 0x20)
            mstore(add(pointer, 0x20), 0x20)
            mstore(add(pointer, 0x40), 0x20)

            // 定义变量 base, exponent and modulus
            mstore(add(pointer, 0x60), base)
            mstore(add(pointer, 0x80), exponent)
            mstore(add(pointer, 0xa0), modulus)

            // 保存结果
            let value := mload(0xc0)

            // 调用预编译合约 0x05 = bigModExp
            if iszero(call(not(0), 0x05, 0, pointer, 0xc0, value, 0x20)) {
                revert(0, 0)
            }

            // 返回结果
            result := mload(value)
        }
    }
}