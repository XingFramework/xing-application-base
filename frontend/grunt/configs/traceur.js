module.exports =
{
  options: {
    includeRuntime: false,
    traceurOptions: {
      arrayComprehension: true,
      sourceMaps: true,
      types: true,
      annotations: true,
      memberVariables: true
    },
    moduleMaps: {
      "a1atscript": "../../vendor/a1atscript/a1atscript"
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
        atscript: true,
        types: true,
        annotations: true,
        memberVariables: true
      }
    },
    files: { '<%= compile_targets.js %>': '<%= app_files.js_roots %>' }
  },
  test: {
    options: {
      includeRuntime: false,
      traceurOptions: {
        arrayComprehension: true,
        sourceMaps: true,
        atscript: true,
        types: true,
        annotations: true,
        memberVariables: true
      }
    },
    files: { '<%= build_dirs.test%>/test-main.js': '<%= app_files.jsunit %>' }
  }
};
