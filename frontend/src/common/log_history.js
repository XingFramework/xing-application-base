// very simple console wrapper to preserve history
(function(){
  if (!console.undecorated_log) {
    console.undecorated_log = console.log;
    console.history = console.history || [];
    console.log = function(){
      for (var arg of arguments) {
        console.history.push(arg);
      }
      console.undecorated_log.apply(console, arguments);
    };
  }
})();
