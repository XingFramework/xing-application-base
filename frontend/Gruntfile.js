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

  /**
   * In order to make it safe to just compile or copy *only* what was changed,
   * we need to ensure we are starting from a clean, fresh build. So we rename
   * the `watch` task to `delta` (that's why the configuration var above is
   * `delta`) and then add a new task called `watch` that does a clean build
   * before watching for changes.
   */
  grunt.renameTask( 'watch', 'delta' );
  grunt.registerTask( 'watch', [ 'develop', 'karma:unit:start', 'connect', 'concurrent:server' ] );
  grunt.registerTask( 'watch:develop', [ 'develop', 'karma:unit:start', 'concurrent:server' ] );
  grunt.registerTask( 'watch:integrate', [ 'integrate', 'karma:unit:start', 'connect', 'concurrent:server' ] );

  /**
   * The default task is to build and compile.
   */
  grunt.registerTask( 'default', [ 'compile' ] );

  grunt.registerTask( 'build', [
    'clean:build', 'bower:install',
    'html2js', //'jshint:target',
    'compass:build',
    'concat_sourcemap:compile_vendor_js',
    'concat_sourcemap:compile_css',
    'copy:build_app_assets', 'copy:build_vendor_assets',
    'copy:compile_assets', 'copy:vendor_fonts',
    'copy:karmaUnit'
  ]);

  grunt.registerTask( 'qa', "Check source code before deploy", [ 'jshint:src', 'jsonlint']);

  grunt.registerTask( 'develop-build', "Compile the app under development", [ 'build', 'traceur:build', 'copy:traceur_runtime', 'index:build', 'ngAnnotate:build', 'ngAnnotate:build_vendor']);
  grunt.registerTask( 'develop', "Compile the app under development", [ 'copy:development-env', 'develop-build']);
  grunt.registerTask( 'integrate', "Compile the app under development", [ 'copy:integration-env', 'develop-build']);
  grunt.registerTask( 'ci-test', "First pass at a build-and-test run", [
    'copy:test-env',
    'develop-build',
    'jsonlint:fixtures',
    'jshint:test',
    'html2js:test',
    'traceur:test',
    'ngAnnotate:test',
    'karma:dev' ]);
  grunt.registerTask( 'compile', "Compile the app in preparation for deploy", [ 'copy:production-env', 'jshint:precompile', 'build', 'traceur:deploy', 'index:deploy', 'concat_sourcemap:compile_js', 'ngAnnotate:compile', 'uglify', 'bushcaster:dist', 'string-replace:dist' ]);

  /**
   * A utility function to get all app JavaScript sources.
   */
  function filterForJS ( files ) {
    return files.filter( function ( file ) {
      return file.match( /\.js$/ );
    });
  }

  /**
   * A utility function to get all app CSS sources.
   */
  function filterForCSS ( files ) {
    return files.filter( function ( file ) {
      return file.match( /\.css$/ );
    });
  }

  function promoteAngular(jsFiles){
    var angularFiles = jsFiles.filter( function( file ){
      return file.match( /angular\.js$/ );
    });
    var otherFiles = jsFiles.filter( function( file ){
      return !file.match( /angular\.js$/ );
    });

    return angularFiles.concat(otherFiles);
  }

  /**
   * The index.html template includes the stylesheet and javascript sources
   * based on dynamic names calculated in this Gruntfile. This task assembles
   * the list into variables for the template to use and then runs the
   * compilation.
   */
  grunt.registerMultiTask( 'index', 'Process index.html template', function () {
    var dirRE = new RegExp( '^('+grunt.config('build_dirs.root')+'|'+grunt.config('compile_dir')+')\/', 'g' );
    var jsFiles = filterForJS( this.filesSrc ).map( function ( file ) {
      return file.replace( dirRE, '' );
    });
    if(!this.data.production){
      port =
      jsFiles.push("http://localhost:"+liveReloadPort+"/livereload.js?snipver=1&maxdelay=15000");
    }
    var cssFiles = filterForCSS( this.filesSrc ).map( function ( file ) {
      return file.replace( dirRE, '' );
    });

    grunt.file.copy('src/index.html', this.data.dir + '/index.html', {
      process: function ( contents, path ) {
        return grunt.template.process( contents, {
          data: {
            scripts: jsFiles,
            styles: cssFiles,
            appName: grunt.config( 'pkg.name' ),
            version: grunt.config( 'pkg.version' )
          }
        });
      }
    });
  });

};
