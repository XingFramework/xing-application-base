import {Module, Component, Template} from 'a1atscript';
import SignOutDirective from '../signOut/signOut.js';

@Module('adminNav', ['ng-token-auth', SignOutDirective])
@Component({
  selector: 'adminNav'
})
@Template({
  url: "adminNav/admin-nav.tpl.html"
})
export default class AdminNav {
  constructor() {
  }
}
