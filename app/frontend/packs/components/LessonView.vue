<template>
  <div class="flex-column">
    <button class="btn btn-secondary mb-10" @click="goBack()">Back</button>
    <div class="course-view-wrapper">
    
      <h3>{{lesson.title}} </h3>
      <div v-html="lesson.content">
        
      </div>
    </div>
  </div>
  

</template>
<script>
import axios from 'axios';
const coursesApiUrl = `${process.env.ROOT_API}/courses`;
export default {
  props: ['course_id', 'lesson_id'],
  data() {
    return {
      lesson: {}
    }
  },
  methods: {
    goBack() {
      history.back();
    }
  },
  computed: {
    authenticated() {
      return this.$store.state.authenticated;
    }
  },
  mounted() {
    axios.get(`${coursesApiUrl}/${this.course_id}/lessons/${this.lesson_id}`)
      .then((result) => {
        this.lesson = result.data
        console.log(this.course)
      })
      .catch((err) => {
        console.log(err);
      })
  }
}
</script>
