import Inflector from './inflector';
import {Module, Factory, Provider} from 'a1atscript'

@Provider('Serializer')
function SerializerProvider() {
  var defaultOptions = {
    underscore: undefined,
    camelize: undefined,
    pluralize: undefined,
    exclusionMatchers: []
  };

  /**
   * Configures the underscore method used by the serializer.  If not defined then <code>RailsInflector.underscore</code>
   * will be used.
   *
   * @param {function(string):string} fn The function to use for underscore conversion
   * @returns {railsSerializerProvider} The provider for chaining
   */
  this.underscore = function(fn) {
    defaultOptions.underscore = fn;
    return this;
  };

  /**
   * Configures the camelize method used by the serializer.  If not defined then <code>RailsInflector.camelize</code>
   * will be used.
   *
   * @param {function(string):string} fn The function to use for camelize conversion
   * @returns {railsSerializerProvider} The provider for chaining
   */
  this.camelize = function(fn) {
    defaultOptions.camelize = fn;
    return this;
  };

  /**
   * Configures the pluralize method used by the serializer.  If not defined then <code>RailsInflector.pluralize</code>
   * will be used.
   *
   * @param {function(string):string} fn The function to use for pluralizing strings.
   * @returns {railsSerializerProvider} The provider for chaining
   */
  this.pluralize = function(fn) {
    defaultOptions.pluralize = fn;
    return this;
  };

  /**
   * Configures the array exclusion matchers by the serializer.  Exclusion matchers can be one of the following:
   * * string - Defines a prefix that is used to test for exclusion
   * * RegExp - A custom regular expression that is tested against the attribute name
   * * function - A custom function that accepts a string argument and returns a boolean with true indicating exclusion.
   *
   * @param {Array.<string|function(string):boolean|RegExp} exclusions An array of exclusion matchers
   * @returns {railsSerializerProvider} The provider for chaining
   */
  this.exclusionMatchers = function(exclusions) {
    defaultOptions.exclusionMatchers = exclusions;
    return this;
  };

  this.$get = ['$injector', 'Inflector', function ($injector, Inflector) {
    defaultOptions.underscore = defaultOptions.underscore || Inflector.underscore;
    defaultOptions.camelize = defaultOptions.camelize || Inflector.camelize;
    defaultOptions.pluralize = defaultOptions.pluralize || Inflector.pluralize;

    function Serializer() {

      this.exclusions = {};
      this.inclusions = {};
      this.serializeMappings = {};
      this.deserializeMappings = {};
      this.customSerializedAttributes = {};
      this.preservedAttributes = {};
      this.options = angular.extend({excludeByDefault: false}, defaultOptions || {});
    }

    /**
     * Accepts a variable list of attribute names to exclude from JSON serialization.
     *
     * @param attributeNames... {string} Variable number of attribute name parameters
     * @returns {Serializer} this for chaining support
     */
    Serializer.prototype.exclude = function () {
      var exclusions = this.exclusions;

      angular.forEach(arguments, function (attributeName) {
        exclusions[attributeName] = false;
      });

      return this;
    };

    /**
     * Accepts a variable list of attribute names that should be included in JSON serialization.
     * Using this method will by default exclude all other attributes and only the ones explicitly included using <code>only</code> will be serialized.
     * @param attributeNames... {string} Variable number of attribute name parameters
     * @returns {Serializer} this for chaining support
     */
    Serializer.prototype.only = function () {
      var inclusions = this.inclusions;
      this.options.excludeByDefault = true;

      angular.forEach(arguments, function (attributeName) {
        inclusions[attributeName] = true;
      });

      return this;
    };

    /**
     * Specifies a custom name mapping for an attribute.
     * On serializing to JSON the jsonName will be used.
     * On deserialization, if jsonName is seen then it will be renamed as javascriptName in the resulting resource.
     *
     * @param javascriptName {string} The attribute name as it appears in the JavaScript object
     * @param jsonName {string} The attribute name as it should appear in JSON
     * @param bidirectional {boolean} (optional) Allows turning off the bidirectional renaming, defaults to true.
     * @returns {Serializer} this for chaining support
     */
    Serializer.prototype.rename = function (javascriptName, jsonName, bidirectional) {
      this.serializeMappings[javascriptName] = jsonName;

      if (bidirectional || bidirectional === undefined) {
        this.deserializeMappings[jsonName] = javascriptName;
      }
      return this;
    };

    /**
     * Allows custom attribute creation as part of the serialization to JSON.
     *
     * @param attributeName {string} The name of the attribute to add
     * @param value {*} The value to add, if specified as a function then the function will be called during serialization
     *     and should return the value to add.
     * @returns {Serializer} this for chaining support
     */
    Serializer.prototype.add = function (attributeName, value) {
      this.customSerializedAttributes[attributeName] = value;
      return this;
    };


    /**
     * Allows the attribute to be preserved unmodified in the resulting object.
     *
     * @param attributeName {string} The name of the attribute to add
     * @returns {Serializer} this for chaining support
     */
    Serializer.prototype.preserve = function(attributeName) {
      this.preservedAttributes[attributeName] =  true;
      return this;
    };

    /**
     * Determines whether or not an attribute should be excluded.
     *
     * If the option excludeByDefault has been set then attributes will default to excluded and will only
     * be included if they have been included using the "only" customization function.
     *
     * If the option excludeByDefault has not been set then attributes must be explicitly excluded using the "exclude"
     * customization function or must be matched by one of the exclusionMatchers.
     *
     * @param attributeName The name of the attribute to check for exclusion
     * @returns {boolean} true if excluded, false otherwise
     */
    Serializer.prototype.isExcludedFromSerialization = function (attributeName) {
      if ((this.options.excludeByDefault && !this.inclusions.hasOwnProperty(attributeName)) || this.exclusions.hasOwnProperty(attributeName)) {
        return true;
      }

      if (this.options.exclusionMatchers) {
        var excluded = false;

        angular.forEach(this.options.exclusionMatchers, function (matcher) {
          if (angular.isString(matcher)) {
            excluded = excluded || attributeName.indexOf(matcher) === 0;
          } else if (angular.isFunction(matcher)) {
            excluded = excluded || matcher.call(undefined, attributeName);
          } else if (matcher instanceof RegExp) {
            excluded = excluded || matcher.test(attributeName);
          }
        });

        return excluded;
      }

      return false;
    };

    /**
     * Remaps the attribute name to the serialized form which includes:
     *   - checking for exclusion
     *   - remapping to a custom value specified by the rename customization function
     *   - underscoring the name
     *
     * @param attributeName The current attribute name
     * @returns {*} undefined if the attribute should be excluded or the mapped attribute name
     */
    Serializer.prototype.getSerializedAttributeName = function (attributeName) {
      var mappedName = this.serializeMappings[attributeName] || attributeName;

      var mappedNameExcluded = this.isExcludedFromSerialization(mappedName),
      attributeNameExcluded = this.isExcludedFromSerialization(attributeName);

      if(this.options.excludeByDefault) {
        if(mappedNameExcluded && attributeNameExcluded) {
          return undefined;
        }
      } else {
        if (mappedNameExcluded || attributeNameExcluded) {
          return undefined;
        }
      }

      return this.underscore(mappedName);
    };

    /**
     * Determines whether or not an attribute should be excluded from deserialization.
     *
     * By default, we do not exclude any attributes from deserialization.
     *
     * @param attributeName The name of the attribute to check for exclusion
     * @returns {boolean} true if excluded, false otherwise
     */
    Serializer.prototype.isExcludedFromDeserialization = function (attributeName) {
      return false;
    };

    /**
     * Remaps the attribute name to the deserialized form which includes:
     *   - camelizing the name
     *   - checking for exclusion
     *   - remapping to a custom value specified by the rename customization function
     *
     * @param attributeName The current attribute name
     * @returns {*} undefined if the attribute should be excluded or the mapped attribute name
     */
    Serializer.prototype.getDeserializedAttributeName = function (attributeName) {
      var camelizedName = this.camelize(attributeName);

      camelizedName = this.deserializeMappings[attributeName] ||
        this.deserializeMappings[camelizedName] ||
        camelizedName;

      if (this.isExcludedFromDeserialization(attributeName) || this.isExcludedFromDeserialization(camelizedName)) {
        return undefined;
      }

      return camelizedName;
    };

    /**
     * Prepares the data for serialization to JSON.
     *
     * @param data The data to prepare
     * @returns {*} A new object or array that is ready for JSON serialization
     */
    Serializer.prototype.serializeValue = function (data) {
      var result = data,
      self = this;

      if (angular.isArray(data)) {
        result = [];

        angular.forEach(data, function (value) {
          result.push(self.serializeValue(value));
        });
      } else if (angular.isObject(data)) {
        if (angular.isDate(data)) {
          return data;
        }
        result = {};

        angular.forEach(data, function (value, key) {
          // if the value is a function then it can't be serialized to JSON so we'll just skip it
          if (!angular.isFunction(value)) {
            self.serializeAttribute(result, key, value);
          }
        });
      }

      return result;
    };

    /**
     * Transforms an attribute and its value and stores it on the parent data object.  The attribute will be
     * renamed as needed and the value itself will be serialized as well.
     *
     * @param data The object that the attribute will be added to
     * @param attribute The attribute to transform
     * @param value The current value of the attribute
     */
    Serializer.prototype.serializeAttribute = function (data, attribute, value) {
      var serializedAttributeName = this.getSerializedAttributeName(attribute);

      // undefined means the attribute should be excluded from serialization
      if (serializedAttributeName === undefined) {
        return;
      }

      data[serializedAttributeName] = this.serializeValue(value);
    };

    /**
     * Serializes the data by applying various transformations such as:
     *   - Underscoring attribute names
     *   - attribute renaming
     *   - attribute exclusion
     *   - custom attribute addition
     *
     * @param data The data to prepare
     * @returns {*} A new object or array that is ready for JSON serialization
     */
    Serializer.prototype.serialize = function (data) {
      var result = this.serializeValue(data),
      self = this;

      if (angular.isObject(result)) {
        angular.forEach(this.customSerializedAttributes, function (value, key) {
          if (angular.isFunction(value)) {
            value = value.call(data, data);
          }

          self.serializeAttribute(result, key, value);
        });
      }

      return result;
    };

    /**
     * Iterates over the data deserializing each entry on arrays and each key/value on objects.
     *
     * @param data The object to deserialize
     * @param Resource (optional) The resource type to deserialize the result into
     * @returns {*} A new object or an instance of Resource populated with deserialized data.
     */
    Serializer.prototype.deserializeValue = function (data) {
      var result = data,
      self = this;

      if (angular.isArray(data)) {
        result = [];

        angular.forEach(data, function (value) {
          result.push(self.deserializeValue(value));
        });
      } else if (angular.isObject(data)) {
        if (angular.isDate(data)) {
          return data;
        }

        result = {};


        angular.forEach(data, function (value, key) {
          self.deserializeAttribute(result, key, value);
        });
      }

      return result;
    };

    /**
     * Transforms an attribute and its value and stores it on the parent data object.  The attribute will be
     * renamed as needed and the value itself will be deserialized as well.
     *
     * @param data The object that the attribute will be added to
     * @param attribute The attribute to transform
     * @param value The current value of the attribute
     */
    Serializer.prototype.deserializeAttribute = function (data, attribute, value) {
      var attributeName = this.getDeserializedAttributeName(attribute);

      // undefined means the attribute should be excluded from serialization
      if (attributeName === undefined) {
        return;
      }

      // preserved attributes are assigned unmodified
      if (this.preservedAttributes[attributeName]) {
        data[attributeName] = value;
      } else {
        data[attributeName] = this.deserializeValue(value);
      }
    };

    /**
     * Deserializes the data by applying various transformations such as:
     *   - Camelizing attribute names
     *   - attribute renaming
     *   - attribute exclusion
     *   - nested resource creation
     *
     * @param data The object to deserialize
     * @param Resource (optional) The resource type to deserialize the result into
     * @returns {*} A new object or an instance of Resource populated with deserialized data
     */
    Serializer.prototype.deserialize = function (data) {
      // just calls deserializeValue for now so we can more easily add on custom attribute logic for deserialize too
      return this.deserializeValue(data);
    };

    Serializer.prototype.pluralize = function (value) {
      if (this.options.pluralize) {
        return this.options.pluralize(value);
      }
      return value;
    };

    Serializer.prototype.underscore = function (value) {
      if (this.options.underscore) {
        return this.options.underscore(value);
      }
      return value;
    };

    Serializer.prototype.camelize = function (value) {
      if (this.options.camelize) {
        return this.options.camelize(value);
      }
      return value;
    };

    return Serializer;
  }];
}

@Factory('RequestInterceptor', ['Serializer'])
function RequestInterceptor(Serializer) {
  var serializer = new Serializer();

  return function(elem, operation, what) {
    var retElem = elem;
    if (operation === 'post' || operation === 'put') {
      retElem = serializer.serialize(elem);
    }
    return retElem;
  };
}

@Factory('ResponseInterceptor', ['Serializer'])
function ResponseInterceptor(Serializer) {
  var serializer = new Serializer();

  return function(data, operation, what, url, response, deferred) {
    return serializer.deserialize(data);
  };
}

var Serializer = new Module('serializer', [
  Inflector,
  SerializerProvider,
  RequestInterceptor,
  ResponseInterceptor]);

export default Serializer;
