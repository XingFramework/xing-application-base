/**
 * The directories to delete when `grunt clean` is executed.
 */
module.exports =
{
  fixtures: [
    'test/json-fixtures'
  ],
  build: [
    '<%= build_dirs.root %>',
    '<%= compile_dir %>',
    'vendor'
  ]
};
