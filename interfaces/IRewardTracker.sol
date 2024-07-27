// SPDX-License-Identifier: MIT

pragma solidity 0.8.20;

interface IRewardTracker {
    
    function stakedAmounts(address _account) external view returns (uint256);

    function updateRewards() external;

    function stakeForAccount(
        address _account,
        uint256 _amount
    ) external;

    function unstakeForAccount(
        address _account,
        uint256 _amount
    ) external;

    function tokensPerInterval() external view returns (uint256);

    function claimForAccount(
        address _account
    ) external returns (uint256);

    function claimable(address _account) external view returns (uint256);

    function cumulativeRewards(
        address _account
    ) external view returns (uint256);
}
