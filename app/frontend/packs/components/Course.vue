<template>
  <div class="flex flex-column">
    <div class="flex-between">
      <router-link class="mb-15" v-if="authenticated" :to='{name: "EditCourse", params: {CourseId: courseId}}'>
        <i class="fa fa-pencil"></i> Edit
      </router-link>
      <router-link class="mb-15" v-if="authenticated" :to='{name: "NewLesson", params: {CourseId: courseId}}'>
        <i class="fa fa-plus"> </i> New lesson
      </router-link>
    </div>
    <div class="course-view-wrapper">
      <img :src="course.course_cover" v-if="course" class="course-cover"/>
      <h1 v-cloak>{{course.course_name}}</h1>
      <div v-cloak v-html="course.description" ></div>
      <br>
      <h2 v-if="course.sections && course.sections.length>0"> Course content </h2>
      <br>
      <div>
        <div class="section-container" v-for="(section, idx) in course.sections" :key="section.id">
          <div class="blt">{{idx+1}}</div>
          <span v-if="!authenticated"> {{section.title}}</span>
          <router-link v-if="authenticated" :to="{name: 'Lesson', params: {course_id: courseId, lesson_id: section.id, lessons: sections}}"> {{section.title}}</router-link>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
import axios from 'axios';
import server from '../services/Server';

export default {
  props: ['courseId'],
  data() {
    return {
      course: {},
      sections: []
    }
  },
  computed: {
    authenticated() {
      return this.$store.state.authenticated;
    }
  },
  methods: {
    getSections(sectionData) {
      let sections = sectionData.reduce((rs, section) => {
        rs.push({id: section.id, title: section.title});
        return rs;
      }, []);
      return sections;
    }
  },
  mounted() {
    if (this.authenticated) {
      server.get(`/api/courses/${this.courseId}`)
      .then((result) => {
        this.course = result.data;
        this.sections = this.getSections(result.data.sections);
      })
      .catch((err) => {
        console.log(err);
      })
    } else {
      axios.get(`/api/courses/${this.courseId}`)
      .then((result) => {
        this.course = result.data;
        this.sections = this.getSections(result.data.sections);
      })
      .catch((err) => {
        console.log(err);
      })
    }
    window.scrollTo(0,50);
  },
}
</script>
