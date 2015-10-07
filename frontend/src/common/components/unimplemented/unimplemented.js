
import {DirectiveObject} from 'a1atscript';

@DirectiveObject('xngUnimplemented', [])
export default class UnimplementedDirective {
  constructor() {
    this.restrict = 'A';
  }

  link(scope, element, attrs) {
    element.on('click',() => {
      alert('This feature is not yet implemented.  The item you just clicked on is just a visual placeholder for a future part of this application.');
    });
  }
}
