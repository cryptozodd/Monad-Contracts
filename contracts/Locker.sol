// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract Locker {
    mapping(address => uint256) public balances;
    mapping(address => uint256) public unlockAt;
    uint256 public defaultLockSeconds;
    event Deposited(address indexed who, uint256 amount, uint256 unlockAt);
    event Withdrawn(address indexed who, uint256 amount);

    constructor(uint256 _defaultLockSeconds) {
        defaultLockSeconds = _defaultLockSeconds;
    }

    function deposit() external payable {
        require(msg.value > 0, "no value");
        balances[msg.sender] += msg.value;
        unlockAt[msg.sender] = block.timestamp + defaultLockSeconds;
        emit Deposited(msg.sender, msg.value, unlockAt[msg.sender]);
    }

    function withdraw(uint256 amount) external {
        require(balances[msg.sender] >= amount, "insufficient balance");
        require(block.timestamp >= unlockAt[msg.sender], "still locked");
        balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
        emit Withdrawn(msg.sender, amount);
    }
}
