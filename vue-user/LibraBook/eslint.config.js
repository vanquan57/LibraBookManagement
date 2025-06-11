import pluginVue from 'eslint-plugin-vue';
export default [
    ...pluginVue.configs['flat/recommended'],
    {
        rules: {
            // Vue Component Rules
            'vue/multi-word-component-names': 'error',
            'vue/component-definition-name-casing': ['error', 'PascalCase'],
            // Props Rules
            'vue/require-prop-types': 'error',
            'vue/prop-name-casing': ['error', 'camelCase'],
            'vue/require-default-prop': 'warn',
            // Template Rules
            'vue/no-multiple-template-root': 'error',
            'vue/max-attributes-per-line': 'error',
            'vue/html-indent': ['error', 4],
            'vue/html-closing-bracket-spacing': 'error',
            // JavaScript Rules
            'no-console': 1,
            'no-lonely-if': 1,
            'no-unused-vars': 1,
            'no-trailing-spaces': 1,
            'no-multi-spaces': 1,
            'no-multiple-empty-lines': 1,
            // Formatting Rules
            'space-before-blocks': ['error', 'always'],
            'object-curly-spacing': [1, 'always'],
            indent: ['warn', 4],
            semi: [1, 'always'],
            quotes: ['error', 'single'],
            'array-bracket-spacing': 1,
            'linebreak-style': 0,
            'no-unexpected-multiline': 'warn',
            'keyword-spacing': 1,
            'comma-dangle': 1,
            'comma-spacing': 1,
            'arrow-spacing': 1,
            'eol-last': ['error', 'always']
        }
    }
];
