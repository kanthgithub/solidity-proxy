const arithmetic = artifacts.require('Arithmetic');
const arithmeticProxy = artifacts.require('ArithmeticProxy');

module.exports = function(deployer, networks, accounts) {
  // Deploy ShipA and use this to deploy our Proxy
  deployer.deploy(arithmetic).then(a => {
    console.log('arithmetic contract is deployed : '+a.address);
    let con = new web3.eth.Contract(a.abi, a.address, { address: a.address });
    const constructorData = con.methods.launch('ArithmeticLogic').encodeABI();
    console.log('about to deploy proxy with constructor data: '+constructorData);
    deployer.deploy(arithmeticProxy, constructorData, a.address).then( res => console.log('Proxy deployed at: '+res.address))
                                            .catch(err => console.log(err.message))
    });
};