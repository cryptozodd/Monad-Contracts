// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.9.3/contracts/token/ERC721/ERC721.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.9.3/contracts/utils/Counters.sol";

contract Badge is ERC721 {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenId;
    mapping(address => bool) public minted;

    constructor(string memory _name, string memory _symbol) ERC721(_name, _symbol) {}

    function mintBadge() external {
        require(!minted[msg.sender], "already minted");
        _tokenId.increment();
        uint256 id = _tokenId.current();
        _safeMint(msg.sender, id);
        minted[msg.sender] = true;
    }
}