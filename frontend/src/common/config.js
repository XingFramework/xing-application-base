import {} from '../../vendor/angular/angular';
import { environment } from "./environment";

export var backendUrl = environment.backendUrl;
export var appName = "LRD-CMS2";
export var configuration = { backendUrl, appName };

if(environment.name){
  configuration.appTitle = `${configuration.appName} - ${environment.name}`;
} else {
  configuration.appTitle = configuration.appName;
}
angular.module(configuration.appName + '.config', []).constant('configuration', configuration);