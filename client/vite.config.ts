import { defineConfig } from 'vite';
import { svelte } from '@sveltejs/vite-plugin-svelte';
import path from 'path';

/// <reference types="vite/client" />
// https://vite.dev/config/
export default defineConfig({
  resolve: {
    alias: {
      $lib: path.resolve('./src/lib'),
    },
  },
  plugins: [svelte()],
  build: {
    outDir: '../static',
    emptyOutDir: true,
  },
});
