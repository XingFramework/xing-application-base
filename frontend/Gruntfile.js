module.exports = function( grunt ) {
  /**
   * Load required Grunt tasks. These are installed based on the versions listed
   * in `package.json` when you do `npm install` in this directory.
   */
  grunt.loadNpmTasks('grunt-contrib-clean');
  grunt.loadNpmTasks('grunt-contrib-copy');
  grunt.loadNpmTasks('grunt-contrib-jshint');
  grunt.loadNpmTasks('grunt-concat-sourcemap');
  grunt.loadNpmTasks('grunt-contrib-watch');
  grunt.loadNpmTasks('grunt-contrib-uglify');
  grunt.loadNpmTasks('grunt-contrib-coffee');
  grunt.loadNpmTasks('grunt-conventional-changelog');
  grunt.loadNpmTasks('grunt-bump');
  grunt.loadNpmTasks('grunt-coffeelint');
  grunt.loadNpmTasks('grunt-karma');
  grunt.loadNpmTasks('grunt-ng-annotate');
  grunt.loadNpmTasks('grunt-html2js');
  grunt.loadNpmTasks('grunt-contrib-compass');
  grunt.loadNpmTasks('grunt-bower');
  grunt.loadNpmTasks('grunt-contrib-connect');
  grunt.loadNpmTasks('grunt-traceur-simple');
  grunt.loadNpmTasks('grunt-jsonlint');

  grunt.loadNpmTasks('grunt-concurrent');
  /**
   * Load in our build configuration file.
   */
  var userConfig = require( './build.config.js' );

  userConfig.pkg = grunt.file.readJSON("package.json");
  /**
   * This is the configuration object Grunt uses to give each plugin its
   * instructions.
   */

  var taskConfig = {
    /**
     * The banner is the comment that is placed at the top of our compiled
     * source files. It is first processed as a Grunt template, where the `<%=`
     * pairs are evaluated based on this very configuration object.
     */
    meta: {
      banner:
        '/**\n' +
        ' * <%= pkg.name %> - v<%= pkg.version %> - <%= grunt.template.today("yyyy-mm-dd") %>\n' +
        ' * <%= pkg.homepage %>\n' +
        ' *\n' +
        ' * Copyright (c) <%= grunt.template.today("yyyy") %> <%= pkg.author %>\n' +
        ' <% if(pkg.licenses){ %>* Licensed <%= pkg.licenses.type %> <<%= pkg.licenses.url %>><% } %>\n' +
        ' */\n'
    },

      /**
       * Creates a changelog on a new version.
       */
      changelog: {
        options: {
          dest: 'CHANGELOG.md',
          template: 'changelog.tpl'
        }
      },

      /**
       * Increments the version number, etc.
       */
      bump: {
        options: {
          files: [
            "package.json",
            "bower.json"
          ],
          commit: false,
          commitMessage: 'chore(release): v%VERSION%',
          commitFiles: [
            "package.json",
            "client/bower.json"
          ],
          createTag: false,
          tagName: 'v%VERSION%',
          tagMessage: 'Version %VERSION%',
          push: false,
          pushTo: 'origin'
        }
      },

      /**
       * The directories to delete when `grunt clean` is executed.
       */
      clean: {
        fixtures: [
          'test/json-fixtures'
        ],
        build: [
          '<%= build_dirs.root %>',
          '<%= compile_dir %>',
          'vendor'
        ]
      },

      bower: {
        install: {
          dest: 'vendor',
          options: {
            expand: true,
            packageSpecific: {
              'breakpoint-sass': {
                files: [
                  'stylesheets/**'
                ]
              },
              'sass-import-once': {
                files: [
                  '_sass-import-once.scss'
                ]
              },
              'compass-vanilla': {
                files: [
                  'compass/stylesheets/**'
                ]
              },
              'sassy-buttons': {
                files: [
                  "**"
                ]
              },
              'singularity': {
                files: [
                  "stylesheets/**"
                ]
              }
            }
          }
        }
      },

      /**
       * The `copy` task just copies files from A to B. We use it here to copy
       * our project assets (images, fonts, etc.) and javascripts into
       * `build_dir`, and then to copy the assets to `compile_dir`.
       */
      copy: {
        "authoritative-fixtures": {
          files: [
            {
            cwd: 'spec/fixtures',
            src: [ '**' ],
            dest: 'test/json-fixtures',
            expand: true
          }
          ]
        },
        "test-env": {
          files: {
            "src/common/environment.js": "config/environments/test.js"
          }
        },
        "production-env": {
          files: {
            "src/common/environment.js": "config/environments/production.js"
          }
        },
        "development-env": {
          files: {
            "src/common/environment.js": "config/environments/development.js"
          }
        },
        "integration-env": {
          files: {
            "src/common/environment.js": "config/environments/integration.js"
          }
        },

        traceur_runtime: {
          files: {
            "bin/assets/traceur-runtime.js": "./node_modules/traceur/bin/traceur-runtime.js",
          }
        },

        karmaUnit: {
          options: { process: function( contents, path ) { return grunt.template.process( contents ); } },
          files: { '<%= build_dirs.root %>/karma-unit.js': ['karma/karma-unit.tpl.js'] }
        },

        vendor_fonts: {
          files: [ {
            expand: true,
            src: ["vendor/**/*.eot", "vendor/**/*.ttf", "vendor/**/*.woff", "vendor/**/fontawesome-webfont.svg"],
            flatten: true,
            dest: "bin/fonts"
          }]
        },

        build_app_assets: {
          files: [ {
            src: [ '**' ],
            dest: '<%= build_dirs.assets %>',
            cwd: 'src/assets',
            expand: true
          } ]
        },
        build_vendor_assets: {
          files: [ {
            src: [ '<%= vendor_files.assets %>' ],
            dest: '<%= build_dirs.assets %>',
            cwd: '.',
            expand: true,
            flatten: true
          } ]
        },
        compile_assets: {
          files: [ {
            src: [ '**' ],
            dest: '<%= compile_dir %>/assets',
            cwd: '<%= build_dirs.assets %>',
            expand: true
          } ]
        }
      },

      /**
       * `grunt concat` concatenates multiple source files into a single file.
       */
      concat_sourcemap: {
        compile_css: {
          files: {
            '<%= compile_targets.css %>': [
            '<%= build_dirs.stylesheets %>/*.css',
            '<%= vendor_files.css %>'
            ]
          }
        },
        compile_vendor_js: {
          files: {
            '<%= compile_targets.vendor_js %>': [
              '<%= vendor_files.js %>'
            ]
          }
        },
        compile_js: {
          files: {
            '<%= compile_targets.js %>': [
              '<%= compile_targets.vendor_js %>',
              '<%= compile_targets.js %>'
            ]
          }
        }
      },

      /**
       * `grunt coffee` compiles the CoffeeScript sources. To work well with the
       * rest of the build, we have a separate compilation task for sources and
       * specs so they can go to different places. For example, we need the
       * sources to live with the rest of the copied JavaScript so we can include
       * it in the final build, but we don't want to include our specs there.
       */
      coffee: {
        source: {
          options: {
            bare: true
          },
          expand: true,
          cwd: '.',
          src: [ '<%= app_files.coffee %>' ],
          dest: '<%= build_dirs.js %>',
          ext: '.js'
        }
      },

      /*
      */
      traceur: {
        options: {
          includeRuntime: false,
          traceurRuntime: "./node_modules/traceur/bin/traceur-runtime.js",
          traceurCommand: "./node_modules/.bin/traceur",
          traceurOptions: "--array-comprehension true --source-maps"
        },
        build: {
          files: { '<%= compile_targets.js %>': '<%= app_files.js_roots %>' }
        },
        deploy: {
          options: {
            includeRuntime: true,
            traceurOptions: "--array-comprehension true --source-maps"
          },
          files: { '<%= compile_targets.js %>': '<%= app_files.js_roots %>' }
        },
        test: {
          options: {
            includeRuntime: false
          },
          files: { '<%= build_dirs.test%>/test-main.js': '<%= app_files.jsunit %>' }
        }
      },

      /**
       * `ngAnnotate` annotates the sources before minifying. That is, it allows us
       * to code without the array syntax.
       */
      ngAnnotate: {
        compile: {
          files: { '<%= compile_targets.js %>': '<%= compile_targets.js %>' }
        }
      },

      /**
       * Minify the sources!
       */
      uglify: {
        compile: {
          options: { banner: '<%= meta.banner %>' },
          files: { '<%= compile_targets.js %>': '<%= compile_targets.js %>' }
        }
      },


      compass: {
        options: {
          sassDir: '<%= app_files.sass %>',
          cssDir: '<%= build_dirs.stylesheets %>'
        },
        build: {
        },
        server: {
          options: {
            watch: true
          }
        }
      },
      concurrent:{
        server: {
          tasks: ['compass:server', 'delta'],
          options: {
            logConcurrentOutput: true
          }
        }
      },

      /**
       * `jshint` defines the rules of our linter as well as which files we
       * should check. This file, all javascript sources, and all our unit tests
       * are linted based on the policies listed in `options`. But we can also
       * specify exclusionary patterns by prefixing them with an exclamation
       * point (!); this is useful when code comes from a third party but is
       * nonetheless inside `src/`.
       */
      jshint: {
        src: [ '<%= app_files.js %>' ],

        precompile: {
          files: [ { src: [ '<%= app_files.js %>' ]}],
          options: { debug: false }
        },

        test: {
          files: [ { src: ['<%= app_files.jstest %>' ] }],
          options: {
            debug: true,
          }
        },

        gruntfile: [ 'Gruntfile.js' ],

        target: {
          files: [ {
            src: [ '<%= compile_targets.js %>' ]
          } ],
          options: {
            undef: true, //forbid use of undefined variables
            esnext: false //post transpilation, should be ES5
          }
        },
        // c.f. http://www.jshint.com/docs/options/
        options: {
          debug: true,
          bitwise: true, //don't allow ^ | &, which are bitwise not boolean
          //eqeqeq: true, //require === and !== instead of == and !=
          forin: true, //require for in loops to filter items with hasOwnProperty
          curly: true, //require {} for if and while etc
          immed: true, //immediate function invocations must have ()
          latedef: false, //"nofunc", //declare variables before use
          newcap: true, //new lowercase() forbidden
          noarg: true, //don't use arguments.caller and arguments.callee
          sub: true, //okay to use thing['value'] when thing.value would work
          eqnull: true, //allow `== null`
          esnext: true, //we're using ES6

          browser: true, //Automatically allow browser-exposed globals
        },
        globals: {}
      },

      jsonlint: {
        dummies: {
          src: ['../dummy-api/**/*'],
          filter: 'isFile'
        },
        fixtures: {
          src: ['test/json-fixtures/**/*.json']
        }
      },

      /**
       * `coffeelint` does the same as `jshint`, but for CoffeeScript.
       * CoffeeScript is not the default in ngBoilerplate, so we're just using
       * the defaults here.
       */
      coffeelint: {
        src: {
          files: { src: [ '<%= app_files.coffee %>' ] }
        },
        test: {
          files: { src: [ '<%= app_files.coffeeunit %>' ] }
        }
      },

      /**
       * HTML2JS is a Grunt plugin that takes all of your template files and
       * places them into JavaScript files as strings that are added to
       * AngularJS's template cache. This means that the templates too become
       * part of the initial payload as one JavaScript file. Neat!
       */
      html2js: {
        /**
         * These are the templates from `src/app`.
         */
        app: {
          options: { base: 'src/app' },
          src: [ '<%= app_files.atpl %>' ],
          dest: '<%= build_dirs.root %>/templates-app.js'
        },

        /**
         * These are the templates from `src/common`.
         */
        common: {
          options: { base: 'src/common' },
          src: [ '<%= app_files.ctpl %>' ],
          dest: '<%= build_dirs.root %>/templates-common.js'
        },

        test: {
          options: { base: 'test', module: 'fixtureCache'},
          src: [ '<%= app_files.ttpl %>' ],
          dest: '<%= build_dirs.test %>/fixtureCache.js'
        }
      },

      /**
       * The Karma configurations.
       *
       * TODO: Add coverage to general Karma runs
       */
      karma: {
        options: {
          configFile: '<%= build_dirs.root %>/karma-unit.js',
          autoWatch: false,
          //browsers: [ 'PhantomJS' ]
        },
        unit: {
          options: {
            runnerPort: 9101,
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
      },

      /**
       * The `index` task compiles the `index.html` file as a Grunt template. CSS
       * and JS files co-exist here but they get split apart later.
       */
      index: {

        /**
         * When it is time to have a completely compiled application, we can
         * alter the above to include only a single JavaScript and a single CSS
         * file. Now we're back!
         */
        build: {
          dir: '<%= compile_dir %>',
          src: [
            "bin/assets/traceur-runtime.js",
            '<%= compile_targets.vendor_js %>',
            '<%= compile_targets.js %>',
            '<%= compile_targets.css %>'
          ]
        },

        deploy: {
          production: true,
          dir: '<%= compile_dir %>',
          src: [
            '<%= compile_targets.js %>',
            '<%= compile_targets.css %>'
          ]
        }
      },

      /**
       * XXX remove
       * This task compiles the karma template so that changes to its file array
       * don't have to be managed manually.
       *
       * TODO: Use the bower interfaces to get the vendor files
       */
      karmaconfig: {
        unit: {
          dir: '<%= build_dirs.root %>',
          src: [
            '<%= vendor_files.js %>',
            '<%= html2js.app.dest %>',
            '<%= html2js.common.dest %>',
            '<%= test_files.js %>',
            '<%= app_files.jsunit %>'
          ]
        }
      },

      connect: {
        server: {
          options: {
            debug: true,
            open: true,
            port: 9000,
            hostname: 'localhost',
            livereload: 35729,
            middleware: function(connect, options, middlewares) {
              middlewares.unshift(function(req, res, next) {
                if(/application\/json/.test(req.headers["accept"])){
                  res.setHeader("Content-Type", "application/json");
                  res.setHeader("X-Judson-Irritation", "extreme");
                  req.url = req.url + ".json";
                  console.log("Next was rewritten to:", req.url);
                }
                next();
              });

              return middlewares;
            },
            base: [
              './bin',
              '../dummy-api'
            ]
          }
        }
      },
      /**
       * And for rapid development, we have a watch set up that checks to see if
       * any of the files listed below change, and then to execute the listed
       * tasks when they do. This just saves us from having to type "grunt" into
       * the command-line every time we want to see what we're working on; we can
       * instead just leave "grunt watch" running in a background terminal. Set it
       * and forget it, as Ron Popeil used to tell us.
       *
       * But we don't need the same thing to happen for all the files.
       */
      delta: {
        /**
         * By default, we want the Live Reload to work for all tasks; this is
         * overridden in some tasks (like this file) where browser resources are
         * unaffected. It runs by default on port 35729, which your browser
         * plugin should auto-detect.
         */
        options: {
          livereload: true
        },

        /**
         * When the Gruntfile changes, we just want to lint it. In fact, when
         * your Gruntfile changes, it will automatically be reloaded!
         */
        gruntfile: {
          files: 'Gruntfile.js',
          tasks: [ 'jshint:gruntfile' ],
          options: {
            livereload: false
          }
        },

        /**
         * When our JavaScript source files change, we want to run lint them and
         * run our unit tests.
         */
        jssrc: {
          options: { livereloadOnError: false },
          files: [ 'src/**/*.js' ],
          tasks: [ 'jshint:src', 'traceur:build' ],
        },

        js_qa: {
          files: [],
          tasks: [ 'jshint:src', "jsonlint" ],
          options: { atBegin: true }
        },

        /**
         * When our CoffeeScript source files change, we want to run lint them and
         * run our unit tests.
         */
        coffeesrc: {
          files: [
            '<%= app_files.coffee %>'
          ],
          tasks: [ 'coffeelint:src', 'coffee:source', 'traceur:build' ]
        },

        /**
         * When assets are changed, copy them. Note that this will *not* copy new
         * files, so this is probably not very useful.
         */
        assets: {
          files: [
            'src/assets/**/*'
          ],
          tasks: [ 'copy:build_assets' ]
        },

        /**
         * When index.html changes, we need to compile it.
         */
        html: {
          files: [ '<%= app_files.html %>' ],
          tasks: [ 'index:build' ],
          options: {
            atBegin: true
          }
        },

        /**
         * When our templates change, we only rewrite the template cache.
         */
        tpls: {
          files: [
            '<%= app_files.atpl %>',
            '<%= app_files.ctpl %>'
          ],
          tasks: [ 'html2js', 'traceur:build' ],
        },

        sass: {
          files: [ '<%= build_dirs.stylesheets %>/*.css'],
          tasks: [ 'concat_sourcemap:compile_css' ]
        },

        vendor_js: {
          files: [ 'vendor/**/*.js' ],
          tasks: [ 'concat_sourcemap:compile_vendor_js' ]
        },
        /**
         * When a JavaScript unit test file changes, we only want to lint it and
         * run the unit tests. We don't want to do any live reloading.
         */
        jsunit: {
          files: [
            'bin/assets/vendor.js', '<%= app_files.jstest %>', 'test/json-fixtures/**/*', '<%= compile_targets.js %>'
          ],
          tasks: [ 'jsonlint:fixtures', 'jshint:test', 'html2js:test','traceur:test', 'karma:unit:run' ],
          options: {
            livereload: false,
            atBegin: true
          }
        },

        dummyapi: {
          files: [ "../dummy-api/**" ],
          tasks: [ 'jsonlint:dummies' ]
        },

        karmaconfig: {
          files: [
            "<%= build_dirs.root %>/karma-unit.js", "karma/karma-unit.tpl.js"
          ],
          tasks: [ 'copy:karmaUnit' ],
          options: {
            reload: true
          }
        },

        /**
         * When a CoffeeScript unit test file changes, we only want to lint it and
         * run the unit tests. We don't want to do any live reloading.
         */
        coffeeunit: {
          files: [
            '<%= app_files.coffeeunit %>'
          ],
          tasks: [ 'coffeelint:test', 'html2js:test', 'traceur:test', 'karma:unit:run' ],
          options: {
            livereload: false
          }
        }
      }
  };

  grunt.initConfig( grunt.util._.extend( taskConfig, userConfig ) );

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
    'html2js', 'coffee', //'jshint:target',
    'compass:build',
    'concat_sourcemap:compile_vendor_js',
    'concat_sourcemap:compile_css',
    'copy:build_app_assets', 'copy:build_vendor_assets',
    'copy:compile_assets', 'copy:vendor_fonts',
    'copy:karmaUnit'
  ]);

  grunt.registerTask( 'qa', "Check source code before deploy", [ 'jshint:src', 'jsonlint', 'coffeelint', ]);

  grunt.registerTask( 'develop-build', "Compile the app under development", [ 'build', 'traceur:build', 'copy:traceur_runtime', 'index:build']);
  grunt.registerTask( 'develop', "Compile the app under development", [ 'copy:development-env', 'develop-build']);
  grunt.registerTask( 'integrate', "Compile the app under development", [ 'copy:integration-env', 'develop-build']);
  grunt.registerTask( 'ci-test', "First pass at a build-and-test run", [
    'copy:test-env',
    'develop-build',
    'jsonlint:fixtures',
    'jshint:test',
    'html2js:test',
    'traceur:test',
    'karma:dev' ]);
  grunt.registerTask( 'compile', "Compile the app in preparation for deploy", [ 'copy:production-env', 'jshint:precompile', 'build', 'traceur:deploy', 'index:deploy', 'concat_sourcemap:compile_js', 'ngAnnotate', 'uglify' ]);

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
      jsFiles.push("http://localhost:35729/livereload.js?snipver=1&maxdelay=15000");
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

  /**
   * In order to avoid having to specify manually the files needed for karma to
   * run, we use grunt to manage the list for us. The `karma/*` files are
   * compiled as grunt templates for use by Karma. Yay!
   */
  grunt.registerMultiTask( 'karmaconfig', 'Process karma config templates', function () {
    var jsFiles = promoteAngular(filterForJS( this.filesSrc ));

    grunt.file.copy( 'karma/karma-unit.tpl.js', grunt.config( 'build_dirs.root' ) + '/karma-unit.js', {
      process: function ( contents, path ) {
        return grunt.template.process( contents, {
          data: {
            scripts: jsFiles
          }
        });
      }
    });
  });
};
