const proxyV2 = artifacts.require('ProxyV2');

module.exports = function(deployer, networks, accounts) {
    const arithmeticConstructorData = '0xefc3b5db0000000000000000000000000000000000000000000000000000000000000020000000000000000000000000000000000000000000000000000000000000000f41726974686d657469634c6f6769630000000000000000000000000000000000';
    const arithmeticAddress = '0x246D996aA462b9ef1e2971c1105eE8cDdf24C123';
    const refundEtherConstructorData = '0xefc3b5db0000000000000000000000000000000000000000000000000000000000000020000000000000000000000000000000000000000000000000000000000000000b526566756e644574686572000000000000000000000000000000000000000000';
    const refundEtherAddress = '0xcE2E971a77df1BCBA1EA82d7e517Db78aE0EAA38';

    console.log('about to deploy proxy with arithmeticConstructorData: '+arithmeticConstructorData);
        console.log('about to deploy proxy with arithmeticAddress: '+arithmeticAddress);

    console.log('about to deploy proxy with refundEtherConstructorData: '+refundEtherConstructorData);

    console.log('about to deploy proxy with refundEtherAddress: '+refundEtherAddress);

    deployer.deploy(proxyV2, arithmeticConstructorData, arithmeticAddress,refundEtherConstructorData,refundEtherAddress).then(async resp =>
        function(resp,error) { 
            if(!error){  console.log('inside proxy dep'); return resp;  }
  }).catch(err => console.log(err.message));
};

//0x1dAA8F71BE68f519219F0A88cB0c42E68629D9C1
// account:             0x368F5CcbDA115C3E865b23F2bE06Cc7f1B1e2221