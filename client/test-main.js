tests = [];
for (var file in window.__karma__.files) {
  if (window.__karma__.files.hasOwnProperty(file)) {
    if (/test\/.*.js$/.test(file)) {
      tests.push(file);
    }
  }
}
tests = tests.map(function(file){
  return file.replace(/^\/base\/|\.js$/g,'');
})

console.log("./test-main.js:13", "window.__karma__.files", window.__karma__.files);
console.log("test/test-main.js:12", "tests", tests);

requirejs.config({
  baseUrl: '/base/',
  deps: tests,
  callback: window.__karma__.start
});
