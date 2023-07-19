<template>
  <div>
    <div class="top-menu flex-left">
      <div class="brand-logo flex-left">
        <a href="javascript:void(0)" class="brand" @click="goHome()">i-Class</a>
        <nav class="submenu flex-left">
          <span class="marginlr"></span>


          <router-link :to="{name: 'Blog'}" class="btn-link">Blog</router-link>
          <span class="marginlr"></span>
          »
          <span class="marginlr"></span>
          <router-link :to="{name: 'About'}" class="btn-link">About</router-link>
          <span class="marginlr"></span>
            »
          <span class="marginlr"></span>
          <a href="javascript:void(0)" @click="handleShowContactForm">Contact</a>
          <span class="marginlr"></span>
            »
        </nav>
      </div>

      <flash-message :message="fMessage"></flash-message>
      <div class="btn-group-menu">
        <template v-if="!authenticated">
          <a href="javascript:void(0)" @click="register()" class="btn btn-secondary btn-small">
        Register</a>
          <a href="javascript:void(0)" @click="login()" class="btn btn-primary btn-small">
        Login</a>
        </template>

        <template v-if="authenticated">
          <a href="javascript:void(0)" @click="addCourse()" class="btn btn-primary btn-small">
          +Course</a>
          <a href="javascript:void(0)" @click="logout()" class="btn btn-secondary btn-small">
        Logout</a>
        </template>
      </div>
    </div>
    <div class="main-content">
      <div class="main">
        <router-view :key="$route.fullPath" />

      </div>
      <div class="left-sidebar left-menu">
        <blog-component />
      </div>
    </div>


    <div v-if="contact_form_visible">
      <contact-form @sendMessage="sendContactMessage" @closeForm="hideContactForm"></contact-form>
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
import BlogComponent from './BlogPosts.vue';

export default {
  components: {FlashMessage, ContactForm, BlogComponent},
  data() {
    return {
      showContactForm: false
    };
  },
  watch: {
    '$route' (to, from) {
    // Put your logic here...
      this.$store.dispatch('contact_form_visible', false)
    }
  },
  computed: {
    contact_form_visible() {
      return this.$store.state.contact_form_visible;},
    authenticated() { return  this.$store.state.authenticated },
    fMessage() {
      return { text: (this.$store.state.flashMessage &&this.$store.state.flashMessage.text)||'' , type: this.$store.state.flashMessage.type||'success' }
    }
  },
  methods: {
    sendContactMessage(message) {
      let {email, content} = message;
      axios.post(`/api/inquiries`, {email, content})
      .then((rs) => {
        this.$store.dispatch('contact_form_visible', false)
        this.$store.dispatch('setFlashMessage', {text: 'Your messages has been sent', type: 'success'});
      }).catch((err) => {
        this.$store.dispatch('setFlashMessage', {text: 'Failed to send your message', type: 'error'});
        console.log(err);
      })
    },
    handleShowContactForm() {
      this.$store.dispatch('contact_form_visible', !this.contact_form_visible)
    },
    login() {
      this.hideContactForm();
      if (this.$router.currentRoute.name != 'Login') {
        this.$router.push('/user/login')
      }
    },
    register() {
      this.hideContactForm();
      if (this.$router.currentRoute.name != 'RegisterUser') {
        this.$router.push('/user/register')
      }
    },
    logout() {
      this.hideContactForm();
      this.$store.dispatch('logout')
    },
    goHome() {
      this.$store.dispatch('contact_form_visible', false)
      if (this.$router.currentRoute.name != 'Home') {
        this.$router.push('/');
      }
    },
    hideContactForm() {
      console.log('hide')
      this.$store.dispatch('contact_form_visible', false)
    },
    addCourse() {
      this.$store.dispatch('contact_form_visible', false)

      if (this.$router.currentRoute.name != 'NewCourse') {
        this.$router.push('/courses/new');
      }

    }
  }
};
</script>
