Untagged 
==================
  * Update to Rails 4.1.10
  * Extract back-end framework code to backend/framework

0.0.7 / 2015-03-18
==================
  Accumulating changes for next release
  * Update to Rails 4.1.9
  * BREAKING: All non state based components moved to src/common/components
  * BREAKING: Many front-end classes are moved to frontend/src/framework
  * Loggable browser console:  front-end JS shim/console wrapper + Waterpig version bump logs
    browser console to backend/log/test_browser_console.log during feature specs
  * BREAKING: Updated traceur -- means all import statements now include .js in the title

0.0.6 / 2015-02-20
==================
  * BREAKING: Reorganization of stylesheets directory. Default styles provided by framework are now located in the styles/framework, with app-specific overrides in styles/partials or styles/states.

0.0.5 / 2015-02-17
==================
  * Move compass:watch function out of grunt and into rake develop.

0.0.4 / 2015-02-03
==================

  * Change to the rakelibs to only require files as tasks need them - was breaking Capistrano deploys
  * Updated A1AtScript and refactored several directives to use the
    A1AtScript's new DirectiveObject annotation pattern. Note: the old
    Directive annotation is still present so this is not a breaking change

0.0.3 / 2015-01-29
==================

  * BREAKING: AtScript Refactor -- while this should generally not affect
    existing code, merges to app.js may have conflicts that need resolution.
    All regular angular modules of projects should be added as dependencies of
    the main module in app.js as strings. Also, it may be important to check
    appConfig.js and rootController.js to make sure all changes are moved over.
  * Compass watch moved to top level, out of frontend

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
