<template>
  <div class="flex flex-column">
    <div class="flex-between">
      <router-link class="btn btn-secondary mb-15" v-if="authenticated" :to='{name: "EditCourse", params: {CourseId: courseId}}'>
        Edit
      </router-link>
      <router-link class="btn btn-primary mb-15" v-if="authenticated" :to='{name: "NewLesson", params: {CourseId: courseId}}'>
        New lesson
      </router-link>
    </div>
    <div class="course-view-wrapper">
      <img :src="course.course_cover" v-if="course" class="course-cover"/>
      <h1 v-cloak>{{course.course_name}}</h1>
      <div v-cloak v-html="course.description" ></div>
      <br>
      <h2> Course content </h2>
      <br>
      <div>
        <div class="section-container" v-for="(section, idx) in course.sections" :key="section.id">
          <div class="blt">{{idx+1}}</div> 
          <router-link :to="{name: 'Lesson', params: {course_id: courseId, lesson_id: section.id, lessons: sections}}"> {{section.title}}</router-link>
        </div>
      </div>
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
      console.log(sectionData)
      let sections = sectionData.reduce((rs, section) => {
        rs.push({id: section.id, title: section.title});
        return rs;
      }, []);
      console.log(sections);
      return sections;
    }
  },
  mounted() {
    axios.get(`${coursesApiUrl}/${this.courseId}`)
      .then((result) => {
        this.course = result.data;
        this.sections = this.getSections(result.data.sections);
      })
      .catch((err) => {
        console.log(err);
      })
  },
}
</script>