// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract Points {
    mapping(address => uint256) public points;
    address public owner;
    event PointsAwarded(address indexed to, uint256 amount);
    event PointsBurned(address indexed from, uint256 amount);
    event PointsTransferred(address indexed from, address indexed to, uint256 amount);

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "only owner");
        _;
    }

    function awardPoints(address to, uint256 amt) external onlyOwner {
        points[to] += amt;
        emit PointsAwarded(to, amt);
    }

    function transferPoints(address to, uint256 amt) external {
        require(points[msg.sender] >= amt, "insufficient points");
        points[msg.sender] -= amt;
        points[to] += amt;
        emit PointsTransferred(msg.sender, to, amt);
    }

    function burn(uint256 amt) external {
        require(points[msg.sender] >= amt, "insufficient points");
        points[msg.sender] -= amt;
        emit PointsBurned(msg.sender, amt);
    }
}
