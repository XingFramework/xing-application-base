/*
**  grunt-traceur-simple -- Grunt Task for ECMAScript 6 to ECMAScript 5 Transpiling
**  Copyright (c) 2014 Ralf S. Engelschall <rse@engelschall.com>
**
**  Permission is hereby granted, free of charge, to any person obtaining
**  a copy of this software and associated documentation files (the
**  "Software"), to deal in the Software without restriction, including
**  without limitation the rights to use, copy, modify, merge, publish,
**  distribute, sublicense, and/or sell copies of the Software, and to
**  permit persons to whom the Software is furnished to do so, subject to
**  the following conditions:
**
**  The above copyright notice and this permission notice shall be included
**  in all copies or substantial portions of the Software.
**
**  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
**  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
**  MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
**  IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
**  CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
**  TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
**  SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

/* global require:   false */
/* global module:    false */
/* global process:   false */
/* global __dirname: false */

/*  Grunt plugin information  */
var NAME = "traceur";
var DESC = "Transpiles ECMAScript 6 to ECMAScript 5 with Traceur";

/*  external requirements  */
var exec  = require("child_process").exec;
var os    = require("os");
var chalk = require("chalk");
var traceurCompiler = require("../support/traceurCompiler")

/*  external paths to Traceur  */
var traceurRuntimePath = traceurCompiler.RUNTIME_PATH

/*  export the Grunt task  */
module.exports = function (grunt) {
    grunt.registerMultiTask(NAME, DESC, function () {
        /*  provide default options  */
        var options = this.options({
            traceurRuntime: traceurRuntimePath,
            traceurOptions: {},
            moduleMaps: {},
            includeRuntime: false
        });
        grunt.verbose.writeflags(options, "Options");

        /*  iterate over all src-dest file pairs  */
        var rc = true;
        var done = this.async();
        var tasksCur = 0;
        var tasksMax = this.files.length;
        if (options.includeRuntime && tasksMax !== 1)
            grunt.fail.fatal("including the runtime into more than one output file rejected");

        if (options.moduleMaps) {
          Object.keys(options.moduleMaps).forEach(function(key) {
              System.map[key] = options.moduleMaps[key];
          });
        }

        traceurCompiler.setOptions(options.traceurOptions)

        if (options.srcDir && options.destDir) {
          result = traceurCompiler.compileAllJsFilesInDir(options.srcDir, options.destDir)
          result.then(function() {
            done(true);
          }
          ).catch(function() {
            done(false);
          }
          );
        } else {
          this.files.forEach(function (f) {

              /*  assemble the Traceur shell command  */

              out = f.dest;
              rootSources = f.src.map(function (name) { return {name: name, type: 'module'}})

              traceurCompiler.recursiveCompile(out, rootSources).then(function() {
                /*  success reporting  */
                grunt.log.writeln("transpiling: " + chalk.green(f.dest) + " <- " + chalk.green(f.src.join(" ")));

              }).catch(function(err) {
                var errors = err.errors || [err];
                grunt.log.writeln("transpiling: " + chalk.red(f.dest) + " <- " + chalk.red(f.src.join(" ")));
                errors.forEach(function(err) {
                  grunt.log.error(err.stack || err);
                });
                rc = false;
              }).then(function() {
                /*  optional runtime inclusion  */
                if (options.includeRuntime) {
                    grunt.log.writeln("injecting:   " + chalk.green(f.dest) + " <- " + chalk.green(options.traceurRuntime));
                    var rt = grunt.file.read(options.traceurRuntime, { encoding: "utf8" });
                    var txt = grunt.file.read(f.dest, { encoding: "utf8" });
                    txt = rt + "\n" + txt;
                    grunt.file.write(f.dest, txt, { encoding: "utf8" });
                }

                /*  determine end of asynchronous transpiling  */
                tasksCur++;
                if (tasksCur === tasksMax)
                    done(rc);
              });
          });
        }
    });
};
