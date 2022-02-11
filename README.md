## Get started
Set up to run with local test blockchain (ganache). Install and run ganache-cli:

```bash
npm install ganache-cli
node_modules/.bin/ganache-cli
```

Compile and deploy contract to test blockchain. `/scripts/compile_deploy.sh` is included for your convenience.
```bash
chmod 755 compile_deploy.sh
./compile_deploy.sh <wallet_address> <contract_file_path> <contract_name> <file_dir>
```

For example, to compile and deploy the contract Melody.sol
```bash
./compile_deploy.sh 0xFaKeGaNaCheWaLlEt001 contracts/Melody.sol MelodyGen files
```
The script will print out the address of the new contract and save ABI and bytecode to the <file_dir> directory.

Replace the value for [contract address](https://github.com/judy-jackson/tone-poc/blob/init_commit/src/App.svelte#L14) and [ABI](https://github.com/judy-jackson/tone-poc/blob/init_commit/src/App.svelte#L13) in the [App.svelte](/src/App.svelte) file.

Install the dependencies for the app.

```bash
npm install
```

Start by running
```bash
npm run dev
```

Navigate to [localhost:8080](http://localhost:8080). To play audio, press the "Play" button. To stop, press "Stop". Note: audio gen hasn't been optimized yet and is currently very slow. It will take some time before audio will begin to play.

