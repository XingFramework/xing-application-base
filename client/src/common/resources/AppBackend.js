import {Menu} from './Menu';
import {Page} from './Page';
import {PageList} from './PageList';
import {Homepage} from './Homepage';
import BackendServer from '../backend/BackendServer';

export default class AppBackend extends BackendServer {

  pageList(){
    return this.load(PageList, '/admin/pages');
  }

  menu(name){
    return this.load(Menu, `/navigation/${name}`);
  }

  homepage(){
    return this.load(Homepage, '/homepage');
  }

  page(slug, forRole){
    if(forRole !== "admin"){
      return this.load(Page, slug);
    } else {
      return this.load(Page, slug, (response) => {
        var publicData;
        return response.then((backendData) => {
          publicData = backendData;
          var newUrl = this.mangleUrl(backendData.data.links.admin);
          return this.Restangular.one(newUrl).get();
        }).catch((failure) => {
          //assuming unauthorized
          return publicData;
        });
      });
    }
  }

  createPage(){
    return this.create(Page, '/admin/pages');
  }

}
