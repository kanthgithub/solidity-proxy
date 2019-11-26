const arithmeticProxy = artifacts.require('ArithmeticProxy');

module.exports = function(deployer, networks, accounts) {
    const constructorData = '0xefc3b5db0000000000000000000000000000000000000000000000000000000000000020000000000000000000000000000000000000000000000000000000000000000f41726974686d657469634c6f6769630000000000000000000000000000000000';
    const arithmeticAddress = '0x119c610999aFCAFc7d68c6c358923c290eF57e39';
    console.log('about to deploy proxy with constructor data: '+constructorData);
    deployer.deploy(arithmeticProxy, constructorData, arithmeticAddress).then(async resp =>
        function(resp,error) { 
            if(!error){  console.log('inside proxy dep'); return resp;  }
  }).catch(err => console.log(err.message));
};

//0x67f66ba0080439d225FF55465AD64ba48Ea7E23E
//0xefc3b5db0000000000000000000000000000000000000000000000000000000000000020000000000000000000000000000000000000000000000000000000000000000f41726974686d657469634c6f6769630000000000000000000000000000000000
