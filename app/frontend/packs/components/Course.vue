<template>
  <div class="flex flex-column">
    <router-link class="half btn btn-primary mb-15" v-if="authenticated" :to='{name: "EditCourse", params: {CourseId: courseId}}'>
      Edit
    </router-link>
    <div class="course-view-wrapper">
      <img :src="course.course_cover" v-if="course" class="course-cover"/>
      <h1 v-cloak>{{course.course_name}}</h1>
      <div v-cloak v-html="course.description" ></div>
    </div>
  </div>
</template>
<script>
import axios from 'axios';
const coursesApiUrl = `${process.env.ROOT_API}/courses`;
export default {
  props: ['courseId'],
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
  mounted() {
    axios.get(`${coursesApiUrl}/${this.courseId}`)
      .then((result) => {
        this.course = result.data
        console.log(this.course)
      })
      .catch((err) => {
        console.log(err);
      })
  },
}
</script>