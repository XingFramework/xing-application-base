var traceurAPI = require("traceur");
var glob = require("glob");
var fs = require("fs");
var path  = require("path");
var Promise = require("es6-promise").Promise;


// adapted from traceur/src/node/compileAllJsFilesInDir.js
//   -> added promises
function compileAllJsFilesInDir(inputDir, outputDir, options) {
  inputDir = path.normalize(inputDir).replace(/\\/g, '/');
  outputDir = path.normalize(outputDir).replace(/\\/g, '/');
  return new Promise(function(resolve, reject){
    glob(inputDir + '/**/*.js', {}, function (er, files) {
      if(er){
        reject(Error(er));
      } else {
        resolve(files);
      }
    });
  }).then(function(files){
    //adapted from:
    //compiler.compileSingleFile(inputFilePath, outputFilePath, function(err) {
    var compiler = new traceurAPI.NodeCompiler(options);
    return Promise.all(files.map(function(inputFilePath){
      var outputFilePath = inputFilePath.replace(inputDir, outputDir);
      inputFilePath = compiler.normalize(inputFilePath);
      outputFilePath = compiler.normalize(outputFilePath);

      return new Promise(function(resolve, reject) {

        fs.readFile(inputFilePath, function(err, contents) {
          if (err) {
            reject(Error(err));
          } else {
            resolve(contents);
          }
        }.bind(this));
      })
      .then(function(contents){      return compiler.parse(contents.toString(), inputFilePath); })
      .then(function(parsed){        return compiler.transform(parsed, inputFilePath) })
      .then(function(transformed){   return compiler.writeTreeToFile(transformed, outputFilePath); })
      .then(function(written){       return {in: inputFilePath, out: outputFilePath}; });
    }));
  });
}

function ensureDir(dir, promise){
  return promise;

  /*
  return promise.then(
    function(res){
    process.chdir(dir);
    return res;
  },
  function(rej){
    process.chdir(dir);
    throw rej;
  });
  */
};

// take from traceur/src/node/command.js
function compileAll(out, sources, options) { // -> Promise
  var cwd = process.cwd();
  var isSingleFileCompile = /\.js$/.test(out);
  if (!isSingleFileCompile) {
    return traceurAPI.forEachRecursiveModuleCompile(out, sources, options); // ret Promise
  } else {
    return traceurAPI.recursiveModuleCompileToSingleFile(out, sources, options); // ret Promise
  }
}

// taken from traceur/src/node/command.js
function globSources(sourcesToGlob) { // -> Promise([{name,type,format}])
  var processedCount = 0;
  var globbedSources = [];
  return Promise.all(sourcesToGlob.map(function(item) {
    return new Promise(function(resolve, reject){
      glob(item.name, {}, function(err, matches) {
        if (err) {
          reject( Error('While scanning ' + item.name + ': ' + err));
        } else {
          resolve(matches.map(function(match){
            return {
              name: match,
              type: item.type,
              format: item.format
            };
          }));
        }
      });
    });
  })).then(function(listOfGlobbeds){
    return listOfGlobbeds.reduce(function(one, two){
      return one.concat(two);
    }, [])
  });
}

// take from traceur/src/node/command.js
function recursiveCompile(out, rootSources, commandOptions) {
  var sourcesToGlob = [];
  var processedSources = [];

  rootSources.forEach(function(item){
    if (glob.hasMagic(item.name)) {
      sourcesToGlob.push(item);
    } else {
      processedSources.push(item);
    }
  });

  return Promise.all([
    Promise.resolve(processedSources),
    globSources(sourcesToGlob)
  ]).then(function(sourceLists){
    return compileAll(out, sourceLists[0].concat(sourceLists[1]), commandOptions);
  });
}

function buildOptions(traceurOptions) {
  var options = new traceurAPI.util.CommandOptions();
  options.setFromObject(traceurOptions);
  options.sourceMaps = traceurOptions.sourceMaps;
  return options;
}

module.exports = {
  recursiveCompile: recursiveCompile,
  compileAllJsFilesInDir: compileAllJsFilesInDir,
  buildOptions: buildOptions,
  RUNTIME_PATH: traceurAPI.RUNTIME_PATH
}
