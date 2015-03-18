import jsonpath from 'framework/jsonpath.js';

describe('JsonPath', function() {
  describe('with intermixed arrays', function() {
    var json = {"store":{
      "book":[
        { "category":"reference",
          "author":"Nigel Rees",
          "title":"Sayings of the Century",
          "price":[8.95, 8.94, 8.93]
      },
      { "category":"fiction",
        "author":"Evelyn Waugh",
        "title":"Sword of Honour",
        "price":12.99
      },
      { "category":"fiction",
        "author":"Herman Melville",
        "title":"Moby Dick",
        "isbn":"0-553-21311-3",
        "price":8.99
      },
      { "category":"fiction",
        "author":"J. R. R. Tolkien",
        "title":"The Lord of the Rings",
        "isbn":"0-395-19395-8",
        "price":22.99
      }
      ],
      "bicycle":{
        "color":"red",
        "price":19.95
      }
    }
    };

    it('should get all sub properties, entire tree', function() {
      var books = json.store.book;
      var expected = [books[1].price, books[2].price, books[3].price, json.store.bicycle.price];
      expected = books[0].price.concat(expected);
      var result = jsonpath(json, "$.store..price", {flatten: true});
      expect(result).toEqual(expected);
    });

  });
});
