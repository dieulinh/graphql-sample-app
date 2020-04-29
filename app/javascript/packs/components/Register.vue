<template>
  <div class="panel">
    <div class="login-container">
      <div class="panel register-wrapper wht-bg">
        <input type="text" v-model="email" />
        <input type="password" v-model="password" />
        <input type="password" v-model="password_confirmation" />
        <button @click="registerUser()" class="btn btn-primary">Register</button>
      </div>
    </div>
  </div>
</template>
<script>
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
    }
  }
}
</script>