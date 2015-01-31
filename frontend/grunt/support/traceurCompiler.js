var traceur = require("traceur");
var glob = require("glob");
var fs = require("fs");
var path  = require("path");
var Promise = require("es6-promise").Promise;

var options = {}

function globSources(sourcesToGlob, cb) {
  var processedCount = 0;
  var globbedSources = [];
  sourcesToGlob.forEach(function(item) {
    glob(item.name, {}, function(err, matches) {
      if (err)
        throw new Error('While scanning ' + item.name + ': ' + err);
      for (var i = matches.length - 1; i >= 0; i--) {
        var globbedSource = {
          name: matches[i],
          type: item.type,
          format: item.format
        };
        globbedSources.push(globbedSource);
      }
      processedCount++;
      if (processedCount === sourcesToGlob.length) {
        cb(null, globbedSources);
      }
    });
  });
}

function recursiveCompile(out, rootSources) {
  var sourcesToGlob = [];
  var processedSources = [];

  for (var i = 0; i < rootSources.length; i++) {
    if (glob.hasMagic(rootSources[i].name)) {
      sourcesToGlob.push(rootSources[i]);
    } else {
      processedSources.push(rootSources[i]);
    }
  }
  if (!sourcesToGlob.length) {
    return traceur.recursiveModuleCompileToSingleFile(out, processedSources, options);
  } else {
    globSources(sourcesToGlob, function(err, globbedSources) {
      processedSources.push.apply(processedSources, globbedSources);
      if (processedSources.length) {

        return traceur.recursiveModuleCompileToSingleFile(out, processedSources, options);
      }
    });
  }
}

function compileAllJsFilesInDir(inputDir, outputDir) {
  inputDir = path.normalize(inputDir).replace(/\\/g, '/');
  outputDir = path.normalize(outputDir).replace(/\\/g, '/');
  files = glob.sync(inputDir + '/**/*.js', {});
  var NodeCompiler = traceur.NodeCompiler;

  return Promise.all(
    files.map(function(inputFilePath) {
      return new Promise(function(resolve, reject) {

      var outputFilePath = inputFilePath.replace(inputDir, outputDir);
      var compiler = new NodeCompiler(options);
      inputFilePath = compiler.normalize(inputFilePath);
      outputFilePath = compiler.normalize(outputFilePath);
        fs.readFile(inputFilePath, function(err, contents) {
            if (err) {
              reject(err)
            }

            var parsed = compiler.parse(contents.toString(), inputFilePath);
            compiler.writeTreeToFile(compiler.transform(parsed, undefined, inputFilePath),
                               outputFilePath);
            resolve();
        }.bind(this));
      });
    })
  );
}

function setOptions(traceurOptions) {
  options = new traceur.util.CommandOptions();
  options.setFromObject(traceurOptions);
  options.sourceMaps = traceurOptions.sourceMaps;
  traceur.options.setFromObject(options);
}

module.exports = {
  recursiveCompile: recursiveCompile,
  compileAllJsFilesInDir: compileAllJsFilesInDir,
  setOptions: setOptions,
  RUNTIME_PATH: traceur.RUNTIME_PATH
}
