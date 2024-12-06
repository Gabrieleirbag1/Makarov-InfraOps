// webpack.config.js
const path = require('path');

module.exports = {
    entry: './MAKAROV-AIRPORT/docker/djangopache-compose/makarov_gp/static/libs/assets/js/faro-initialization.js',
    output: {
        path: path.resolve(__dirname, 'MAKAROV-AIRPORT/docker/djangopache-compose/makarov_gp/static/libs/assets/js'),
        filename: 'faro.bundle.js',
    },
    mode: 'production'
};
