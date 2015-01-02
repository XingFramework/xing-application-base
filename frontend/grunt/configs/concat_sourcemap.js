/**
 * `grunt concat` concatenates multiple source files into a single file.
 */
module.exports =
{
  options: {
    sourcesContent: true
  },
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
    options: {
      sourcesContent: false
    },
    files: {
      '<%= compile_targets.js %>': [
        '<%= compile_targets.vendor_js %>',
        '<%= compile_targets.js %>'
      ]
    }
  }
};
