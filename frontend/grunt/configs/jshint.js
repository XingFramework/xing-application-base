/**
 * `jshint` defines the rules of our linter as well as which files we
 * should check. This file, all javascript sources, and all our unit tests
 * are linted based on the policies listed in `options`. But we can also
 * specify exclusionary patterns by prefixing them with an exclamation
 * point (!); this is useful when code comes from a third party but is
 * nonetheless inside `src/`.
 */
module.exports =
{
  src: [ '<%= app_files.js_es6 %>' ],

  precompile: {
    files: [ { src: [ '<%= app_files.js_es6 %>' ]}],
    options: { debug: false }
  },

  test: {
    files: [ { src: ['<%= app_files.jstest_es6 %>' ] }],
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
    '-W100': true
  },
  globals: {}
};
