// very simple console wrapper to preserve history
(function(){
  if (!console.undecorated_log) {
    console.undecorated_log = console.log;
    console.history = console.history || [];
    console.log = function(){
      for (var arg of arguments) {
        console.history.push({
          time: (new Date()).toString(),
          value: arg,
          type: 'message' } );
      }
      console.undecorated_log.apply(console, arguments);
    };

    console.undecorated_table = console.table;
    console.table = function(){
      console.history.push({
        time: (new Date()).toString(),
        value:  Array.prototype.slice.call(arguments),
        type: 'table'
      });
      console.undecorated_table.apply(console, arguments);
    };
  }
})();
