'use strict';

const path = require('path');
const webpack = require('webpack');

module.exports = {
  mode: 'development',

  devtool: 'original-source',

  entry: './app.js',

  output: {
    path: path.resolve(__dirname, 'dist'),
    pathinfo: true,
    filename: 'bundle.js'
  },
};
