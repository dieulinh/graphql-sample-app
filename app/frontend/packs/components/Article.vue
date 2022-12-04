<template>
  <article class="article">
    <div class="article-content">
      <h3 class="course-title">{{course.title}} </h3>
      <div v-html="course.content"></div>
    </div>
  </article>
</template>
<script>
import axios from 'axios';
const coursesApiUrl = `/api/articles`;
export default {
  props: ['post_id'],
  data() {
    return {
      course: {}
    }
  },
  computed: {
    authenticated() {
      return this.$store.state.authenticated;
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
<style scoped>

  .article-content {
    flex-direction: column;
  }
</style>
