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

  function addItem(type, item, extra){
    console.history.push({
      time: (new Date()).toString(),
      value: serializable(item),
      type: type,
      extra: extra
    });
  }

  function decorate(name, processFn) {
    var undecorated = console[name];
    console[name] = function(){
      processFn.apply(null, arguments);
      undecorated.apply(console, arguments);
    };
  }

  console.history = console.history || [];

  decorate('log', function(){
    for( var arg of arguments ){ addItem('message', arg, 'log'); }
  });
  decorate('warn', function(){
    for( var arg of arguments ){ addItem('message', arg, 'warn'); }
  });
  decorate('error', function(){
    for( var arg of arguments ){ addItem('message', arg, 'error'); }
  });

  decorate('group', function(){
    addItem('groupStart', null);
  });
  decorate('groupCollapsed', function(){
    addItem('groupStart', null);
  });
  decorate('groupEnd', function(){
    addItem('groupEnd', null);
  });

  decorate('table', function(){
    addItem('table', Array.prototype.slice.call(arguments)[0]);
  });
})();
