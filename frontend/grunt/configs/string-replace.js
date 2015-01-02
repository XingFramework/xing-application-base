module.exports = function(grunt) {
  return {
    dist: {
      files: {
        '<%= compile_dir %>/index.html': '<%= compile_dir %>/index.html'
      }
    },
    options: {
      replacements: grunt.cacheMap
    }
  };
};
