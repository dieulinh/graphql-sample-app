import Vue from 'vue'
import Vuex from 'vuex'
import Axios from 'axios'
import VueRouter from 'vue-router'

import App from './components/App'

import store from './store'
import router from './routes';
import moment from 'moment';

Vue.use(Vuex);
Vue.prototype.$http = Axios;
let authToken = localStorage.getItem('auth_token');
let expiry = (new Date(localStorage.getItem('auth_token_expiry')*1000)) < (new Date());

if(authToken && !expiry) {
  Vue.prototype.$http.defaults.headers.common['Authorization'] = `Bearer ${authToken}`;
} else {
  localStorage.removeItem('auth_token');
}
Vue.use(VueRouter);
Vue.filter('formatDateTime', function(value) {
  if (value) {
    return moment(String(value)).format('YY.MM.DD HH:mm')
    // return moment(String(value)).format('MM/DD/YYYY hh:mm A')
  }
});
document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    el: '#app',
    store: store,
    router,
    render: h => h(App)
  }).$mount()
  document.body.appendChild(app.$el)

  console.log(app)
})
