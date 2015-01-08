module.exports = {
  all: {
    files: [
      {
        expand: true,     // Enable dynamic expansion.
        cwd: '<%= compile_dir %>/assets/',      // Src matches are relative to this path.
        src: ['**/*.js'], // Actual pattern(s) to match.
        dest: '<%= compile_dir %>/assets/',   // Destination path prefix.
        ext: '.js.gz',   // Dest filepaths will have this extension.
        extDot: 'last'   // Extensions in filenames begin after the first dot
      },
      {
        expand: true,     // Enable dynamic expansion.
        cwd: '<%= compile_dir %>/assets/',      // Src matches are relative to this path.
        src: ['**/*.css'], // Actual pattern(s) to match.
        dest: '<%= compile_dir %>/assets/',   // Destination path prefix.
        ext: '.css.gz',   // Dest filepaths will have this extension.
        extDot: 'last'   // Extensions in filenames begin after the first dot
      },
    ]
  }
}
