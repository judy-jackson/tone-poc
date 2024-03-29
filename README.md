## Get started
Set up to run with local test blockchain (ganache). Install and run ganache-cli:

```bash
npm install ganache-cli
node_modules/.bin/ganache-cli
```

Compile and deploy contract to test blockchain. `/scripts/compile_deploy.sh` is included for your convenience.
```bash
chmod 755 scripts/compile_deploy2.sh
./scripts/compile_deploy2.sh <wallet_address> <contract_file_path> <contract_name> <file_dir>
```

For example, to compile and deploy the contract Melody.sol
```bash
./scripts/compile_deploy2.sh 0xFaKeGaNaCheWaLlEt001 contracts/Melody.sol MelodyGen public/files
```
The script will print out the address of the new contract and save ABI and bytecode to the `<file_dir>` directory. *NEW* The app auto-loads
contract info from files that are generated by this script, `<file_dir>` should be set to `public/files`

Install the dependencies for the app.

```bash
npm install
```

Start by running
```bash
npm run dev
```

Navigate to [localhost:8080](http://localhost:8080). To play audio, press the "Play" button. To stop, press "Stop". Note: audio gen hasn't been optimized yet and is currently very slow. It will take some time before audio will begin to play: the button will display "Audio Loaded" when data has been loaded successfully.

