import {Module, DirectiveObject} from 'a1atscript';
import SignOutDirective from 'components/signOut/signOut.js';

@Module('adminNav', ['ng-token-auth', SignOutDirective])
@DirectiveObject('adminNav')
export default class AdminNav {
  constructor() {
    this.restrict = 'E';
    this.templateUrl = 'components/adminNav/admin-nav.tpl.html';
  }
}
