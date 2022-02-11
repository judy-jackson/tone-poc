import App from './App.svelte';
import rawBuffer from './header';

const app = new App({
	target: document.body,
	props: {
		name: 'ciabatta',
		button_message: 'Not Loaded',
		header_buffer: rawBuffer
	}
});

export default app;