<template>
  <div class="panel center-container">
    <div class="login-container">
      <div></div>
      <div class="pd-30 wht-bg round-corner">
        <div class="panel login-wrapper wht-bg">
          <label class="form-title">Change your login password</label>
          <input type="password" v-model="password" placeholder="Password"/>
          <input type="password" v-model="password_confirmation" placeholder="Re-enter your password"/>
          <button @click="resetPassword()" class="btn btn-primary">Save Password</button>
        </div>
      </div>
      <div></div>
    </div>
  </div>
</template>
<script>
import axios from 'axios';
export default {
  data(){
    return {
      password: null,
      password_confirmation: null,
      reset_password_token: null
    }
  },
  created() {
    
    if(this.$router.currentRoute) {
      axios.get(`${process.env.ROOT_API}/login/validates/${this.$router.currentRoute.query.token}`)
      .then((res) => {
        console.log(res)
        if (res.data.status == 200) {
          this.reset_password_token = this.$router.currentRoute.query.token;
        } else {
          
        }
      }).catch((err) => {
        console.log('Invalid token')
        this.$router.push('/');
      })
    }
  },

  methods: {
    resetPassword() {
      axios.post(`${process.env.ROOT_API}/login/update_password`, {password: this.password, password_confirmation: this.password_confirmation, reset_password_token: this.reset_password_token})
      .then((response) => {
        console.log(response);
        this.$router.push('/')
      }).catch((err) => {
        this.$store.dispatch('setFlashMessage', {text: 'Failed to reset password', type: 'error'})
        console.log(err);
      });
    }
  }
}
</script>
