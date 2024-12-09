import Vue from 'vue';
import Vuex from 'vuex';
import * as types from './mutation-types';
import axios from 'axios';
import User from '../services/User';
import DatetimeFunction from '../services/datetime_services';
Vue.use(Vuex);
const debug = process.env.NODE_ENV !== 'production';
const API_URL = process.env.ROOT_API;

const mutations = {
  hide_right_panel(state, status) {
    state.hide_right_panel = status;
  },
  set_contact_form_visible(state, visible) {
    state.contact_form_visible = visible;
  },
  searchTerm(state, term) {
    state.searchTerm = term;
  },
  set_download_url(state,url) {
    state.download_resume_url = url
  },
  setTotalPage(state, payload) {
    state.total_pages = payload.total_pages;
  },
  logout(state) {
    state.authenticated = false;
  },
  set_sent_email(state, status) {
    state.email_sent = status;
  },
  login(state, value) {
    state.auth_token = value;
    state.authenticated = true;
  },
  auth_token_expiry(state, value) {
    state.auth_token_expiry = value;
  },
  auth_token(state, value) {
    state.auth_token = value;
  },
  auth(state, value) {
    state.auth = value;
  },
  getErrors(state, value) {
    state.errors = value
  },
  registerUser(state, user) {
    state.user = user
  },
  getCourse(state, course) {
    state.course = course
  },
  setFlashMessage(state, message) {
    state.flashMessage = message;
  }
};

const actions = {
  set_verification_code({commit}, code) {
    commit('set_verification_code', code);
  },
  hide_right_panel({commit}, status) {
     commit('hide_right_panel', status)
  },
  contact_form_visible({commit},visible) {
    commit('set_contact_form_visible', visible)
  },
  searchTerm({commit}, term){
    commit('searchTerm', term);
  },
  async sendVerificationCode({commit}, email) {
    try {
      let response = await axios.post(`/api/verifications/send_verification_code`, email);
      if (response.status === 201 || response.status === 200)
      {
        commit('set_sent_email', true);
      }
    } catch(err) {
      console.log(err);
      commit('getErrors', err);
    }
  },
  async getPosts({commit}, postParams) {
    try {
      let searchParams = `${process.env.ROOT_API}/posts?page=${postParams.page+1}`;
      if (postParams.terms) {
        searchParams = `${searchParams}&terms=${postParams.terms}`;
      }
      console.log(postParams);
      if (postParams.category) {
        console.log(postParams.category)
        searchParams = `${searchParams}&category=${postParams.category}`;
      }
      let response = await axios.get(searchParams);
        if (postParams.terms) commit('searchTerm',postParams.terms);
        commit('setPosts', response.data);
        commit('setPostPage', +postParams.page);
        commit('setTotalPage', response.data);
        commit('setNews', false);
    } catch (error) {
      commit('setPosts', []);
    }
  },
  setFlashMessage({commit}, message) {
    commit('setFlashMessage', message)
  },
  setError({commit}, errors) {
    commit('getErrors', errors);
  },
  logout({commit}) {
    User.logOut();
    commit('logout');
    commit('setFlashMessage', {text: 'you have been logout successfully'})
  },
  async downloadResume({commit}, {email,code}) {
    try {
      let response = await axios.post(`/api/verifications/verify_code`, {email,code} );
      commit('set_download_url', response.data)
    } catch(err) {
      console.log(err);
      commit('getErrors', err);
    }
  },
  async register({commit}, user) {
    commit('getErrors', null)
    try {
      let response = await axios.post(`/ app/views/verification_mailer/send_code.html.erb
`, user );
      commit('registerUser', response.data)
    } catch(err) {
      console.log(err);
      commit('getErrors', err);
    }
  },
  async reset_password({commit}, email) {
    try {
      let response = await axios.post(`${process.env.ROOT_API}/login/reset_password`, email );
      if (response.status === 201 || response.status === 200)
      {
        commit('reset_password', response.data)
      }
    } catch(err) {
      console.log(err);
      commit('getErrors', err);
    }
  },
  async login({commit}, {email, password}) {
    try {
      let userData = User.signIn(email, password);
      commit('login', userData)
    } catch(err) {
      commit('getErrors', err.response.data);
      commit('setFlashMessage', {text: err.response.data, type: 'error'});
    }
  },
  async createCourse({commit}, courseParams) {
    try {
      let response = await axios.post(`${API_URL}/courses`, courseParams);
      if (response.status === 201 || response.status === 200)
      {
        commit('getCourse', response.data);
      }
      commit('getErrors', response.status === 201 || response.status === 200 ? null : response.data);
    } catch(error)
    {
      console.log(error.response);
      commit('getErrors', error.response.data);
    }
  }
};

const getters = {
  hide_right_panel: state => state.hide_right_panel,
  user: state => state.user,
  auth_token: state => state.auth_token,
  authenticated: state => state.authenticated,
  errors: state => state.errors,
  searchTerm: state => state.searchTerm,
  course: state => state.course,
  flashMessage: state => state.flashMessage,
  auth_token_expiry: state => state.auth_token_expiry,
  contact_form_visible: state => state.contact_form_visible,
  vefication_code: state => state.vefication_code,
  download_resume_url: state => state.download_resume_url
};

const state = {
  hide_right_panel: false,
  contact_form_visible: false,
  auth_token_expiry: 0,
  searchTerm: null,
  course: null,
  user: User.getCurrentUser(),
  flashMessage: {},
  errors: null,
  auth_token: null,
  downloadEmailValid: false,
  vefication_code: null,
  email_sent: false,
  download_resume_url: null,
  authenticated: !!localStorage.getItem('user')
};

export default new Vuex.Store({
  state,
  getters,
  actions,
  mutations
});
