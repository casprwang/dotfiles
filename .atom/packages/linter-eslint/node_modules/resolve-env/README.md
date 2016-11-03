
# `resolveEnv`

Quickly resolve strings with environmental variables. That is, turn `'Hello
$USER!'` into `Hello linus!`.

## Installation

```sh
npm install --save resolve-env
```

## Usage

```javascript
var resolveEnv = require('resolve-env');

// Displaying current user
resolveEnv('Node is running as user: $USER');

// Get url to linked docker container
resolveEnv('mongodb://$DB_PORT_27017_TCP_ADDR:$DB_PORT_27017_TCP_PORT');

// Interpolate variable
resolveEnv('The kingdom of ${USER}topia!');
```

## License

MIT
