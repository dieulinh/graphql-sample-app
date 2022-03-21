<template>
  <div>
    <div class="top-menu flex-left">
      <div class="brand-logo flex-left">
        <a href="javascript:void(0)" class="brand" @click="goHome()">i-Class</a>
        <nav class="submenu flex-left">
          <span class="marginlr"></span>

          <span class="marginlr"></span>
          <router-link :to="{name: 'Blog'}" class="btn-link">Blog</router-link>
          <span class="marginlr"></span>
            »
          <span class="marginlr"></span>
          <a href="javascript:void(0)" @click="handleShowContactForm">Contact</a>
          <span class="marginlr"></span>
            »
        </nav>
      </div>

      <flash-message :message="fMessage"></flash-message>
      <div class="menu-right mg-5">
        <div class="btn-group-menu">
          <a href="javascript:void(0)" @click="register()" class="btn btn-secondary" v-if="!authenticated">
          Register</a>
          <a href="javascript:void(0)" @click="login()" class="btn btn-primary" v-if="!authenticated">
          Login</a>
          <a href="javascript:void(0)" @click="addCourse()" class="btn btn-primary" v-if="authenticated">
          +Course</a>
          <a href="javascript:void(0)" @click="logout()" class="btn btn-secondary" v-if="authenticated">
          Logout</a>
        </div>
      </div>
    </div>
    <div class="main">
      <router-view :key="$route.fullPath" />
    </div>
    <div v-if="showContactForm">
      <contact-form @sendMessage="sendContactMessage"></contact-form>
    </div>
    <footer>
      <section class="copy-right">
        Copyright © 2020 Linh Nguyen. All rights reserved.
      </section>
    </footer>
  </div>
</template>

<script>
import FlashMessage from './FlashMessage';
import axios from 'axios';
import ContactForm from './ContactForm.vue';

import { mapState } from 'vuex';
export default {
  components: {FlashMessage, ContactForm},
  data() {
    return {
      showContactForm: false
    };
  },
  computed: {
    authenticated() { return  this.$store.state.authenticated },
    fMessage() {
      return { text: (this.$store.state.flashMessage &&this.$store.state.flashMessage.text)||'' , type: this.$store.state.flashMessage.type||'success' }
    }
  },
  methods: {
    sendContactMessage(message) {
      console.log(message)
      let {email, content} = message;
      axios.post(`/api/inquiries`, {email, content})
      .then((rs) => {
        console.log(rs.data);
        this.showContactForm = false;
      }).catch((err) => {
        console.log(err);
      })
      
    },
    handleShowContactForm() {
      console.log('Contact us');
      this.showContactForm = true;
    },
    login() {
      if (this.$router.currentRoute.name != 'Login') {
        this.$router.push('/user/login')
      }
    },
    register() {
      if (this.$router.currentRoute.name != 'RegisterUser') {
        this.$router.push('/user/register')
      }

    },
    logout() {
      this.$store.dispatch('logout')
    },
    goHome() {
      if (this.$router.currentRoute.name != 'Home') {
        this.$router.push('/');
      }
    },
    addCourse() {

      if (this.$router.currentRoute.name != 'NewCourse') {
        this.$router.push('/courses/new');
      }

    }
  }
};
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
.blog-btn {
  color: #5a3424;
  text-decoration: underline;
  padding: 10px;
}
.marginlr {
  margin-left: 5px;
  margin-right: 5px;
}
.submenu {
  display: flex;
  justify-items: center;
  margin: 10px;
  color: #222;
  text-transform: uppercase;
  font-weight: 600;
}
</style>
