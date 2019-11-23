pragma solidity <0.6.0;

contract addnumbers {

  uint public sum;

  event addEvent(uint indexed sum, uint a, uint b);

  function compute(uint a, uint b) public returns (uint) {
      sum = a + b;
      emit addEvent(sum,a,b);
      return sum;
  }
}