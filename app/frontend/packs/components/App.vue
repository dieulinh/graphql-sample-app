<template>
  <div>
    <div class="top-menu">
      <div>
        <a href="javascript:void(0)" class="brand ml-10" @click="goHome()">i-Class</a>
      </div>
      <flash-message :message="fMessage"></flash-message>
      <div class="menu-right mg-5">
        <div>
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
  </div>
</template>

<script>
import FlashMessage from './FlashMessage';
import { mapState } from 'vuex';
export default {
  components: {FlashMessage},
  data() {
    return {

    };
  },
  computed: {
    authenticated() { return  this.$store.state.authenticated },
    fMessage() {
      return { text: (this.$store.state.flashMessage &&this.$store.state.flashMessage.text)||'' , type: this.$store.state.flashMessage.type||'success' }
    }
  },
  methods: {
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
</style>
