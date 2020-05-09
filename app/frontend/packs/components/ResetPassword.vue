<template>
  <div class="panel">
    <div class="login-container">
      <div class="panel login-wrapper wht-bg">
        <label class="form-title">Reset your login password</label>
        <input type="text" v-model="email" placeholder="Email"/>
        <button @click="resetPassword()" class="btn btn-primary">Reset Password</button>
      </div>
    </div>
  </div>
</template>
<script>
import axios from 'axios';
export default {
  data(){
    return {
      email: null,
    }
  },
  computed:{

  },
  created() {
    if (this.authenticated) {
      this.$router.push('/');
    }
  },

  methods: {
    resetPassword() {
      axios.post(`${process.env.ROOT_API}/login/reset_password`, {email: this.email})
      .then((response) => {
        console.log(response)
      }).catch((err) => {
        console.log(err);
      });
    }
  }
}
</script>
