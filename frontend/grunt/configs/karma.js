/**
 * The Karma configurations.
 *
 * TODO: Add coverage to general Karma runs
 */
var karmaRunnerPort = require('../support/karmaRunnerPort.js');

module.exports =
{
  options: {
    configFile: '<%= build_dirs.root %>/karma-unit.js',
    autoWatch: false,
    //browsers: [ 'PhantomJS' ]
  },
  unit: {
    options: {
      runnerPort: karmaRunnerPort,
      background: true
    }
  },
  continuous: { singleRun: true },
  dev: {
    options: {
      singleRun: true,
      runnerPort: 9101
    }
  }
};
