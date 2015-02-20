import {Menu, MenuItem} from './resources/Menu';
import {Page} from './resources/Page';
import {PageList} from './resources/PageList';
import MenuList from './resources/MenuList';
import BackendServer from 'BackendServer';
import {Service} from 'a1atscript';

@Service('backend', ['Restangular'])
export default class AppBackend extends BackendServer {

  pageList(){
    return this.load(PageList, '/admin/pages');
  }

  menuList(){
    return this.load(MenuList, '/menus');
  }

  menu(name){
    var list = this.menuList();
    return list.complete.then((list) => {
      var url = list.urlForName(name);
      return this.load(MenuItem, url);
    });
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

  createMenu(){
    return this.create(MenuItem, '/menus');
  }
}
