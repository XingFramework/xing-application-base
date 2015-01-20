module.exports =
{
  options: {
    includeRuntime: false,
    traceurOptions: {
      arrayComprehension: true,
      sourceMaps: true,
      atscript: true
    }
  },
  build: {
    files: { '<%= compile_targets.js %>': '<%= app_files.js_roots %>' }
  },
  deploy: {
    options: {
      includeRuntime: true,
      traceurOptions: {
        arrayComprehension: true,
        sourceMaps: true,
        atscript: true
      }
    },
    files: { '<%= compile_targets.js %>': '<%= app_files.js_roots %>' }
  },
  test: {
    options: {
      includeRuntime: false
    },
    files: { '<%= build_dirs.test%>/test-main.js': '<%= app_files.jsunit %>' }
  }
};
