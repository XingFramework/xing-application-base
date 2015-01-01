var liveReloadPort = require('../support/liveReloadPort.js');

module.exports = {
  server: {
    options: {
      debug: true,
      open: true,
      port: 9000,
      hostname: 'localhost',
      livereload: liveReloadPort,
      middleware: function(connect, options, middlewares) {
        middlewares.unshift(function(req, res, next) {
          if(/application\/json/.test(req.headers["accept"])){
            res.setHeader("Content-Type", "application/json");
            res.setHeader("X-Judson-Irritation", "extreme");
            req.url = req.url + ".json";
            console.log("Next was rewritten to:", req.url);
          }
          next();
        });

        return middlewares;
      },
      base: [
        './bin',
        '../dummy-api'
      ]
    }
  }
};
