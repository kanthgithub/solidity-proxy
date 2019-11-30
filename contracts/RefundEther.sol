pragma solidity ^0.5.1;

contract RefundEther {

     string public name;

     function launch(string memory  _name) public {
        name = _name;
    }

    function loopbackEther() public payable {
       msg.sender.transfer(msg.value);
    }
}
