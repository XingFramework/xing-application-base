import {Module, Component, Template} from 'a1atscript';
import SignOutDirective from 'components/signOut/signOut.js';

@Module('adminNav', ['ng-token-auth', SignOutDirective])
@Component({
  selector: 'adminNav'
})
@Template({
  url: "components/adminNav/admin-nav.tpl.html"
})
export default class AdminNav {
  constructor() {
  }
}
