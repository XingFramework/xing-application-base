var cacheMap = require("../support/cacheMap.js");

module.exports = function(grunt) {
  return {
    options: {
      hashLength: 8,
      noProcess: true,
      onComplete: function(map, files) {
        var dirRE = new RegExp( '^('+grunt.config('build_dirs.root')+'|'+grunt.config('compile_dir')+')\/', 'g' );
        return files.forEach(function(file) {
          return cacheMap.push({
            pattern: file.replace( dirRE, '' ),
            replacement: map[file].replace( dirRE, '' )
          });
        });
      }
    },
    dist: {
      files: [
        {
          expand: true,
          cwd: './',
          src: [
            '<%= compile_targets.js %>',
            '<%= compile_targets.css %>'
          ],
          dest: './'
        }
      ]
    }
  };
};
