/**
 * Minify the sources!
 */
module.exports =
{
  compile: {
    options: { banner: '<%= meta.banner %>' },
    files: { '<%= compile_targets.js %>': '<%= compile_targets.js %>' }
  }
};
