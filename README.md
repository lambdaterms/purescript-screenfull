# purescript-screenfull

Tiny bindings for screenfull.js

## Install

To use this module you have to add `screenfull` version `^4.0.0` to your `package.json` dependencies and install it (check `./package.json`). Additionally you have to use bundler which bundles also nmp dependencies (like for exmaple `webpack` - please check `./example`).

## Example

In `./example` you can find trivial "test" project. Assuming that you have `purs` installed in your path you can just:

```sh
$ cd example
$ make
$ python2 -m SimpleHTTPServer 8000
```

You can now visit http://127.0.0.1:8000/index.html and check demo page which shows nearly whole module API usage.
