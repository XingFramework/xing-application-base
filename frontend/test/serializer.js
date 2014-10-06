import '../src/common/serializer';

describe('serializer', function () {
    'use strict';

    describe('provider config', function () {
        it('should allow overriding underscore method', function () {
            var overrideCalled = false;

            module('serializer', function (SerializerProvider) {
                expect(SerializerProvider.underscore(function (value) {
                    overrideCalled = true;
                    return value;
                })).toBe(SerializerProvider);
            });

            inject(function (Serializer) {
                var test = {id: 1, firstName: 'George', middleName: 'R. R.', lastName: 'Martin'};
                expect((new Serializer()).serialize(test)).toEqualData(test);
                expect(overrideCalled).toBeTruthy();
            });
        });

        it('should allow overriding camelize method', function () {
            var overrideCalled = false;

            module('serializer', function (SerializerProvider) {
                expect(SerializerProvider.camelize(function (value) {
                    overrideCalled = true;
                    return value;
                })).toBe(SerializerProvider);
            });

            inject(function (Serializer) {
                var test = {id: 1, first_name: 'George', middle_name: 'R. R.', last_name: 'Martin'};
                expect((new Serializer()).deserialize(test)).toEqualData(test);
                expect(overrideCalled).toBeTruthy();
            });
        });

        it('should allow overriding pluralize method', function () {
            module('serializer', function (SerializerProvider) {
                expect(SerializerProvider.pluralize(function (value) {
                    return value + 'ies';
                })).toBe(SerializerProvider);
            });

            inject(function (Serializer) {
                expect((new Serializer()).pluralize('cook')).toEqual('cookies');
            });
        });

        it('should allow overriding exclusionMatchers method', function () {
            module('serializer', function (SerializerProvider) {
                expect(SerializerProvider.exclusionMatchers(['_'])).toBe(SerializerProvider);
            });

            inject(function (Serializer) {
                var test = {id: 1, _firstName: 'George', _middleName: 'R. R.', lastName: 'Martin'};
                expect((new Serializer()).serialize(test)).toEqualData({id: 1, last_name: 'Martin'});
            });
        });
    });

    describe('default provider options', function () {
        var serializer;

        beforeEach(module('serializer'));

        beforeEach(inject(function ( Serializer) {
            serializer = new Serializer();
        }));

        describe('default config', function () {

            it('should underscore attributes on single object', function () {
                var orig = {id: 1, firstName: 'George', middleName: 'R. R.', lastName: 'Martin'},
                    result = serializer.serialize(orig);
                expect(result).toEqualData({id: 1, first_name: 'George', middle_name: 'R. R.', last_name: 'Martin'});
                result = serializer.deserialize(result);
                expect(result).toEqualData(orig);
            });

            it('should underscore attributes on nested objects', function () {
                var orig = {id: 6, title: 'Winds of Winter', pages: 1105, publicationDate: '2020-05-25', author: {id: 1, firstName: 'George', middleName: 'R. R.', lastName: 'Martin'}},
                result = serializer.serialize(orig);
                expect(result).toEqualData({id: 6, title: 'Winds of Winter', pages: 1105, publication_date: '2020-05-25', author: {id: 1, first_name: 'George', middle_name: 'R. R.', last_name: 'Martin'}});
                result = serializer.deserialize(result);
                expect(result).toEqualData(orig);
            });

            it('should underscore attribute inside array objects', function () {
                var orig = {id: 1, firstName: 'George', middleName: 'R. R.', lastName: 'Martin', books: [
                        {id: 1, title: 'A Game of Thrones', publicationDate: '1996-08-06'}
                    ]},
                    result = serializer.serialize(orig);
                expect(result).toEqualData({id: 1, first_name: 'George', middle_name: 'R. R.', last_name: 'Martin', books: [
                    {id: 1, title: 'A Game of Thrones', publication_date: '1996-08-06'}
                ]});
                result = serializer.deserialize(result);
                expect(result).toEqualData(orig);
            });

            it('should support primitive arrays', function () {
                var orig = {id: 1, firstName: 'George', middleName: 'R. R.', lastName: 'Martin', books: [1, 2, 3]},
                    result = serializer.serialize(orig);
                expect(result).toEqualData({id: 1, first_name: 'George', middle_name: 'R. R.', last_name: 'Martin', books: [1, 2, 3]});
                result = serializer.deserialize(result);
                expect(result).toEqualData(orig);
            });

            it('should exclude attributes that start with $', function () {
                var result = serializer.serialize({id: 1, firstName: 'George', middleName: 'R. R.', lastName: 'Martin', $birthDate: '1948-09-20'});
                expect(result).toEqualData({id: 1, first_name: 'George', middle_name: 'R. R.', last_name: 'Martin'});
                result = serializer.deserialize({id: 1, first_name: 'George', middle_name: 'R. R.', last_name: 'Martin', $birth_date: '1948-09-20'});
                expect(result).toEqualData({id: 1, firstName: 'George', middleName: 'R. R.', lastName: 'Martin'});
            });

            it('should exclude functions', function () {
                var result = serializer.serialize({id: 1, firstName: 'George', middleName: 'R. R.', lastName: 'Martin', $books: [], getNumBooks: function () {
                    this.$books.length();
                }});
                expect(result).toEqualData({id: 1, first_name: 'George', middle_name: 'R. R.', last_name: 'Martin'});
            });

        });

    });
});
