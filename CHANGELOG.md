0.0.3 / 2015-01-29
=================

  * BREAKING: AtScript Refactor -- while this should generally not affect existing code, merges to app.js may have conflicts that need resolution. All regular angular modules of projects should be added as dependencies of the main module in app.js as strings. Also, it may be important to check appConfig.js and rootController.js to make sure all changes are moved over.

0.0.2 / 2015-01-26
==================

  * BREAKING: Split the frontend assets and backend API servers, with support for development
    (breaking because deployments will need config changes to support)
  * Changed clearfix styles to match Compass's clearfix
  * BREAKING CHANGE: Traceur updated. All calls to super() in ES6 classes must
    be updated to call super.instanceMethod() unless in a constructor
  * Menus are now retreived as a list from the server. backend.menu(name)
    searches that list and GETs the matching Menu if any. Note that
    backend.menu(name) returns a Promise of the Menu to be retrieved.
  * Changelog wrapped at 76 characters.

0.0.1 / 2015-01-19
==================

  * Initial Release
