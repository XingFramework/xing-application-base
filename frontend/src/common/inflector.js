import {Module, Service} from 'a1atscript';

@Module('inflector')
@Service('Inflector')
export default class Inflector {

  camelize(key) {
    if (!angular.isString(key)) {
      return key;
    }

    // should this match more than word and digit characters?
    return key.replace(/_[\w\d]/g, function (match, index, string) {
      return index === 0 ? match : string.charAt(index + 1).toUpperCase();
    });
  }

  humanize(key) {
    if (!angular.isString(key)) {
      return key;
    }

    // should this match more than word and digit characters?
    return key.replace(/_/g, ' ').replace(/(\w+)/g, function(match) {
      return match.charAt(0).toUpperCase() + match.slice(1);
    });
  }

  underscore(key) {
    if (!angular.isString(key)) {
      return key;
    }

    // TODO match the latest logic from Active Support
    return key.replace(/[A-Z]/g, function (match, index) {
      return index === 0 ? match : '_' + match.toLowerCase();
    });
  }

  dasherize(key) {
    if (!angular.isString(key)) {
      return key;
    }

    // TODO match the latest logic from Active Support
    return key.replace(/[A-Z]/g, function (match, index) {
      return index === 0 ? match : '-' + match.toLowerCase();
    });
  }

  pluralize(value) {
    // TODO match Active Support
    return value + 's';
  }
}
