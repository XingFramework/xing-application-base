var cacheMap = require("../support/cacheMap.js");

module.exports = function(grunt) {
  return {
    dist: {
      files: {
        '<%= compile_dir %>/index.html': '<%= compile_dir %>/index.html'
      }
    },
    options: {
      replacements: function() {
        return cacheMap;
      }
    }
  };
};
