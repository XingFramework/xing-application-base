var traceurOptions = {
      arrayComprehension: true,
      sourceMaps: true,
      annotations: true,
      memberVariables: true,
      types: true
    };

var traceurES6options = {
        arrayComprehension: true,
        sourceMaps: false,
        annotations: true,
        memberVariables: true,
        types: true,
        outputLanguage: 'es6'
      };

module.exports =
{
  options: {
    includeRuntime: false,
    traceurOptions: traceurOptions,
    moduleMaps: {
      "build": "../../build",
      "common": "../../src/common",
      "components": "../../src/common/components",
      "resources": "../../src/common/resources",
      "a1atscript": "../../node_modules/a1atscript/src/a1atscript.js",
      "xing-inflector": "../../node_modules/xing-inflector/dist/xing-inflector.js",
      "xing-serializer": "../../node_modules/xing-serializer/dist/xing-serializer.js",
      "xing-frontend-utils": "../../node_modules/xing-frontend-utils/src/xing-frontend-utils.js",
      "config": "../../src/common/config.js",
      "backend": "../../src/framework/backend",
      "relayer": "../../node_modules/relayer/dist/relayer.js",
      "stateInjector": "../../node_modules/xing-frontend-utils/src/xing-frontend-utils/stateInjector.js",
      "stateClasses": "../../node_modules/xing-frontend-utils/src/xing-frontend-utils/stateClasses.js",
      // Example for multi-platform setups:
      //"../../../web/src/app/app.js": {
      //  "frontend": "../..",
      //  "common": "../../src/common",
      //  "app": "../../src/app"
      //}
    }

    },
  build: {
    files: { '<%= compile_targets.js %>': '<%= app_files.js_roots %>' }
  },
  deploy: {
    options: {
      includeRuntime: true,
      traceurOptions: traceurOptions
    },
    files: { '<%= compile_targets.js %>': '<%= app_files.js_roots %>' }
  },
  test: {
    options: {
      includeRuntime: true,
      traceurOptions: traceurOptions
    },
    files: { '<%= build_dirs.test%>/test-main.js': '<%= app_files.jsunit %>' }
  },
  es6src: {
    options: {
      srcDir: '<%= app_files.js_dir %>',
      destDir: '<%= build_dir %>/<%= app_files.js_dir %>-es6',
      traceurOptions: traceurES6options
    }
  },
  es6test: {
    options: {
      srcDir: '<%= app_files.test_dir %>',
      destDir: '<%= build_dir %>/<%= app_files.test_dir %>-es6',
      traceurOptions: traceurES6options
    }
  },
  es6testhelp: {
    options: {
      srcDir: '<%= app_files.test_help_dir %>',
      destDir: '<%= build_dir %>/<%= app_files.test_help_dir %>-es6',
      traceurOptions: traceurES6options
    }
  }
};
