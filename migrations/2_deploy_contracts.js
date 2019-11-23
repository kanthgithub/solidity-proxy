const addnumbers = artifacts.require("./addnumbers.sol");

module.exports = function(deployer){
    deployer.deploy(addnumbers);
};