// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

contract SimpleBank {
    address payable public owner;
    uint256 public balance;

    event Deposit(address indexed _from, uint256 _value);
    event Withdrawal(address indexed _from, uint256 _value);

    constructor() {
        owner = payable(msg.sender);
    }

    function deposit() public payable {
        require(
            msg.sender == owner,
            "Only owner of the bank account can deposit funds."
        );
        require(
            msg.value > 0,
            "Requested deposit amount should be greater than zero."
        );
        balance += msg.value;
        emit Deposit(msg.sender, msg.value);
    }

    function withdraw(uint256 _value) public {
        require(
            msg.sender == owner,
            "Only owner of the bank account can withdraw funds."
        );
        require(
            _value > 0 && _value <= balance,
            "Requested withdrawal amount should be a positive number and lesser than or equal to available balance."
        );
        balance -= _value;
        owner.transfer(_value);
        emit Withdrawal(msg.sender, _value);
    }
}
