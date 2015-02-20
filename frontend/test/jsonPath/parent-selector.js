import jsonpath from 'jsonpath';

describe('JsonPath', function() {
  describe('parent selector', function() {
    var json = {
      "name": "root",
      "children": [
        {"name": "child1", "children": [{"name": "child1_1"},{"name": "child1_2"}]},
        {"name": "child2", "children": [{"name": "child2_1"}]},
        {"name": "child3", "children": [{"name": "child3_1"}, {"name": "child3_2"}]}
      ]
    };

    it('should perform simple parent selection', function() {
      var result = jsonpath(json, "$.children[0]^", {flatten: true});
      expect(result).toEqual(json.children);
    });

    it('should perform parent selection with multiple matches', function() {
      var expected = [json.children,json.children];
      var result = jsonpath(json, "$.children[1:3]^");

      expect(result).toEqual(expected);
    });

    xit('should perform select sibling via parent', function() {
      var expected = [{"name": "child3_2"}];
      var result = jsonpath(json, "$..[?(@.name && @.name.match(/3_1$/))]^[?(@.name.match(/_2$/))]");

      expect(result).toEqual(expected);
    });

    xit('should perform parent parent parent', function() {
      var expected = json.children[0].children;
      var result = jsonpath(json, "$..[?(@.name && @.name.match(/1_1$/))].name^^", {flatten: true});

      expect(result).toEqual(expected);
    });

    it('should perform no such parent', function() {
      var result = jsonpath(json, "name^^");
      expect(result).toEqual([]);
    });
  });
});
