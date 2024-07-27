// SPDX-License-Identifier: MIT

pragma solidity 0.8.20;

interface IBalanceOracle {
    function updateUserBalance(
        address _account,
        uint256 _stakedAmount,
        uint256 _value,
        uint256 _deadline,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external;
}