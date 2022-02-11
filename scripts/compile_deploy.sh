#!/bin/sh

npm install web3
npm install solc

# deploy contract $1=wallet $2=contract_path $3=contract_name
node /Users/jcj/utility/deploy.js $1 $2 $3

# remove old abi code $4=abi path
rm $4/contracts_*

# compile new abi
node_modules/.bin/solcjs --bin --abi $2

# move abi files over to files dir
mv contracts_* $4

echo "Contract deployed and compiled"
