module.exports = function ( config ) {
  config.set({
    /**
     * From where to look for files, starting with the location of this file.
     */
    basePath: '../../',

    /**
     * This is the list of file patterns to load into the browser during testing.
     */
    files: [
      {pattern: '<%= app_files.js %>', included: false},
      <% test_files.js.forEach(function(file){ %>
      '<%= file %>',<% }); %>
      'test/json-fixtures/**/*.json',
      {pattern: 'test/**/*.js', included: false},
      'test/test-main.js'
    ],
    exclude: [
      'src/assets/**/*.js'
    ],
    frameworks: [ 'jasmine', 'requirejs', 'traceur' ],
    plugins: [
      'karma-jasmine',
      'karma-firefox-launcher',
      'karma-chrome-launcher',
      'karma-phantomjs-launcher',
      //'karma-coffee-preprocessor',
      'karma-requirejs',
      'karma-traceur-preprocessor',
      'karma-ng-html2js-preprocessor',
    ],
    preprocessors: {
      '**/*.js': 'traceur',
      //'**/*.coffee': 'coffee',
      '**/*.html': ['ng-html2js'],
      '**/*.json': ['ng-html2js']
    },

    ngHtml2JsPreprocessor: {
      // strip this from the file path
      stripPrefix: 'test/',
      // prepend this to the
      //prependPrefix: '',

      // or define a custom transform function
      //cacheIdFromPath: function(filepath) {
      //  return cacheId;
      //},

      // setting this option will create only a single module that contains templates
      // from all the files, so you can load them all with module('foo')
      moduleName: 'fixtureCache'
    },

    traceurPreprocessor: {
      options: {
        sourceMaps: true,
        modules: 'amd',
      }
    },

    /**
     * How to report, by default.
     */
    //reporters: 'dots',
    /**
     * On which port should the browser connect, on which port is the test runner
     * operating, and what is the URL path for the browser to use.
     */
    port: 9018,
    runnerPort: 9100,
    urlRoot: '/',
    browserDisconnectTimeout: 20000,
    browserNoActivityTimeout: 20000,

    /**
     * Disable file watching by default.
     */
    //autoWatch: false,

    /**
     * The list of browsers to launch to test on. This includes only "Firefox" by
     * default, but other browser names include:
     * Chrome, ChromeCanary, Firefox, Opera, Safari, PhantomJS
     *
     * Note that you can also use the executable name of the browser, like "chromium"
     * or "firefox", but that these vary based on your operating system.
     *
     * You may also leave this blank and manually navigate your browser to
     * http://localhost:9018/ when you're running tests. The window/tab can be left
     * open and the tests will automatically occur there during the build. This has
     * the aesthetic advantage of not launching a browser every time you save.
     */
    browsers: [
      'Chrome'
    ]
  });
};
