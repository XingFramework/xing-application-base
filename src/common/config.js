import { environment } from "./environment";
export var configuration = {
  serverUrl: environment.serverUrl,
  appName: "Reasoning"
};

if(environment.name){
  configuration.appTitle = `${configuration.appTitle} - ${environment.name}`;
} else {
  configuration.appTitle = configuration.appName;
}
angular.module(configuration.appName + '.config', []).constant('configuration', configuration);
