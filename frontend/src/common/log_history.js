 //very simple console wrapper to preserve history
(function(){

  // Returns a version of obj without functions
  // or recursive references.  Recursive references
  // will blow out the stack when we try to
  // serialize.
  function strippedObject(obj, cache = []) {
    var newObj = {};
    for (var property in obj) {
      if (obj.hasOwnProperty(property)) {
        var value = obj[property];
        switch (typeof value) {
          case "function":
            break;
          case "object":
            if (cache.indexOf(property) == -1) {
              cache.push(property);
              newObj[property] = strippedObject(value, cache);
            }
            break;
          default:
            newObj[property] = obj[property];
        }
      }
    }
    return newObj;
  }
  function serializable(value) {
    switch (typeof value) {
      case "function":
        return "<function>";
      case "object":
        return strippedObject(value);
      default:
        return value;
    }
  }

  var undecorated_log = console.log;
  console.history = console.history || [];
  console.log = function(){
    for (var arg of arguments) {
      console.history.push({
        time: (new Date()).toString(),
        value: serializable(arg),
        type: 'message' } );
    }
    undecorated_log.apply(console, arguments);
  };

  var undecorated_table = console.table;
  console.table = function(){
    console.history.push({
      time: (new Date()).toString(),
      value:  serializable(Array.prototype.slice.call(arguments)[0]),
      type: 'table'
    });
    undecorated_table.apply(console, arguments);
  };
})();
