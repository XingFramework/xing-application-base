module.exports =
{
  options: {
    sassDir: '<%= app_files.stylesheets %>',
    cssDir: '<%= build_dirs.stylesheets %>'
  },
  build: {
  },
  server: {
    options: {
      watch: true
    }
  }
};
