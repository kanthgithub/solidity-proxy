const refundEther = artifacts.require('RefundEther');

module.exports = function(deployer, networks, accounts) {
  deployer.deploy(refundEther).then(async a => {
    console.log('refundEther contract is deployed : '+a.address);
    let con = new web3.eth.Contract(a.abi, a.address, { address: a.address });
    const refundEtherAddress = a.address;
    console.log('deployed refundEther with address: '+refundEtherAddress);
    const constructorData = con.methods.launch('RefundEther').encodeABI();
    console.log('deployed refundEther with constructor data: '+constructorData);
    });
};
//0xcE2E971a77df1BCBA1EA82d7e517Db78aE0EAA38
//0xefc3b5db0000000000000000000000000000000000000000000000000000000000000020000000000000000000000000000000000000000000000000000000000000000b526566756e644574686572000000000000000000000000000000000000000000
