module.exports = {
  env: {
    node: true, // Enable Node.js global variables and scoping
    es6: true,  // Enable ES6 features
  },
  extends: [
    'airbnb-base', // Airbnb's base ESLint rules
    'airbnb-typescript/base', // Airbnb's TypeScript rules
    'plugin:node/recommended', // Recommended rules for Node.js
  ],
  parser: '@typescript-eslint/parser', // Use the TypeScript parser
  parserOptions: {
    ecmaVersion: 2020, // Use the latest ECMAScript version
    sourceType: 'module', // Use ES modules
    project: './tsconfig.json', // Path to your tsconfig.json
  },
  plugins: [
    '@typescript-eslint', // TypeScript plugin
    'import', // Import plugin for resolving imports
    'node', // Node.js plugin
  ],
  rules: {
    'import/no-unresolved': 'error', // Ensure imports are resolved
    'import/prefer-default-export': 'off', // Allow named exports
    'node/no-missing-import': 'off', // Disable this rule as it conflicts with TypeScript's import resolution
    'node/no-unsupported-features/es-syntax': 'off',
    'node/no-unsupported-features/node-builtins': 'error',
    'node/shebang': 'error',
    'no-console': 'error',
    'no-process-exit': 'off', // Allow the use of process.exit()
    'no-underscore-dangle': 'warn',
  },
  settings: {
    'import/parsers': {
      '@typescript-eslint/parser': ['.ts', '.tsx'], // Use TypeScript parser for .ts and .tsx files
    },
    'import/resolver': {
      typescript: {
        alwaysTryTypes: true, // Always try to resolve types under `<root>@types` directory
        project: './tsconfig.json', // Path to your tsconfig.json
      },
    },
  },
};