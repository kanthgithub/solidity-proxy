const addnumbersproxy = artifacts.require("./addnumbersproxy.sol");

module.exports = function(deployer){
    deployer.deploy(addnumbersproxy);
};