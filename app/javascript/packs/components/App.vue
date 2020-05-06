<template>
  <div>
    <div class="top-menu">
      <div class="sc-eAKXzc fsQCvb">
        <div class="sc-cqpYsc fyGxwu">
          <div class="sc-hBbWxd jrHWGb"></div>
          <div>
            <a class="brand" href="/">Classr0Om</a>
          </div>
        </div>
      </div>
      <div class="menu-right">
        <div>
          <a href="javascript:void(0)" @click="register()" class="btn btn-secondary" v-if="!authenticated">
          Register</a>
          <a href="javascript:void(0)" @click="login()" class="btn btn-primary" v-if="!authenticated">
          Login</a>
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
      this.$router.push('/user/login')
    },
    register() {
      this.$router.push('/user/register')
    },
    logout() {
      this.$store.dispatch('logout')
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
