const arithmetic = artifacts.require('Arithmetic');
const arithmeticProxy = artifacts.require('ArithmeticProxy');

module.exports = function(deployer, networks, accounts) {
  // Deploy ShipA and use this to deploy our Proxy
  deployer.deploy(arithmetic).then(async a => {
    console.log('arithmetic contract is deployed : '+a.address);
    let con = new web3.eth.Contract(a.abi, a.address, { address: a.address });
    const arithmeticAddress = a.address;
    console.log('deployed Arithmetic with address: '+arithmeticAddress);
    const constructorData = con.methods.launch('ArithmeticLogic').encodeABI();
    console.log('deployed Arithmetic with constructor data: '+constructorData);
    });
};
//0x119c610999aFCAFc7d68c6c358923c290eF57e39
//0xefc3b5db0000000000000000000000000000000000000000000000000000000000000020000000000000000000000000000000000000000000000000000000000000000f41726974686d657469634c6f6769630000000000000000000000000000000000
