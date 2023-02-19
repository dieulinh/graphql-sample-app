<template>
  <div class="article">
    <div class="full">

      <div>
        <h3> Resume Writer</h3>
        <textarea v-model="command" tabindex="0" style="max-height: 200px; height: 24px; overflow-y: hidden;" rows="1" class="pd-20 full"></textarea>
        <button @click="handleWrite" class="btn btn-primary">Write cv</button>
        <div class="full" style="background: wheat;min-height: 50px;">
          <pre>{{mycv}}</pre>
        </div>
      </div>
      <div>
        <h3>Base 64 converter</h3>
        <input type="text" placeholder="input your text" v-model="original_text">
        <p>Your base64 version is:</p>
        <div class="full" style="background: wheat;min-height: 50px;">{{base64message}}</div>
      </div>
    </div>
  </div>
</template>
<script>
import axios from 'axios';
import server from '../services/Server';
const apiUrl = `/api`;
export default {
  data() {
    return {
      original_text: '',
      mycv: '',
      command: ''
    }
  },
  computed: {
    base64message() {
      return this.original_text=='' ? '' : btoa(this.original_text)
    },

    authenticated() {return this.$store.state.authenticated },
    current_user() {
      return this.$store.state.user
    }

  },
  methods: {
    handleWrite() {
      server.post(`${apiUrl}/resumes/`, {content: this.command}

      )
      .then((result) => {
        this.mycv = result.data
      })
      .catch((err) => {
        console.log(err);
      })
    }
  }
}
</script>
