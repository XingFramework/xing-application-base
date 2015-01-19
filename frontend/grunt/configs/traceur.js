module.exports =
{
  options: {
    includeRuntime: false,
    traceurRuntime: "./node_modules/traceur/bin/traceur-runtime.js",
    traceurCommand: "./node_modules/.bin/traceur",
    traceurOptions: "--array-comprehension true --source-maps --moduleName +"
  },
  build: {
    files: { '<%= compile_targets.js %>': '<%= app_files.js_roots %>' }
  },
  deploy: {
    options: {
      includeRuntime: true,
      traceurOptions: "--array-comprehension true --source-maps --atscript"
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
