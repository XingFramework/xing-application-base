import {Factory} from 'a1atscript';
import {backendUrl} from '../../common/config';

@Factory('froalaConfig', ['$auth'])
export default function froalaConfig($auth) {
  var config = {
    buttons: ["bold", "italic", "underline", "strikeThrough", "sep", "formatBlock", "align", "outdent", "indent", "insertHorizontalRule", "sep", "createLink", "insertImage","uploadFile", "undo", "redo", "html"],
    fileUploadParam: 'document',
    fileUploadURL: `${backendUrl}admin/froala_documents/`,
    imageUploadParam: 'image',
    imageUploadURL: `${backendUrl}admin/froala_images/`,
    imagesLoadURL: `${backendUrl}admin/froala_images/`,
    imageDeleteURL: `${backendUrl}admin/froala_images/delete`,
    crossDomain: true
  };
  config.headers = $auth.retrieveData('auth_headers');
  return config;
}
