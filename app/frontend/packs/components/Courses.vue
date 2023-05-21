<template>
  <div class="course-wrapper main-hidden">
    <template v-for="course in courses">
      <div v-if="course.node" :key="course.node&&course.node.id" class="course-card">
        <div class="course-thumbnail summary-content">
          <router-link class="course-link course-title"
                    :to='{name: "CoursePage", params: {courseId: course["node"]&&course["node"].id}}'>
            {{course["node"]&&course["node"].courseName}}
          </router-link>

          <lazy-component wrapper-tag="section">
           <img :src="course.node&&course.node.courseCoverUrl" v-if="course.node&&course.node.courseCoverUrl" :alt='course["node"]&&course["node"].courseName' class="course-cover" height="80px" width="auto" />
              <img src="~/images/no-image-icon.png" v-if="course.node&&!course.node.courseCoverUrl"/>

            <!-- Optional loading indicator -->
            <span slot="placeholder">Loading..</span>
          </lazy-component>
          <div v-html="course.node&&course.node.description" class="desc-content">
          </div>
        </div>
      </div>
    </template>
  </div>
</template>

<script>
import axios from 'axios';
import Vue from 'vue';
import LazyComponent from "v-lazy-component";
Vue.use(LazyComponent)

const coursesApiUrl = `/api/courses`;
export default {
  data() {
    return {
      courses: []
    }
  },
  components: {LazyComponent},
  created() {

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
