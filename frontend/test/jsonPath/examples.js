import jsonpath from 'jsonpath';

describe('JsonPath', function() {
  describe('canonical examples', function() {
    var json = {"store": {
      "book": [
        { "category": "reference",
          "author": "Nigel Rees",
          "title": "Sayings of the Century",
          "price": 8.95
      },
      { "category": "fiction",
        "author": "Evelyn Waugh",
        "title": "Sword of Honour",
        "price": 12.99
      },
      { "category": "fiction",
        "author": "Herman Melville",
        "title": "Moby Dick",
        "isbn": "0-553-21311-3",
        "price": 8.99
      },
      { "category": "fiction",
        "author": "J. R. R. Tolkien",
        "title": "The Lord of the Rings",
        "isbn": "0-395-19395-8",
        "price": 22.99
      }
      ],
      "bicycle": {
        "color": "red",
        "price": 19.95,
        "empty": ""
      }
    }
    };

    it('return empty strings', function() {
      expect(jsonpath(json, "$.store.bicycle.empty", {wrap: false})).toEqual("");
    });

    it('should match wildcards', function() {
        var books = json.store.book;
        var expected = [books[0].author, books[1].author, books[2].author, books[3].author];
        var result = jsonpath(json, "$.store.book[*].author");
        expect(result).toEqual(expected);
    });

    it('should get all properties from the whole tree', function() {
        var books = json.store.book;
        var expected = [books[0].author, books[1].author, books[2].author, books[3].author];
        var result = jsonpath(json, "$..author");
        expect(result).toEqual(expected);
    });

    it('should get all sub properties at a single level', function() {
        var expected = [json.store.book, json.store.bicycle];
        var result = jsonpath(json, "$.store.*");
        expect(result).toEqual(expected);
    });

    it('should get all sub properties, entire tree', function() {
      var books = json.store.book;
      var expected = [books[0].price, books[1].price, books[2].price, books[3].price, json.store.bicycle.price];
      var result = jsonpath(json, "$.store..price");
      expect(result).toEqual(expected);
    });

    it('should get n property of entire tree', function() {
        var books = json.store.book;
        var expected = [books[2]];
        var result = jsonpath(json, "$..book[2]");
      expect(result).toEqual(expected);
    });

    xit('should get last property of entire tree', function() { //relies on eval
      var books = json.store.book;
      var expected = [books[3]];
      var result;
      result = jsonpath(json, "$..book[(@.length-1)]");
      expect(result).toEqual(expected);

      result = jsonpath(json, "$..book[-1:]");
      expect(result).toEqual(expected);
    });

    it('should get range of property of entire tree', function() {
      var books = json.store.book;
      var expected = [books[0], books[1]];
      var result = jsonpath(json, "$..book[0,1]");
      expect(result).toEqual(expected);
      result = jsonpath(json, "$..book[:2]");
      expect(result).toEqual(expected);
    });

    xit('should get filter all properties if sub property exists,o entire tree', function() { //relies on eval
      var books = json.store.book;
      var expected = [books[2], books[3]];
      var result = jsonpath(json, "$..book[?(@.isbn)]");
      expect(result).toEqual(expected);
    });

    xit('should filter all properties if sub property greater than of entire tree', function() { //relies on eval
      var books = json.store.book;
      var expected = [books[0], books[2]];
      var result = jsonpath(json, "$..book[?(@.price<10)]");
      expect(result).toEqual(expected);
    });

    it('should get all properties of a json structure', function() {
      var expected = [
        json.store,
        json.store.book,
        json.store.bicycle,
      ];
      json.store.book.forEach(function(book) { expected.push(book); });
      json.store.book.forEach(function(book){
        Object.keys(book).forEach(function(p){
          expected.push(book[p]);
        });
      });
      expected.push(json.store.bicycle.color);
      expected.push(json.store.bicycle.price);
      expected.push(json.store.bicycle.empty);

      var result = jsonpath(json, "$..*");
      expect(result).toEqual(expected);
    });
  });
});
