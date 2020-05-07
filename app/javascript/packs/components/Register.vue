<template>
  <div class="panel">
    <div class="login-container">
      <div class="panel register-wrapper wht-bg">
        <label class="form-title">Register new account</label>
        <input type="text" v-model="email" placeholder="Email"/>
        <input type="password" v-model="password" placeholder="Password"/>
        <input type="password" v-model="password_confirmation" placeholder="Re-enter password"/>
        <button @click="registerUser()" class="btn btn-primary">Register</button>
      </div>
    </div>
  </div>
</template>
<script>
import {mapState} from 'vuex';
export default {
  data(){
    return {
      email: '',
      password: '',
      password_confirmation: ''
    }
  },

  methods: {
    registerUser() {
      this.$store.dispatch('register', {email: this.email, password: this.password, password_confirmation: this.password_confirmation})
      .then((rs) => {
        if(!this.errors) {
          this.$router.push('/user/login');
        } else {
          console.log(this.errors)
        }
        
      }).catch((error) => {
        console.log(error);
      });
    }
  }
}
</script>