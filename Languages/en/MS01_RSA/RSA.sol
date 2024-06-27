// SPDX-License-Identifier: MIT
// by 0xAA
pragma solidity ^0.8.0;

contract RSA {
    // precompile address for ModExp is 0x05, detail: https://www.evm.codes/precompiled#0x05?fork=shanghai

    // encryption
    function encrypt(uint message, uint e, uint n) public returns (uint) {
        // RSA encryption: cipher = message^e mod n
        return modExp(message, e, n);
    }

    // decryption
    function decrypt(uint cipher, uint d, uint n) public returns (uint) {
        // RSA decryption: message = cipher^d mod n
        return modExp(cipher, d, n);
    }

    function modExp(uint256 base, uint256 exponent, uint256 modulus) public returns (uint256 result) {
        assembly {
            // Free memory pointer
            let pointer := mload(0x40)

            // length of base, exponent and modulus. 0x20 == 32 bytes
            mstore(pointer, 0x20)
            mstore(add(pointer, 0x20), 0x20)
            mstore(add(pointer, 0x40), 0x20)

            // define variables base, exponent and modulus
            mstore(add(pointer, 0x60), base)
            mstore(add(pointer, 0x80), exponent)
            mstore(add(pointer, 0xa0), modulus)

            // save the result
            let value := mload(0xc0)

            // Use precompile 0x05 = bigModExp
            if iszero(call(not(0), 0x05, 0, pointer, 0xc0, value, 0x20)) {
                revert(0, 0)
            }

            // return result
            result := mload(value)
        }
    }
}