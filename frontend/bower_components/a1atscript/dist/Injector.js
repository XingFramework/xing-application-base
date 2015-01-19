import { Module } from './annotations';

import {
  ConfigInjector,
  RunInjector,
  ControllerInjector,
  DirectiveInjector,
  ServiceInjector,
  FactoryInjector,
  ProviderInjector,
  ValueInjector,
  ConstantInjector,
  AnimationInjector,
  FilterInjector
} from './injectorTypes';

var registeredInjectors = {}

export function registerInjector(name, InjectorClass) {
  registeredInjectors[name] = new InjectorClass();
}

registerInjector('config', ConfigInjector);
registerInjector('run', RunInjector);
registerInjector('controller', ControllerInjector);
registerInjector('directive', DirectiveInjector);
registerInjector('service', ServiceInjector);
registerInjector('factory', FactoryInjector);
registerInjector('provider', ProviderInjector);
registerInjector('value', ValueInjector);
registerInjector('constant', ConstantInjector);
registerInjector('animation', AnimationInjector);
registerInjector('filter', FilterInjector);

export class Injector {
  constructor() {
    registeredInjectors['module'] = this;
  }

  get annotationClass() {
    return Module;
  }

  instantiate(moduleClass) {
    var sortedDependencies = this._sortModuleDependencies(moduleClass)
    var moduleDependencies = this._instantiateModuleDependencies(sortedDependencies.module)
    var moduleName = moduleClass.token;
    var instantiatedModule = angular.module(moduleName, moduleDependencies);
    delete sortedDependencies.module;
    this._instantiateOtherDependencies(sortedDependencies, instantiatedModule);
    return moduleName;
  }

  _getDependencyType(dependency) {
    var annotations = dependency.annotations;
    for (var i=0; i < annotations.length; i++) {
      var annotation = annotations[i];
      var foundInjector = Object.keys(registeredInjectors).find(
        (key) => annotation instanceof registeredInjectors[key].annotationClass);
      if (foundInjector) {
        return {
          key: foundInjector,
          metadata: annotation
        };
      }
    }
    return null;
  }

  _mergeSortedDependencies(sorted1, sorted2) {
    var newSorted = {}
    Object.assign(newSorted, sorted1)
    Object.keys(sorted2).forEach((key) => {
      if (newSorted[key]) {
        newSorted[key] = newSorted[key].concat(sorted2[key]);
      } else {
        newSorted[key] = sorted2[key];
      }
    });
    return newSorted;
  }

  _sortDependency(dependency) {
    var sorted = {};

    if (typeof dependency === "string" || dependency instanceof Module) {
      sorted.module = [dependency];
    } else if (dependency.annotations) {
      var dependencyType = this._getDependencyType(dependency);
      if (dependencyType) {
        sorted[dependencyType.key] = [{
          dependency: dependency,
          metadata: dependencyType.metadata
        }];
      }
    } else {
      Object.keys(dependency).forEach((key) => {
        subDepenency = dependency[key];
        sortedSubDependencies = this._sortDependency(subDepenency);
        sorted = this._mergeSortedDependencies(sorted, sortedSubDependencies);
      });
    }
    return sorted;
  }

  _sortModuleDependencies(moduleClass) {
    var sorted = {};
    moduleClass.dependencies.forEach((dependency) => {
      var newSortedDependencies = this._sortDependency(dependency);
      sorted = this._mergeSortedDependencies(sorted, newSortedDependencies);
    });

    return sorted;
  }

  _moduleMetadata(moduleClass) {
    return moduleClass.annotations.find((value) => value instanceof Module);
  }

  _instantiateModuleDependencies(moduleDependencies) {
    var returnedDependencies = [];

    if (moduleDependencies) {
      moduleDependencies.forEach((moduleDependency) => {
        if (typeof moduleDependency === "string") {
          returnedDependencies.push(moduleDependency);
        } else {
          returnedDependencies.push(this.instantiate(moduleDependency));
        }
      });

    }

    return returnedDependencies;
  }

  _instantiateOtherDependencies(sortedDependencies, instantiatedModule) {
    Object.keys(sortedDependencies).forEach((dependencyType) => {
      registeredInjectors[dependencyType].instantiate(
        instantiatedModule,
        sortedDependencies[dependencyType]
      );
    });
  }
}
