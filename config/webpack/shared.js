// Note: You must restart bin/webpack-watcher for changes to take effect

var path = require('path')
var glob = require('glob')
var extname = require('path-complete-extname')
var webpack = require('webpack')

var entry = glob.sync(path.join('..', 'app', 'javascript', 'packs', '*.js*')).reduce(
  function(map, entry) {
    var basename = path.basename(entry, extname(entry))
    if (basename === 'common') {
      return map;
    }

    map[basename] = entry
    return map
  }, {}
) || {};

// common
entry['packs-bundle'] = [
  'rxjs/Rx',
  'react-dom',
  path.join('..', 'app', 'javascript', 'packs', 'common.js'),
];

module.exports = {
  entry: entry,

  output: { filename: '[name].js', path: path.resolve('..', 'public', 'packs') },

  module: {
    rules: [
      { test: /\.coffee(.erb)?$/, loader: "coffee-loader" },
      {
        test: /\.jsx?(.erb)?$/,
        exclude: /node_modules/,
        loader: 'babel-loader',
        options: {
          presets: [
            'react',
            [ 'latest', { 'es2015': { 'modules': false } } ]
          ]
        }
      },
      {
        test: /.erb$/,
        enforce: 'pre',
        exclude: /node_modules/,
        loader: 'rails-erb-loader',
        options: {
          runner: 'DISABLE_SPRING=1 ../bin/rails runner'
        }
      },
    ]
  },

  plugins: [
    new webpack.optimize.CommonsChunkPlugin({
      name: "packs-bundle",

      // filename: "vendor.js"
      // (Give the chunk a different name)

      minChunks: Infinity,
      // (with more entries, this ensures that no other module
      //  goes into the vendor chunk)
    })
  ],

  resolve: {
    extensions: [ '.js', '.coffee' ],
    modules: [
      path.resolve('../app/javascript'),
      path.resolve('../vendor/node_modules')
    ]
  },

  resolveLoader: {
    modules: [ path.resolve('../vendor/node_modules') ]
  },

  externals: {
    'jquery': 'jQuery',
    'jQuery': 'jQuery',
    'react': 'React',
  },
}
