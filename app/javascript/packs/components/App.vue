<template>
  <div>
    <div class="top-menu">
      <div class="sc-eAKXzc fsQCvb">
        <div class="sc-cqpYsc fyGxwu">
          <div class="sc-hBbWxd jrHWGb"></div>
          <div>
            <a class="brand" href="javascript:void(0)" @click="goHome()">i-Class</a>
          </div>
        </div>
      </div>
      <div class="menu-right">
        <div>
          <a href="javascript:void(0)" @click="register()" class="btn btn-secondary" v-if="!authenticated">
          Register</a>
          <a href="javascript:void(0)" @click="login()" class="btn btn-primary" v-if="!authenticated">
          Login</a>
          <a href="javascript:void(0)" @click="addCourse()" class="btn btn-primary" v-if="authenticated">
          +Course</a>
          <a href="javascript:void(0)" @click="logout()" class="btn btn-primary" v-if="authenticated">
          Logout</a>
        </div>

      </div>
    </div>
    <div class="main">
      <router-view />
    </div>
  </div>
</template>

<script>
import { mapState } from 'vuex';
export default {
  data() {
    return {
      message: "Hello Vue!"
    };
  },
  computed: mapState({
    authenticated: 'authenticated'
  }),
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
