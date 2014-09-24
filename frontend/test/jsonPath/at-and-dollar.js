import jsonpath from '../../src/common/jsonpath';
describe('JsonPath', function() {
  describe('special property names', function() {
    var t1 = {
      simpleString: "simpleString",
      "@" : "@asPropertyName",
      "a$a": "$inPropertyName",
      "$": {
        "@": "withboth",
      },
      a: {
        b: {
          c: "food"
        }
      }
    };


    it('should test undefined, null', function() {
      // ============================================================================
      expect(jsonpath(undefined, "foo")).toEqual(undefined);
      expect(jsonpath(null, "foo")).toEqual(null);
      expect(jsonpath({}, "foo")[0]).toEqual(undefined);
      expect(jsonpath({ a: "b" }, "foo")[0]).toEqual(undefined);
      expect(jsonpath({ a: "b" }, "foo")[100]).toEqual(undefined);
    });


    it('should handle $ and @', function() {
      expect(jsonpath(t1, "$")[0]).toEqual(t1["$"]);
      expect(jsonpath(t1, "$")[0]).toEqual(t1["$"]);
      expect(jsonpath(t1, "a$a")[0]).toEqual(t1["a$a"]);
      expect(jsonpath(t1, "@")[0]).toEqual(t1["@"]);
      expect(jsonpath(t1, "@")[0]).toEqual(t1["@"]);
      expect(jsonpath(t1, "$.$.@")[0]).toEqual(t1["$"]["@"]);
      expect(jsonpath(t1, "@")[1]).toEqual(undefined);
    });
  });
});
