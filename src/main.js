import App from './App.svelte';
import rawBuffer from './header';
import abi from './abi';
import contractId from './contractId';

const app = new App({
	target: document.body,
	props: {
		name: 'ciabatta',
		button_message: 'Not Loaded',
		header_buffer: rawBuffer, 
		abiString: abi,
		contractIdExt: contractId
	}
});

export default app;