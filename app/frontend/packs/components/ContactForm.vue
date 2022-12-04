<template>
  <div class="contact-container">
    <div class="pd-30 wht-bg round-corner">
      <div class="panel login-wrapper wht-bg">
        <label class="form-title">We like to hear you</label>
        <input type="text" v-model="message.email" placeholder="Your Email"/>
        <textarea v-model="message.content" placeholder="Your message"/>
        <div class="flex-row align-end space-between">
          <button @click="validContent()&&sendMessage()" :disabled="!validContent()" class="btn btn-primary" :class="{'disabled-form-control': !validContent()}">Send</button>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
import axios from 'axios';

export default {
  data(){
    return {
      message: {
        email: '',
        content: ''
      }
    }
  },

  methods: {
    validContent() {
      return this.message.email&& this.message.content;
    },
    sendMessage() {
      this.$emit('sendMessage', this.message)
    }
  }
}
</script>
