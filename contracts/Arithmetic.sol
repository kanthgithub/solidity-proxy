pragma solidity ^0.5.1;

contract Arithmetic {

    event addEvent(uint256 indexed sum, uint256 a, uint256 b);
    event substractEvent(uint256 indexed substract, uint256 a, uint256 b);
     string public name;

     function launch(string memory  _name) public {
        name = _name;
    }

    function add(uint256 a, uint256 b) public returns(uint256) {
        uint256 result = a+b;
        emit addEvent(result,a,b);
        return result;
    }

    function substract(uint256 a, uint256 b) public returns(uint256) {
        uint256 result = a-b;
        emit substractEvent(result,a,b);
        return result;
    }

    function loopbackEther() public payable {
       msg.sender.transfer(msg.value);
    }
}
