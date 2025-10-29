// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

// ----------------------------------------------------------------------
// Simple In-Chain Bank (Beginner Example)
// ----------------------------------------------------------------------
// This Solidity contract demonstrates the basic functionality of a 
// decentralized, transparent "bank" system directly on-chain.
//
// Features:
//  - Deposit ETH
//  - Withdraw ETH
//  - Transfer funds between users (internal bookkeeping)
//  - View individual and total balances
//
// IMPORTANT: This is for learning/demo purposes only — not audited.
// ----------------------------------------------------------------------

contract SimpleInChainBank {
    address public owner;
    bool private locked;

    mapping(address => uint256) private balances;

    event Deposit(address indexed account, uint256 amount, uint256 timestamp);
    event Withdraw(address indexed account, uint256 amount, uint256 timestamp);
    event Transfer(address indexed from, address indexed to, uint256 amount, uint256 timestamp);
    event Rescue(address indexed to, uint256 amount, uint256 timestamp);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this");
        _;
    }

    modifier nonReentrant() {
        require(!locked, "Reentrant call detected");
        locked = true;
        _;
        locked = false;
    }

    constructor() {
        owner = msg.sender;
        locked = false;
    }

    // -------------------------------------------------------------
    // Core Banking Functions
    // -------------------------------------------------------------

    /// @notice Deposit ETH into your bank balance
    function deposit() external payable {
        require(msg.value > 0, "Must deposit more than 0");
        balances[msg.sender] += msg.value;
        emit Deposit(msg.sender, msg.value, block.timestamp);
    }

    /// @notice Withdraw ETH from your account balance
    function withdraw(uint256 amount) external nonReentrant {
        require(amount > 0, "Amount must be > 0");
        require(balances[msg.sender] >= amount, "Insufficient balance");

        balances[msg.sender] -= amount;

        (bool success, ) = payable(msg.sender).call{value: amount}("");
        require(success, "Withdraw failed");

        emit Withdraw(msg.sender, amount, block.timestamp);
    }

    /// @notice Transfer your balance to another user inside the bank
    function transferTo(address to, uint256 amount) external nonReentrant {
        require(to != address(0), "Invalid recipient");
        require(amount > 0, "Amount must be > 0");
        require(balances[msg.sender] >= amount, "Insufficient balance");

        balances[msg.sender] -= amount;
        balances[to] += amount;

        emit Transfer(msg.sender, to, amount, block.timestamp);
    }

    // -------------------------------------------------------------
    // View Functions
    // -------------------------------------------------------------

    function getBalance(address account) external view returns (uint256) {
        return balances[account];
    }

    function myBalance() external view returns (uint256) {
        return balances[msg.sender];
    }

    function getTotalBankBalance() external view returns (uint256) {
        return address(this).balance;
    }

    // -------------------------------------------------------------
    // Owner (admin) Utilities — use with caution
    // -------------------------------------------------------------

    function rescueEther(address payable to, uint256 amount)
        external
        onlyOwner
        nonReentrant
    {
        require(to != address(0), "Invalid address");
        require(amount <= address(this).balance, "Not enough balance in contract");

        (bool success, ) = to.call{value: amount}("");
        require(success, "Rescue failed");

        emit Rescue(to, amount, block.timestamp);
    }

    function changeOwner(address newOwner) external onlyOwner {
        require(newOwner != address(0), "Invalid address");
        owner = newOwner;
    }

    // -------------------------------------------------------------
    // Receive and Fallback
    // -------------------------------------------------------------

    receive() external payable {
        require(msg.value > 0, "Must send ETH > 0");
        balances[msg.sender] += msg.value;
        emit Deposit(msg.sender, msg.value, block.timestamp);
    }

    fallback() external payable {
        revert("Invalid function call");
    }
}
