import Vue from 'vue';
import Vuex from 'vuex';
import * as types from './mutation-types';
import axios from 'axios';

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
  auth_token(state, value) {
    state.auth_token = value;
  },
  auth(state, value) {
    state.auth = value;
  },
  getErrors(state, value) {
    state.errors = value
  },
  showLogin(state, value) {
    state.showLogin = value;
  },
  registerUser(state, user) {
    state.user = user
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
  setError({commit}, errors) {
    commit('getErrors', errors);
  },
  logout({commit}) {
    localStorage.removeItem('auth_token');
    commit('logout');
  },
  async createUser({commit}, user) {
    try {
      let response = await axios.post(`${process.env.ROOT_API}/login/register`, user );
      if (response.status === 201)
      {
        commit('registerUser', response.data)
      } else {
        console.log(response);
        commit('getErrors', response.data);
      }
    } catch(error) {
      console.log(error);
      commit('getErrors', error);
    }
  },
  async login({commit}, user) {
    try {
      let response = await axios.post(`${API_URL}/login`, user);
      if (response.status === 201)
      {
        commit('login', response.data);
        commit('auth_token', response.data);
        localStorage.setItem('auth_token', response.data);
      } else {
        commit('getErrors', response.data);
      }
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
  searchTerm: state => state.searchTerm
};

const state = {
  searchTerm: null,
  user: null,
  errors: null,
  auth_token: null,
  authenticated: !!localStorage.getItem('auth_token'),
  postsApiUrl: `${process.env.ROOT_API}/api/v1/posts`
};

export default new Vuex.Store({
  state,
  getters,
  actions,
  mutations
});
