/**
 * `ngAnnotate` annotates the sources before minifying. That is, it allows us
 * to code without the array syntax.
 */
module.exports =
{
  build: {
    files: { '<%= compile_targets.js %>': '<%= compile_targets.js %>' }
  },
  build_vendor: {
    files: { '<%= compile_targets.vender_js %>': '<%= compile_targets.vendor_js %>' }
  },
  compile: {
    files: { '<%= compile_targets.js %>': '<%= compile_targets.js %>' }
  },
  test: {
    files: { '<%= build_dirs.test%>/test-main.js': '<%= build_dirs.test%>/test-main.js' }
  }
};
