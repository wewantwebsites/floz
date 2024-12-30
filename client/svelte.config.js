import { vitePreprocess } from '@sveltejs/vite-plugin-svelte';

/// <reference types="svelte" />
export default {
  // Consult https://svelte.dev/docs#compile-time-svelte-preprocess
  // for more information about preprocessors
  preprocess: vitePreprocess(),
};
