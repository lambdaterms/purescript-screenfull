/* global btoa, document, exports, Image, require, window, XMLSerializer */

"use strict";

var screenfull = require('screenfull');

exports.exit = function() {
  return screenfull.exit();
}

exports.onChange = function(effect) {
  return function() {
    screenfull.onchange(effect);
    return (function() { screenfull.off('change', effect); });
  }
}

exports.request = function() {
  return screenfull.request();
}

exports.toggle = function(callbacks) {
  return screenfull.toggle();
}

exports.isFullScreen = function() {
  return screenfull.isFullscreen;
}

exports.enabled = function() {
  return screenfull.enabled;
}

exports.elementImpl = function() {
  return screenfull.element;
}

