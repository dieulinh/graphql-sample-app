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
  searchTerm(state, term) {
    this.state.searchTerm = term;
  },
  setTotalPage(state, payload) {
    state.total_pages = payload.total_pages;
  },
  logout(state) {
    state.authenticated = false;
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
  searchTerm({commit}, term){
    commit('searchTerm', term);
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
  async register({commit}, user) {
    commit('getErrors', null)
    try {
      let response = await axios.post(`/api/login/register`, user );
      if (response.status === 201)
      {
        commit('registerUser', response.data)
      }
      commit('getErrors', response.status === 201 || response.status === 200 ? null : response.data);
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
      commit('login', userData.token)
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
  user: state => state.user,
  auth_token: state => state.auth_token,
  authenticated: state => state.authenticated,
  errors: state => state.errors,
  searchTerm: state => state.searchTerm,
  course: state => state.course,
  flashMessage: state => state.flashMessage,
  auth_token_expiry: state => state.auth_token_expiry
};

const state = {
  auth_token_expiry: 0,
  searchTerm: null,
  course: null,
  user: User.getCurrentUser(),
  flashMessage: {},
  errors: null,
  auth_token: null,
  authenticated: !!localStorage.getItem('user')
};

export default new Vuex.Store({
  state,
  getters,
  actions,
  mutations
});
