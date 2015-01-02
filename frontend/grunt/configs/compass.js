module.exports =
{
  options: {
    sassDir: '<%= app_files.sass %>',
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
