import Vue from 'vue';
import VueRouter from 'vue-router';
  
import NewLessonPage from './components/NewLesson.vue';
import LessonPage from './components/Lesson.vue';
const routes = [
  {
    path: '/newlesson',
    component: NewLessonPage
  },
  {
    path: '/',
    component: LessonPage
  },

 
  // otherwise redirect to home
  { path: '*', redirect: '/' }
];

export default new VueRouter({routes});