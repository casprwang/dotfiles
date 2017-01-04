// npm i -D eslint eslint-plugin-react babel-eslint 
//
// "devDependencies": {
//   "babel-cli": "^6.18.0",
//   "babel-eslint": "^7.1.1",
//   "babel-loader": "^6.2.10",
//   "babel-preset-es2015": "^6.18.0",
//   "babel-preset-react": "^6.16.0",
//   "babel-preset-stage-2": "^6.18.0",
//   "eslint": "^3.12.2",
//   "eslint-plugin-react": "^6.8.0",
// }
//
//
//
module.exports = {
  "parser": 'babel-eslint',
  "env": {
    "browser": true,
    "commonjs": true,
    "es6": true,
    "node": true
  },
  "extends": ["eslint:recommended", "plugin:react/recommended"],
  "parserOptions": {
    "ecmaFeatures": {
      "experimentalObjectRestSpread": true,
      "jsx": true
    },
    "sourceType": "module"
  },
  "plugins": [ "react" ],
  "rules": {
    "indent": ["error", 2],
    "linebreak-style": ["error","unix"],
    "quotes": ["error","single"],
    "semi": ["error","always"],
    "no-console": ["warn", { "allow": ["info", "error"] }]
  }
};
