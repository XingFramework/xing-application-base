import jsonpath from 'framework/jsonpath.js';

describe('JsonPath', function() {
  describe('getting arrays', function() {
    var json = {
      'a': {
        'b': {
          'c': {
            'd': 17
          }
        }
      }
    };

    it('should get the wrapped value', function() {
      var result = jsonpath(json, "$.a..d");
      expect(result).toEqual([17]);
    });

    it('should get the value', function() {
      var result = jsonpath(json, "$.a..d", {wrap: false});
      expect(result).toEqual(17);
    });

    it('should get the array path', function() {
      var result = jsonpath(json, "$.a..d", {resultType: "path", wrap: false });
      expect(result).toEqual(["$", "a", "b", "c", "d"]);
    });

    it('should speculate about array path', function() {
      var result = jsonpath(json, "$.x..z", {resultType: "path", wrap: false });
      expect(result).toEqual(false);
    });
  });
});
