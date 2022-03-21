<template>
  <div class="contact-container">
    <div class="pd-30 wht-bg round-corner">
      <div class="panel login-wrapper wht-bg">
        <label class="form-title">We like to hear you</label>
        <input type="text" v-model="message.email" placeholder="Your Email"/>
        <textarea v-model="message.content" placeholder="Your message"/>
        <div class="flex-row align-end space-between">
          <button @click="sendMessage()" class="btn btn-primary">Send</button>
        </div>
      </div>
    </div>
  </div>
</template>
<script>

export default {
  data(){
    return {
      message: {

      }
    }
  },

  methods: {
    sendMessage() {
      this.$emit('sendMessage', this.message)
      
    }
  }
}
</script>
