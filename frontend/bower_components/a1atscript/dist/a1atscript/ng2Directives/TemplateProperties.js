import {Template} from "./Component.js";

export default class TemplateProperties {
  constructor(template:Template) {
    this._template = template;
  }

  get template() {
    return this._template.inline;
  }

  get templateUrl() {
    return this._template.url;
  }
}
