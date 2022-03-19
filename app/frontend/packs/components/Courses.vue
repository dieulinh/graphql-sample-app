<template>
  <div class="course-wrapper">
    <div v-for="course in courses" :key="course.node&&course.node.id" class="course-card">
      <div v-if="course.node">
        <div class="course-thumbnail summary-content">
          <router-link class="course-link"
                    :to='{name: "CoursePage", params: {courseId: course["node"]&&course["node"].id}}'>
            <h3 class="course-title">{{course["node"]&&course["node"].courseName}} </h3>
          </router-link>

          <img :src="course.node&&course.node.courseCoverUrl" class="course-cover"/>
          <div v-html="course.node&&course.node.description">
          </div>

        </div>
      </div>
    </div>
  </div>
</template>
<script>
import server from '../services/Server';

const coursesApiUrl = `/api/courses`;
export default {
  data() {
    return {
      courses: []
    }
  },
  created() {

    server.get(coursesApiUrl
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
