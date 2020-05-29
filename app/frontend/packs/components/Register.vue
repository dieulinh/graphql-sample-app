<template>
  <div class="panel center-container">
    <div class="login-container">
      <div></div>
      <div class="pd-30 wht-bg round-corner">
       <div class="panel register-wrapper wht-bg">
          <label class="form-title">Register new account</label>
          <input type="text" v-model="email" placeholder="Email (*)" :class="{'field-error': invalidEmail}"/>
          <input type="password" v-model="password" placeholder="Password (*)" :class="{'field-error': invalidPassword}"/>
          <input type="password" v-model="password_confirmation" placeholder="Re-enter password (*)" :class="{'field-error': invalidConfirmPassword}"/>
          <button @click="registerUser()" class="btn btn-primary">Register</button>
        </div>
      </div>
      <div></div>
    </div>
  </div>
</template>
<script>
import {mapState} from 'vuex';
export default {
  data(){
    return {
      email: null,
      password: null,
      password_confirmation: null
    }
  },
  computed: {
    errors() {
      return this.$store.state.errors;
    } ,
    invalidEmail() {
      if (this.email)
      {
        return this.email.length==0 || !(/\w+@\w+/).exec(this.email)
      };
      return true;
    },
    invalidPassword() {
      return this.password==null || this.password.length<6 
    },
    invalidConfirmPassword() {
      return this.password_confirmation==null || this.password_confirmation.length<6
    }
  },

  methods: {
    validateUser() {
      if (this.invalidEmail || this.invalidEmail || this.invalidConfirmPassword)
      {
        return false;
      }
      return true;
    },

    registerUser() {
      if (!this.validateUser()) {
        this.$store.dispatch('setFlashMessage', {text: 'Email or password invalid', type: 'error'});
        return
      }
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