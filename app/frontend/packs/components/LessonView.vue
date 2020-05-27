<template>
  <div class="flex-row">
    <div class="left-nav mr-10 small-hidden">
      <div v-for="lesson_item in lessons" :key="lesson_item.id" class="section-container">
        <router-link :to="{name: 'Lesson', params: {course_id: course_id, lesson_id: lesson_item.id, lessons: lessons }}"> {{lesson_item.title}} </router-link>
      </div>
    </div>
    <div class="flex-column full">
      <div class="flex-between">
        <a @click="goBack()" href="javascript:void(0)">
          <i class="fa fa-arrow-left mb-10"></i> Back </a> 
        <router-link v-if="authenticated" :to="{name: 'EditLesson', params: {CourseId: course_id, lesson_id: lesson_id}}" class="mb-10"><i class="fa fa-pencil"></i>Edit lesson</router-link>
      </div>
      <div class="course-view-wrapper">
        <h3>{{lesson.title}} </h3>
        <div v-html="lesson.content">
        </div>
      </div>
    </div>
  </div>

</template>
<script>
import axios from 'axios';
const coursesApiUrl = `${process.env.ROOT_API}/courses`;
export default {
  props: ['course_id', 'lesson_id', 'lessons'],
  data() {
    return {
      lesson: {},
      sections: []
    }
  },
  watch: {
    "$route.params.cname": {
      handler(cname) {
        // do stuff
        console.log(cname)
      },
      immediate: true
    }
  },
  methods: {
    goTo(item) {
      let self = this
      self.$nextTick(() => {
        self.$router.push(`/courses/${this.course_id}/lessons/${item.id}`, {name: 'Lesson', params: {course_id: this.course_id, lesson_id: item.id, lessons: this.lessons }})
      })

    },
    goBack() {
      history.back();
    }
  },
  created() {
    console.log(this.lessons)
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
    })
    .catch((err) => {
      console.log(err);
    })
  }
}
</script>
