// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract Saver {
    string public note;
    address public owner;
    event NoteUpdated(address indexed who, string note);

    constructor(string memory _note) {
        owner = msg.sender;
        note = _note;
    }

    function setNote(string calldata _note) external {
        note = _note;
        emit NoteUpdated(msg.sender, _note);
    }

    function getNote() external view returns (string memory) {
        return note;
    }
}
