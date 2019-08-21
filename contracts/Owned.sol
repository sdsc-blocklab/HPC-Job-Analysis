pragma solidity ^0.5.2;

contract Owned {
    address owner;
    mapping(address=>bool) allowedUsers;
   constructor() public {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner,"User is not owner");
        _;
    }

    function whitelistAddress (address user) public onlyOwner {
        allowedUsers[user]=true;
    }

    modifier onlyusers() {
        require(allowedUsers[msg.sender],"User has no priveleges");
        _;
    }

    function accessbyonlyusers () public onlyusers {
        //Use this function to other sensitive functions?
    }
}