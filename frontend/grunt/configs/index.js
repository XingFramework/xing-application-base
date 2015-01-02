/**
 * The `index` task compiles the `index.html` file as a Grunt template. CSS
 * and JS files co-exist here but they get split apart later.
 */
module.exports =
{

  /**
   * When it is time to have a completely compiled application, we can
   * alter the above to include only a single JavaScript and a single CSS
   * file. Now we're back!
   */
  build: {
    dir: '<%= compile_dir %>',
    src: [
      "bin/assets/traceur-runtime.js",
      '<%= compile_targets.vendor_js %>',
      '<%= compile_targets.js %>',
      '<%= compile_targets.css %>'
    ]
  },

  deploy: {
    production: true,
    dir: '<%= compile_dir %>',
    src: [
      '<%= compile_targets.js %>',
      '<%= compile_targets.css %>'
    ]
  }
};
