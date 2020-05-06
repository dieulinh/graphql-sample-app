<template>
  <div class="panel">
    <div class="login-container">
      <div class="panel login-wrapper wht-bg">
        <label class="form-title">Log in to your account</label>
        <input type="text" v-model="email" placeholder="Email"/>
        <input type="password" v-model="password" placeholder="Password"/>
        <button @click="loginUser()" class="btn btn-primary">Login</button>
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
      password: ''
    }
  },
  computed: mapState({
    // arrow functions can make the code very succinct!
    errors: state => state.errors,
    authenticated: state => state.authenticated,

    // passing the string value 'count' is same as `state => state.count`
    countAlias: 'count',

    // to access local state with `this`, a normal function must be used
    countPlusLocalState (state) {
      return state.count + this.localCount
    }
  }),
  methods: {
    loginUser() {
      this.$store.dispatch('login', {email: this.email, password: this.password})
      .then((rs) => {
        console.log(rs)
        console.log(this.$store.state.errors)
        if(!this.errors) {
          this.$router.push('/');
        } else {
          this.$router.push('/user/login');
        }
        
      }).catch((error) => {
        console.log(error);
      });
    }
  }
}
</script>