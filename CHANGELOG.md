  * BREAKING CHANGE: Traceur updated. All calls to super() in ES6 classes must
    be updated to call super.instanceMethod() unless in a constructor
  * Menus are now retreived as a list from the server. backend.menu(name)
    searches that list and GETs the matching Menu if any. Note that
    backend.menu(name) returns a Promise of the Menu to be retrieved.
  * Changelog wrapped at 76 characters.

0.0.1 / 2015-01-19
==================

  * Initial Release
