all: node_modules bower_modules
	purs compile './bower_components/purescript-*/src/**/*.purs' 'src/*.purs'
	node_modules/.bin/webpack-cli --config webpack.config.js

bower_modules: node_modules
	bower update

node_modules:
	npm install

