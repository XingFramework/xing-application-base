module.exports =
{
  options: {
    includeRuntime: false,
    traceurOptions: {
      arrayComprehension: true,
      sourceMaps: true,
      annotations: true,
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
        annotations: true
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
        annotations: true
      }
    },
    files: { '<%= build_dirs.test%>/test-main.js': '<%= app_files.jsunit %>' }
  },
  es6src: {
    options: {
      srcDir: '<%= app_files.js_dir %>',
      destDir: '<%= build_dir %>/<%= app_files.js_dir %>-es6',
      traceurOptions: {
        arrayComprehension: true,
        sourceMaps: false,
        annotations: true,
        outputLanguage: 'es6'
      }
    }
  },
  es6test: {
    options: {
      srcDir: '<%= app_files.test_dir %>',
      destDir: '<%= build_dir %>/<%= app_files.test_dir %>-es6',
      traceurOptions: {
        arrayComprehension: true,
        sourceMaps: false,
        annotations: true,
        outputLanguage: 'es6'
      }
    }
  },
  es6testhelp: {
    options: {
      srcDir: '<%= app_files.test_help_dir %>',
      destDir: '<%= build_dir %>/<%= app_files.test_help_dir %>-es6',
      traceurOptions: {
        arrayComprehension: true,
        sourceMaps: false,
        annotations: true,
        outputLanguage: 'es6'
      }
    }
  }
};
