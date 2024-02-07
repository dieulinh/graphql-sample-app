<template>
  <div class="course-wrapper">
    <template v-for="course in courses">
      <div v-if="course.node" :key="course.node&&course.node.id" class="course-card">
        <div class="course-thumbnail summary-content">
          <router-link class="course-link course-title"
                    :to='{name: "CoursePage", params: {courseId: course["node"]&&course["node"].id}}'>
            {{course["node"]&&course["node"].courseName}}
          </router-link>
          <div class="pull-right" v-if="current_user&&current_user.roles&&current_user.roles.indexOf('instructor')>=0">
            <label>
              Publish
            </label>
            <label class="switch">
              <input type="checkbox" @click="publish(course)" :checked="course.node.status&&course.node.status=='published'">
              <span class="slider round"></span>
            </label>
          </div>

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
import Server from '../services/Server';
import LazyComponent from "v-lazy-component";
Vue.use(LazyComponent)

const coursesApiUrl = `/api/courses`;
export default {
  data() {
    return {
      courses: []
    }
  },
  components: { LazyComponent },
  computed: {
    authenticated() {return this.$store.state.authenticated },
    current_user() {
      console.log(this.$store.state.user)
      return this.$store.state.user
    }
  },
  created() {
    axios.get(coursesApiUrl)
      .then((result) => {
        var rs = result.data.data.coursesConnection.edges;
        console.log(rs)
        this.courses = rs
      })
      .catch((err) => {
        console.log(err);
      })
  },
  methods: {
    publish(course) {
      let courseId = course.node.id;
      Server.put(`/api/courses/${courseId}`, { status_update: true } )
        .then((result) => {
          this.$store.dispatch('setFlashMessage', {text: 'Course updated successfully', type: 'success'});
        })
        .catch((err) => {
          console.log(err);
        })
    }

  }
}
</script>
