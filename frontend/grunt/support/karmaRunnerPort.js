var portOffset = require('./portOffset.js');
var karmaRunnerPort  = 9101  + portOffset();
module.exports = karmaRunnerPort;
