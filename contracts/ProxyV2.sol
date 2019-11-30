pragma solidity ^0.5.1;

contract ProxyV2{

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
        // save the code address
        assembly { // solium-disable-line
            sstore(0xc5f16f0fcc639fa48a6947836d9850f504798523bf8c9a3a87d5876cf622bcf7, contractLogic)
        }
        (bool success, /* bytes memory _*/ ) = contractLogic.delegatecall(constructData); // solium-disable-line
        require(success, "Construction failed");
    }

        function updateContractLogic2(bytes memory constructData, address contractLogic) public {
        // save the code address
        assembly { // solium-disable-line
            sstore(0x999802572af9bd298e7e25fe3959ac083d4486b31ed6b1314afdaea9eb9e0def, contractLogic)
        }
        (bool success, /* bytes memory _*/ ) = contractLogic.delegatecall(constructData); // solium-disable-line
        require(success, "Construction failed");
    }

    function arithmetic() external payable {
        assembly { // solium-disable-line
            let contractLogic := sload(0xc5f16f0fcc639fa48a6947836d9850f504798523bf8c9a3a87d5876cf622bcf7)
            calldatacopy(0x0, 0x0, calldatasize)
            let success := delegatecall(sub(gas, 10000), contractLogic, 0x0, calldatasize, 0, 0)
            let retSz := returndatasize
            returndatacopy(0, 0, retSz)
            switch success
            case 0 {
                revert(0, retSz)
            }
            default {
                return(0, retSz)
            }
        }
    }

    function refund() external payable {
        assembly { // solium-disable-line
            let contractLogic := sload(0x999802572af9bd298e7e25fe3959ac083d4486b31ed6b1314afdaea9eb9e0def)
            calldatacopy(0x0, 0x0, calldatasize)
            let success := delegatecall(sub(gas, 10000), contractLogic, 0x0, calldatasize, 0, 0)
            let retSz := returndatasize
            returndatacopy(0, 0, retSz)
            switch success
            case 0 {
                revert(0, retSz)
            }
            default {
                return(0, retSz)
            }
        }
    }
}
