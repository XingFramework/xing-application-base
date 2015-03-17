import ResourceTemplates from '../../src/framework/backend/ResourceTemplates';

export default function mockResourceTemplates(uriTemplates = {}) {
  spyOn(ResourceTemplates, 'get').and.returnValue(
    new Promise(function(resolve) {
      return resolve(uriTemplates);
    })
  );
}
