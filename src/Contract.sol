// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

contract SimpleBank {
    mapping(address => uint256) balances;
    mapping(address => uint256) borrowed;

    event Deposit(address indexed from, uint256 amount);
    event Withdrawal(address indexed from, uint256 amount);
    event Borrowed(address indexed borrower, uint256 amount);


    function deposit() public payable {
        require(
            msg.value > 0,
            "Requested deposit amount should be greater than zero."
        );
        balances[msg.sender] += msg.value;
        emit Deposit(msg.sender, msg.value);
    }

    function withdraw(uint256 amount) public {
        require(
            amount > 0 && amount <= balances[msg.sender],
            "Requested withdrawal amount should be a positive number and lesser than or equal to available balance."
        );
        balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
        emit Withdrawal(msg.sender, amount);
    }

    function borrow(uint256 amount) external {
        require(
            amount > 0,
            "Requested deposit amount should be greater than zero."
        );
        payable(msg.sender).transfer(amount);
        borrowed[msg.sender] += amount;

        emit Borrowed(msg.sender, amount);
    }

    function payMyDebt() external payable {
        borrowed[msg.sender] -= msg.value;
    }
}
