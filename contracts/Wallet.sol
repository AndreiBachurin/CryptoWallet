//SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.9;

import "./SharedWallet.sol";

contract Wallet is SharedWallet {

    event MoneyWithDrawn(address indexed _to, uint _amount);
    event MoneyReceived(address indexed _from, uint _amount);
    event LimitChanged(address indexed _current, uint _oldLimit, uint _newLimit);

    function sentToContract() public payable {
        payable(this).transfer(msg.value);
        emit MoneyReceived(_msgSender(), msg.value);
    }

    function getBalance() public view returns(uint) {
        return address(this).balance;
    }

    function withdrawMoney(uint _amount) public OwnerOrAdminOrWithinLimits(_amount) {
        require(_amount <=address(this).balance, "Not enough funds to withdraw!");
        address payable _to = payable(_msgSender());
        _to.transfer(_amount);
        if(!isOwner() && !members[_msgSender()].isAdmin) {
            emit LimitChanged(_msgSender(), members[_msgSender()].limit, members[_msgSender()].limit - _amount);
            deduceLimit(_msgSender(), _amount);
        }
        emit MoneyWithDrawn(_to, _amount);
    } 

    fallback() external payable {}

    receive() external payable {
        emit MoneyReceived(_msgSender(), msg.value);
    }
}