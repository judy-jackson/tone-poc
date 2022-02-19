var Web3 = require('web3');
var solc = require('solc');
var fs = require('fs');

const args = process.argv.slice(2);
var wallet = args[0];
var contractSourceFile = args[1]
var contractName = args[2]

// connect to the Ganache node
var web3 = new Web3(new Web3.providers.HttpProvider('http://127.0.0.1:8545'));
// read Solidity source code
var sourceCode = fs.readFileSync(contractSourceFile, 'utf-8').toString()
// prepare compiler input JSON
var compilerInput = {
  language: 'Solidity',
  sources: {
    contract: {
      content: sourceCode
    }
  },
  settings: {
    outputSelection: {
      '*': {
        '*': ['*']
      }
    }
  }
}
// compile and get output JSON
var compiled = solc.compile(JSON.stringify(compilerInput))
var compilerOutput = JSON.parse(compiled)
console.log(compilerOutput.contracts.toString());
// extract ABI and EVM from output
var contract = compilerOutput.contracts.contract[contractName]
var abi = contract.abi
var bytecode = contract.evm.bytecode.object
// prepare Contract wrapper and "deploy" transaction, estimate cost for deployment
var helloWorldContract = new web3.eth.Contract(abi);
var helloWorldDeployTx = helloWorldContract.deploy({data: bytecode});
helloWorldDeployTx.estimateGas(function(err, gas){
    console.log("Estimated gas for deployment: " + gas);
});
// deploy from the given account, using up to the given gas amount
// print transaction hash and new contract instance address
helloWorldDeployTx.send({from: wallet, gas: 1022104})
.on('error', function(error){
    console.log("Error: " + error);
})
.on('transactionHash', function(transactionHash){
    console.log("Deployment txn: " + transactionHash)
})
.on('receipt', function(receipt){
   fs.writeFile('public/files/contractId.txt', receipt.contractAddress, (err) => {
  if (err)
    console.log(err);
  else {
    console.log("File written successfully\n");
    console.log("New contract ID:");
    console.log(fs.readFileSync("public/files/contractId.txt", "utf8"));
  }});

});

