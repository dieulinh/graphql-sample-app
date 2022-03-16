<template>
  <div class="flex flex-column">
    <div>
      <h3 class="course-title">{{course.title}} </h3>
      <div v-html="course.content"></div>
    </div>
  </div>
</template>
<script>
import axios from 'axios';
const coursesApiUrl = `${process.env.ROOT_API}/articles`;
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
