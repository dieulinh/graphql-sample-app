<template>
  <div class="panel">
    <div class="login-container">
      <div class="panel login-wrapper wht-bg">
        <input type="text" v-model="email" />
        <input type="password" v-model="password" />
        <button @click="loginUser()" class="btn btn-primary">Login</button>
      </div>
    </div>
  </div>
</template>
<script>
export default {
  data(){
    return {
      email: '',
      password: ''
    }
  },
  methods: {
    loginUser() {
      this.$store.dispatch('login', {email: this.email, password: this.password})
    }
  }
}
</script>