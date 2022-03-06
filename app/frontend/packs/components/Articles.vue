<template>
  <div class="course-wrapper">
    <div v-for="course in courses" :key="course.node&&course.node.id" class="course-card">
      <div v-if="course">
        <router-link class="course-link"
                    :to='{name: "CoursePage", params: {courseId: course["node"]&&course["node"].id}}'
                  >

          <h3 class="course-title">{{course.title}} </h3>
          <div class="course-desc" v-html="course.content">
          </div>

        </router-link>
      </div>
    </div>
  </div>
</template>
<script>
import axios from 'axios';

const coursesApiUrl = `${process.env.ROOT_API}/articles`;
export default {
  data() {
    return {
      courses: []
    }
  },
  created() {
    axios.get(coursesApiUrl
      )
      .then((result) => {
        this.courses = result.data
      })
      .catch((err) => {
        console.log(err);
      })
  }
}
</script>
