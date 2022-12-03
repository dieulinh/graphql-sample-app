<template>
  <div class="article">
    <div class="full">
      <h3 class="course-title">Utils </h3>
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
const coursesApiUrl = `/api/articles`;
export default {
  props: ['post_id'],
  data() {
    return {
      original_text: ''
    }
  },
  computed: {
    base64message() {
      return this.original_text=='' ? '' : btoa(this.original_text)
    }
  },
  methods: {
  },
  mounted() {
    axios.get(`${coursesApiUrl}/${this.post_id}`)
      .then((result) => {
        this.course = result.data;
      })
      .catch((err) => {
        console.log(err);
      })
  },
}
</script>
