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
//0x7afC4a32D742d133344C6f034960065b2B16B0D8