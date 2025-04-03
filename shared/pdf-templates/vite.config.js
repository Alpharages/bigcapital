import { defineConfig } from 'vite';
import path from 'path';
import dts from 'vite-plugin-dts';

export default defineConfig({
  build: {
    lib: {
      entry: path.resolve(__dirname, 'src/index.ts'),
      name: '@bigcapital/library-components',
      fileName: 'components',
      formats: ['umd'],
    },
    rollupOptions: {
      output: {
        globals: {
          // Add any external dependencies here
        },
      },
    },
    target: 'node16',
    outDir: 'dist',
    emptyOutDir: true,
  },
  plugins: [dts()],
});
