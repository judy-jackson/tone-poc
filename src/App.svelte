<script>
	export let name;
	export let button_message;
	export let header_buffer;

	import {ethers} from 'ethers';

	console.log("Header length: " + header_buffer.byteLength + ", type: " + typeof header_buffer);
	console.log("Loading in contract: " + Date.now());

	let provider = new ethers.providers.JsonRpcProvider();
	let signer = provider.getSigner(0);
	//replace abi code with compiler output
	let abi = JSON.parse('[{"inputs":[],"name":"getAudio","outputs":[{"internalType":"bytes","name":"","type":"bytes"}],"stateMutability":"pure","type":"function"}]');
	let contractId = '0xB46E998ad2B9c6fE179fd04f7e88D20341510b93'; //replace this with your contract id
	let contract = new ethers.Contract(contractId, abi, signer);

	let audioCtx;
	let source;

	console.log("Contract loaded" + Date.now());

	function getAudio(audioData){
		if(window.webkitAudioContext) {
    		audioCtx = new window.webkitAudioContext();
  		} else {
    		audioCtx = new window.AudioContext();
  		}
		source = audioCtx.createBufferSource();
		audioCtx.decodeAudioData(audioData, function(buffer) {
        let myBuffer = buffer;
        source.buffer = myBuffer;
        source.connect(audioCtx.destination);
        source.loop = true;
      },

      function(e){"Error with decoding audio data" + e.error});
	  
  }

  	async function concatBuffers(buf1, buf2){
		var tmp = new Uint8Array(buf1.byteLength + buf2.byteLength);
  		tmp.set(new Uint8Array(buf1), 0);
  		tmp.set(new Uint8Array(buf2), buf1.byteLength);
  		return tmp.buffer;
	}

  	function stopPlay() {
		  console.log("Stop!");
		  source.stop(0);
	  }

	async function loadMessage(){
		console.log("Loading message: " + Date.now());
		let message = await contract.getAudio();
		return await message;
	}

	async function getArrayBuffer(str){
		str = str.slice(2);
		var byteStrings = str.match(/[\s\S]{1,2}/g) || [];
		var bufLength = byteStrings.length;
		var buf = new ArrayBuffer(bufLength);
		var bufView = new Uint8Array(buf);
		for (var i=0; i<bufLength; i++){
			bufView[i] = parseInt(byteStrings[i], 16);
		}

		console.log("Length of byestrings array: " + byteStrings.length);
		console.log("Arraybuffer len: " + buf.byteLength);
		return bufView.buffer;
	}

	async function startAudio() {
		//button_message = await loadMessage();
		let raw_audio = await loadMessage();
		let buf = await getArrayBuffer(raw_audio);
		let concat = await concatBuffers(header_buffer, buf);
		getAudio(concat);

		console.log("Message loaded: " + Date.now());
		button_message = "Audio loaded.";
		source.start(0);
	}

</script>

<main>
	<h1>Hello {name}!</h1>
	<button on:click={startAudio}> Play: {button_message}</button>
	<button on:click={stopPlay}> Stop </button>

</main>

<style>
	main {
		text-align: center;
		padding: 1em;
		max-width: 240px;
		margin: 0 auto;
	}

	h1 {
		color: #ff3e00;
		text-transform: uppercase;
		font-size: 4em;
		font-weight: 100;
	}

	@media (min-width: 640px) {
		main {
			max-width: none;
		}
	}
</style>