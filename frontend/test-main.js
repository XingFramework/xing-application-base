requireJsConfig = {
  baseUrl: '/base/',
  shim: {

  },
  callback: window.__karma__.start
};

tests = [];
for (var file in window.__karma__.files) {
  if (window.__karma__.files.hasOwnProperty(file)) {
    if (/test\/.*\.js$/.test(file)) {
      if (!/test\/json-fixtures/.test(file)) {
        tests.push(file);
      } else {
        requireJsConfig.shim[file.replace(/^\/base\/|\.js$/g,'')] = { deps: ["angular"] };
      }
    }
  }
}
requireJsConfig.deps = tests.map(function(file){
  return file.replace(/^\/base\/|\.js$/g,'');
})

requirejs.config(requireJsConfig);
