<template>
  <div class="course-wrapper">
    <div v-for="course in courses" :key="course.node&&course.node.id" class="course-card">
      <div v-if="course.node">
        <div class="course-thumbnail summary-content">
          <router-link class="course-link"
                    :to='{name: "CoursePage", params: {courseId: course["node"]&&course["node"].id}}'>
            <h3 class="course-title">{{course["node"]&&course["node"].courseName}} </h3>
          </router-link>


          <lazy-component wrapper-tag="section">
           <img :src="course.node&&course.node.courseCoverUrl" class="course-cover"/>

            <!-- Optional loading indicator -->
            <span slot="placeholder">Loading..</span>
          </lazy-component>
          <div v-html="course.node&&course.node.description">
          </div>
          <div class="rating">
            <star-rating :star-size="20"/>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios';
import Vue from 'vue';
import server from '../services/Server';
import LazyComponent from "v-lazy-component";
Vue.use(LazyComponent)

import StarRating from 'vue-star-rating';

const coursesApiUrl = `/api/courses`;
export default {
  data() {
    return {
      courses: []
    }
  },
  components: {StarRating, LazyComponent},
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
