<template>
  <div class="panel">
    <div class="login-container">
      <div></div>
      <div class="pd-30 wht-bg round-corner">
        <div class="panel login-wrapper wht-bg">
          <label class="form-title">Download Linh Nguyen's resume</label>
          <input type="text" v-model="email" placeholder="Your Email"/>
          <input type="text" v-show="validEmail" v-model="verification_code" placeholder="Verification Code"/>
          <div class="flex-row align-end space-between">
            <button @click="sendVerificationCode()" class="btn btn-primary">Get Verification Code</button>
            <button @click="downloadResume()" class="btn btn-secondary" :class="{'disabled': !verification_code}" :disabled="!verification_code">Download Resume</button>
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
      validEmail: false,
      email: null,
      verification_code: null

    }
  },

  computed: {
    ...mapState(['set_sent_email','download_resume_url'])
},
  created() {
    if (this.authenticated) {
      this.$router.push('/');
    }
  },

  methods: {
    downloadResume() {
      console.log('verification_code', this.verification_code);
      this.$store.dispatch('downloadResume', {email: this.email, code: this.verification_code})
          .then((rs) => {
            if(this.download_resume_url&&this.download_resume_url.status!=500) {
              window.open(this.download_resume_url.url, '_blank')
            } else {
              this.$store.dispatch('setFlashMessage', {text: 'Email or code incorrect', type: 'error'});
            }

          }).catch((err) => {
        console.log(err);
      });
    },

    sendVerificationCode() {
      this.$store.dispatch('sendVerificationCode', {email: this.email})
          .then((rs) => {
            if(!this.errors) {
              this.$store.dispatch('setFlashMessage', {text: 'An Email has been sent to you with the verification code'});
              this.validEmail = true;
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
export default {
  data(){
  return {
  email: null,
  password: null,
  password_confirmation: null
  }
}