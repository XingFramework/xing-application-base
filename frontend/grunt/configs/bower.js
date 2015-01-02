module.exports =
{
  install: {
    dest: 'vendor',
    options: {
      expand: true,
      packageSpecific: {
        'breakpoint-sass': {
          files: [
            'stylesheets/**'
          ]
        },
        'sass-import-once': {
          files: [
            '_sass-import-once.scss'
          ]
        },
        'compass-vanilla': {
          files: [
            'compass/stylesheets/**'
          ]
        },
        'sassy-buttons': {
          files: [
            "**"
          ]
        },
        'singularity': {
          files: [
            "stylesheets/**"
          ]
        }
      }
    }
  }
};
