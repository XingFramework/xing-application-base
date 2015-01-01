var portOffset = require('./portOffset.js');
var liveReloadPort   = 35729 + portOffset();
module.exports = liveReloadPort;
