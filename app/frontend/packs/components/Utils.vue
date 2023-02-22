<template>
  <div class="article">
    <div class="full">


    <h3> Resume Writer</h3>
    <textarea v-model="command" tabindex="0" style="max-height: 200px; height: 24px; overflow-y: hidden;" rows="1" class="pd-20 full"></textarea>
    <button @click="handleWrite" class="btn btn-primary">Write cv</button>
    <template v-for="course in conversations">
      <div class="full" style="background: greenyellow;min-height: 50px;">
        <pre>{{course.command}}</pre>
      </div>
      <div class="full" style="background: wheat;min-height: 50px;">
        <pre>{{course.answer}}</pre>
      </div>
    </template>


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
      conversations: [],
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
      let currentCommand = {command: this.command};
      server.post(`${apiUrl}/resumes/`, {content: this.command}

      )
      .then((result) => {
        this.mycv = result.data
        currentCommand.answer = result.data;
        this.conversations.push(currentCommand)
      })
      .catch((err) => {
        console.log(err);
      })
    }
  }
}
</script>
