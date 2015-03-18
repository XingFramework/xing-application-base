import slugify from 'framework/slugify.js';

describe("slugify", function() {
  describe("slugify", function() {
    it("should slugify '' as ''", function(){
      expect(slugify("")).toEqual("");
    });
    it("should slugify ' Jack & Jill like numbers 1,2,3 and 4 and silly characters ?%.$!/' as 'jack-jill-like-numbers-123-and-4-and-silly-characters'", function(){
      expect(slugify(" Jack & Jill like numbers 1,2,3 and 4 and silly characters ?%.$!/")).toEqual("jack-jill-like-numbers-123-and-4-and-silly-characters");
    });
    it("should slugify 'Un éléphant à l'orée du bois' as 'un-elephant-a-loree-du-bois'", function(){
      expect(slugify("Un éléphant à l'orée du bois")).toEqual("un-elephant-a-loree-du-bois");
    });
    it("should slugify 'Iñtërnâtiônàlizætiøn' as 'internationalizaetion'", function(){
      expect(slugify("Iñtërnâtiônàlizætiøn")).toEqual("internationalizaetion");
    });
  });
});
