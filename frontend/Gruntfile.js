module.exports = function( grunt ) {

  /**
   * Load in our build configuration file.
   */
  var userConfig = require( './build.config.js' );

  userConfig.pkg = grunt.file.readJSON("package.json");

  var liveReloadPort   = require('./grunt/support/liveReloadPort.js');
  var karmaRunnerPort  = require('./grunt/support/karmaRunnerPort.js');

  grunt.cacheMap = []

  var path = require('path');

  require('load-grunt-config')(grunt, {
    configPath: path.join(process.cwd(), 'grunt/configs')
  });

  /**
   * This is the configuration object Grunt uses to give each plugin its
   * instructions.
   */

  grunt.config.merge( userConfig );

  grunt.loadTasks('grunt/tasks');

};
