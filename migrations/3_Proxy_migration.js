const arithmeticProxy = artifacts.require('ArithmeticProxy');

module.exports = function(deployer, networks, accounts) {
    const constructorData = '0xefc3b5db0000000000000000000000000000000000000000000000000000000000000020000000000000000000000000000000000000000000000000000000000000000f41726974686d657469634c6f6769630000000000000000000000000000000000';
    const arithmeticAddress = '0x7afC4a32D742d133344C6f034960065b2B16B0D8';
    console.log('about to deploy proxy with constructor data: '+constructorData);
    deployer.deploy(arithmeticProxy, constructorData, arithmeticAddress).then(async resp =>
        function(resp,error) { 
            if(!error){  console.log('inside proxy dep'); return resp;  }
  }).catch(err => console.log(err.message));
};
//0xc6359d8264Aa14B32F3c420eF29A016e971653bA