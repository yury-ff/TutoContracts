// SPDX-License-Identifier: MIT

pragma solidity 0.8.20;

import {IBalancePermit} from "../interfaces/IBalancePermit.sol";
import {ECDSA} from "./ECDSA.sol";
import {EIP712} from "./EIP712.sol";
import {Nonces} from "./Nonces.sol";

abstract contract BalancePermit is IBalancePermit, EIP712, Nonces {
    bytes32 private constant PERMIT_TYPEHASH =
        keccak256("Permit(address owner,uint256 stakedAmount,uint256 value,uint256 nonce,uint256 deadline)");

 
    error ERC2612ExpiredSignature(uint256 deadline);

  
    error ERC2612InvalidSigner(address signer, address owner);

 
    constructor(string memory name) EIP712(name, "1") {}


    function withdrawalPermit(
        address owner,
        uint256 stakedAmount,
        uint256 value,
        uint256 deadline,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) public virtual {
        if (block.timestamp > deadline) {
            revert ERC2612ExpiredSignature(deadline);
        }

        bytes32 structHash = keccak256(abi.encode(PERMIT_TYPEHASH, owner, stakedAmount, value, _useNonce(owner), deadline));

        bytes32 hash = _hashTypedDataV4(structHash);

        address signer = ECDSA.recover(hash, v, r, s);
        if (signer != owner) {
            revert ERC2612InvalidSigner(signer, owner);
        }

    }


    function nonces(address owner) public view virtual override(IBalancePermit, Nonces) returns (uint256) {
        return super.nonces(owner);
    }

   
    function DOMAIN_SEPARATOR() external view virtual returns (bytes32) {
        return _domainSeparatorV4();
    }
}