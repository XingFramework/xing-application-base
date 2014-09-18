import jsonpath from '../../src/common/jsonpath';

describe('JsonPath', function() {
  describe('getting arrays', function() {
    var json = {
      "store": {
        "book": { "category": "reference",
          "author": "Nigel Rees",
          "title": "Sayings of the Century",
          "price": [8.95, 8.94, 8.93]
        },
        "books": [
          { "category": "reference",
            "author": "Nigel Rees",
            "title": "Sayings of the Century",
            "price": [8.95, 8.94, 8.93]
        }
        ]
      }
    };

    it('should get single', function() {
      var expected = json.store.book;
      var result = jsonpath(json, "store.book", {flatten: true, wrap: false});
      expect(result).toEqual(expected);
    });

    it('should get array', function() {
      var expected = json.store.books;
      var result = jsonpath(json, "store.books", {flatten: true, wrap: false});
      expect(result).toEqual(expected);
    });
  });
});
