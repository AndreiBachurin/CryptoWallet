//SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.9;

//import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract SharedWallet is Ownable {
    struct Info {
        string name;
        uint limit;
        bool isAdmin;
    }
    mapping(address => Info) public members;

    function addLimit(address _member, string memory _name, uint _limit, bool _isAdmin) public onlyOwner {
        members[_member].name = _name;
        members[_member].limit = _limit;
        members[_member].isAdmin = _isAdmin;
    }

    function deleteMember(address _member) public onlyOwner {
        delete members[_member];
    }

    function isOwner() internal view returns(bool) {
        return owner() == _msgSender();
    }

    modifier OwnerOrAdminOrWithinLimits(uint _amount) {
        require(isOwner() || members[msg.sender].isAdmin || members[msg.sender].limit >= _amount, "You are not allowed to perform this operation!");
        _;
    }

    function deduceLimit(address _member, uint _amount) internal {
        members[_member].limit -= _amount;
    }

    function renounceOwnership() override public view onlyOwner {
        revert("You can not do it!");
    }

    function makeAdmin(address _member) public onlyOwner {
        members[_member].isAdmin = true;
    }

    function revokeAdmin(address _member) public onlyOwner {
        members[_member].isAdmin = false;
    }

}