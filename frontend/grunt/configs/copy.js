/**
 * The `copy` task just copies files from A to B. We use it here to copy
 * our project assets (images, fonts, etc.) and javascripts into
 * `build_dir`, and then to copy the assets to `compile_dir`.
 */
module.exports = function(grunt) {
  return {
    "authoritative-fixtures": {
      files: [
        {
        cwd: 'spec/fixtures',
        src: [ '**' ],
        dest: 'test/json-fixtures',
        expand: true
        }
      ]
    },
    "test-env": {
      files: {
        "src/common/environment.js": "config/environments/test.js"
      }
    },
    "production-env": {
      files: {
        "src/common/environment.js": "config/environments/production.js"
      }
    },
    "development-env": {
      files: {
        "src/common/environment.js": "config/environments/development.js"
      }
    },
    "integration-env": {
      files: {
        "src/common/environment.js": "config/environments/integration.js"
      }
    },

    traceur_runtime: {
      files: {
        "bin/assets/traceur-runtime.js": "./node_modules/traceur/bin/traceur-runtime.js",
      }
    },

    karmaUnit: {
      options: { process: function( contents, path ) { return grunt.template.process( contents ); } },
      files: { '<%= build_dirs.root %>/karma-unit.js': ['karma/karma-unit.tpl.js'] }
    },

    vendor_fonts: {
      files: [ {
        expand: true,
        src: ["node_modules/froala-editor/**/*.eot", "node_modules/froala-editor/**/*.ttf", "node_modules/froala-editor/**/*.woff", "node_modules/froala-editor/**/fontawesome-webfont.svg"],
        flatten: true,
        dest: "bin/fonts"
      }]
    },

    build_app_assets: {
      files: [ {
        src: [ '**' ],
        dest: '<%= build_dirs.assets %>',
        cwd: 'src/assets',
        expand: true
      } ]
    },
    build_vendor_assets: {
      files: [ {
        src: [ '<%= vendor_files.assets %>' ],
        dest: '<%= build_dirs.assets %>',
        cwd: '.',
        expand: true,
        flatten: true
      } ]
    },
    compile_assets: {
      files: [ {
        src: [ '**' ],
        dest: '<%= compile_dir %>/assets',
        cwd: '<%= build_dirs.assets %>',
        expand: true
      } ]
    }
  };
}
