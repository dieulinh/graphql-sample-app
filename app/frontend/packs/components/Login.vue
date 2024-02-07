<template>
  <div class="panel">
    <div class="login-container">
      <div></div>
      <div class="pd-30 wht-bg round-corner">
        <div class="panel login-wrapper wht-bg">
          <label class="form-title">Log in to your account</label>
          <input type="text" v-model="email" placeholder="Email"/>
          <input type="password" v-model="password" placeholder="Password"/>
          <div class="flex-row align-end space-between">
            <button @click="loginUser()" class="btn btn-primary">Login</button>
            <router-link :to='{name: "ResetPassword"}'>Forgot password</router-link>
          </div>
        </div>
      </div>
      <div></div>
    </div>
  </div>
</template>
<script>
import { mapState } from 'vuex';
export default {
  data(){
    return {
      email: null,
      password: null
    }
  },
  computed: mapState({
    // arrow functions can make the code very succinct!
    errors: state => state.errors,
    authenticated: state => state.authenticated
  }),
  created() {
    if (this.authenticated) {
      this.$router.push('/');
    }
  },

  methods: {
    loginUser() {
      this.$store.dispatch('login', {email: this.email, password: this.password})
      .then((rs) => {
        if(!this.errors) {
          this.$store.dispatch('setFlashMessage', {text: 'Login successfully'});
          this.$router.push('/');
        }
        else {
          this.$store.dispatch('setFlashMessage', {text: 'Email or password incorrect', type: 'error'});
        }
      }).catch((err) => {
        console.log(err);
      });
    }
  }
}
</script>
