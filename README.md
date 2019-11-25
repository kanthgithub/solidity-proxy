# Proxy contract for LogicContract:

## How to Deploy:
- Step-1: Deploy LogicContract i.e Arithmetic.sol
- Step-2: Take note of the deployed Arithmetic contract, abi  and it's constructor-Data
          (Deployment script 2_Arithmetic_migration.js has the logging)
- Step-3: migration script 3_Proxy_migration.js has the script to deploy proxy contract - ArithmeticProxy.sol
  - Arguments to be supplied for ArithmeticProxy deployment are the values:
     1. constructorData (con.methods.launch('ArithmeticLogic').encodeABI();)
     2. address of deployed Arithmetic.sol
 
## How to Run:
<b>Example:</b>
<ol>
1. Arithmetic: upgradeable Contract
2. ArithmeticProxy: ProxyContract
</ol>

- Step-1: Load Proxy with ABI of Arithmetic and at Address of ArithmeticProxy:

```js
let arithProxy = new web3.eth.Contract(Arithmetic.abi, ArithmeticProxy.address, {address:ArithmeticProxy.address});
```

- Step-2: call the arithmetic method add on arithProxy loaded in step-1:

```js
var result = arithProxy.methods.add(1100,12).call();
```

- Step-3: To print result, just re-type result in console

## Summary:

- Deploy Upgradeable contract
- Deploy Proxy contract with constructor arguments: 
    - constructorData of Upgradeable contract
    - address of Upgradeable Contract

## How to call a function of an Upgradeable contract via Proxy-Contract:

https://ethereum.stackexchange.com/questions/52721/truffle-react-with-proxy-contract-of-openzeppelin/61361

```
You should call you contract as usual using web3, but swapping contract address with proxy address. 

What I understood is that one should send a transaction at Proxy contract (configured with the latest version of the contract) sending as msg.data the method of the upgradable contract that I want to execute.
```
