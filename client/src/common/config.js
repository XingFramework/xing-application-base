import {} from '../../vendor/angular/angular';
import { environment } from "./environment";

export var serverUrl = environment.serverUrl;
export var appName = "Reasoning";
export var configuration = { serverUrl, appName };

if(environment.name){
  configuration.appTitle = `${configuration.appName} - ${environment.name}`;
} else {
  configuration.appTitle = configuration.appName;
}
angular.module(configuration.appName + '.config', []).constant('configuration', configuration);
