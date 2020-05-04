<template>
  <div class="course-wrapper">
    <div v-for="course in courses" :key="course.id" class="course-card">
      <a class="course-link">
        <h3>{{course["node"]&&course["node"].courseName}}</h3>
        <div class="course-desc" v-html="course.node&&course.node.description">
          
        </div>
        <img :src="course.node&&course.node.courseCoverUrl" class="course-cover"/>
      </a>
    </div>
  </div>
</template>
<script>
import axios from 'axios';
export default {
  data() {
    return {
      courses: []
    }
  },
  mounted() {
    const coursesApiUrl = `${process.env.ROOT_API}/courses`;
    axios.get(coursesApiUrl 
      )
      .then((result) => {
        this.courses = result.data.data.coursesConnection.edges
      })
      .catch((err) => {
        console.log(err);
      })
  },
  methods: {

  }
}
</script>