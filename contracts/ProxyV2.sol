pragma solidity ^0.5.1;

contract ProxyV2{

    address owner = msg.sender;

    // Code position in storage is keccak256("PROXIABLE") = "0xc5f16f0fcc639fa48a6947836d9850f504798523bf8c9a3a87d5876cf622bcf7"
    // Code position in storage is keccak256("PROXIABLEV2") = "0x999802572af9bd298e7e25fe3959ac083d4486b31ed6b1314afdaea9eb9e0def"
    constructor(bytes memory constructData1, address contractLogic1,bytes memory constructData2, address contractLogic2) public {
        // save the code address
        assembly { // solium-disable-line
            sstore(0xc5f16f0fcc639fa48a6947836d9850f504798523bf8c9a3a87d5876cf622bcf7, contractLogic1)
        }
         assembly { // solium-disable-line
            sstore(0x999802572af9bd298e7e25fe3959ac083d4486b31ed6b1314afdaea9eb9e0def, contractLogic2)
        }
        (bool success1, /* bytes memory _*/ ) = contractLogic1.delegatecall(constructData1); // solium-disable-line
        (bool success2, /* bytes memory _*/ ) = contractLogic2.delegatecall(constructData2); // solium-disable-line
        require(success1, "Construction failed");
        require(success2, "Construction failed");
    }

    function updateContractLogic1(bytes memory constructData, address contractLogic) public {
        require(msg.sender == owner,'only owner can update contract logic');
        // save the code address
        assembly { // solium-disable-line
            sstore(0xc5f16f0fcc639fa48a6947836d9850f504798523bf8c9a3a87d5876cf622bcf7, contractLogic)
        }
        (bool success, /* bytes memory _*/ ) = contractLogic.delegatecall(constructData); // solium-disable-line
        require(success, "Construction failed");
    }

        function updateContractLogic2(bytes memory constructData, address contractLogic) public {
        require(msg.sender == owner,'only owner can update contract logic');
        // save the code address
        assembly { // solium-disable-line
            sstore(0x999802572af9bd298e7e25fe3959ac083d4486b31ed6b1314afdaea9eb9e0def, contractLogic)
        }
        (bool success, /* bytes memory _*/ ) = contractLogic.delegatecall(constructData); // solium-disable-line
        require(success, "Construction failed");
    }

    function execute(bytes32 contractName, bytes32 functionName, bytes calldata data) external payable {
        bytes4 functionHash = 0;

        assembly { // solium-disable-line
            let contractLogic := 0
            switch contractName
                case "Arithmetic"  {
                    contractLogic := sload(0xc5f16f0fcc639fa48a6947836d9850f504798523bf8c9a3a87d5876cf622bcf7)
                     switch functionName
                            case "add"  {
                                functionHash := keccak256("add(uint256,uint256)",4)
                            }
                            case "substract"  {
                                functionHash := keccak256("substract(uint256,uint256)",4)
                            }
                            default  {
                               functionHash := keccak256("add(uint256,uint256)",4)
                            }
                }

                 case "RefundEther"  {
                    contractLogic := sload(0x999802572af9bd298e7e25fe3959ac083d4486b31ed6b1314afdaea9eb9e0def)
                     switch functionName
                             case "loopbackEther" {
                                functionHash := keccak256("loopbackEther()",4)
                            }
                           default {
                                functionHash := keccak256("loopbackEther()",4)
                            }
                 }

                default {
                    contractLogic := sload(0x999802572af9bd298e7e25fe3959ac083d4486b31ed6b1314afdaea9eb9e0def)
                        switch functionName
                            case "loopbackEther" {
                                functionHash := keccak256("loopbackEther()",4)
                            }
                           default {
                                functionHash := keccak256("loopbackEther()",4)
                            }
                }
            calldatacopy(0x0, 0x0, calldatasize)

            let functionHashPointer := mload(0x40) // find empty storage location using "free memory pointer"
            mstore(functionHashPointer,functionHash) // attach function signature
            //let success := delegatecall(sub(gas, 10000), contractLogic, 0x0, calldatasize, 0, 0)
            let status := delegatecall(sub(gas, 10000), contractLogic, add(functionHashPointer, 0x04), 0, functionHashPointer, 0x20)
            //let result := delegatecall(sub(gas, 10000), contractLogic, add(functionHash, 0x20), mload(functionHash), 0, 0)
            let retSz := returndatasize
            returndatacopy(0, 0, retSz)
            switch status
            case 0 {
                revert(0, retSz)
            }
            default {
                return(0, retSz)
            }
        }
    }
}