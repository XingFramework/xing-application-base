import Inflector from 'inflector';

describe('Inflector class', function() {
  var camelCase, underscore, dasherized, humanized, plural_humanized, inflector;
  beforeEach(function() {
    inflector = new Inflector();
    camelCase = "awesomeTime";
    underscore = "awesome_time";
    humanized = "Awesome Time";
    dasherized = "awesome-time";
    plural_humanized = "Awesome Times";
  });

  it("should convert camelCase to understore", function() {
    expect(inflector.underscore(camelCase)).toEqual(underscore);
  });

  it("should convert camelCase to dasherized", function() {
    expect(inflector.dasherize(camelCase)).toEqual(dasherized);
  });

  it("should convert underscore to camelCase", function() {
    expect(inflector.camelize(underscore)).toEqual(camelCase);
  });

  it("should convert underscore to humanized", function() {
    expect(inflector.humanize(underscore)).toEqual(humanized);
  });

  it("should convert anything to a plural version", function() {
    expect(inflector.pluralize(humanized)).toEqual(plural_humanized);
  });
});
