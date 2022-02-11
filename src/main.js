import App from './App.svelte';
import rawBuffer from './header';

const app = new App({
	target: document.body,
	props: {
		name: 'ciabatta',
		button_message: '12',
		header_buffer: rawBuffer
	}
});

export default app;