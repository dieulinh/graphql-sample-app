import Vue from 'vue'
import Vuex from 'vuex'
import Axios from 'axios'
import VueRouter from 'vue-router'

import App from './components/App'

import store from './store'
import router from './routes';


Vue.use(Vuex);
Vue.prototype.$http = Axios;
let authToken = localStorage.getItem('auth_token');
if(authToken) {
  Vue.prototype.$http.defaults.headers.common['Authorization'] = `Bearer ${authToken}`;
}
Vue.use(VueRouter);
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
