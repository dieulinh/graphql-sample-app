import Vue from 'vue';
import VueRouter from 'vue-router';
  
import NewLessonPage from './components/NewLesson.vue';
import LessonPage from './components/Lesson.vue';
import LoginPage from './components/Login.vue';
import RegisterPage from './components/Register.vue';
const routes = [
  {
    path: '/newlesson',
    component: NewLessonPage
  },
  {
    path: '/',
    component: LessonPage
  },
  {
    path: '/user/login',
    component: LoginPage
  },
  {
    path: '/user/register',
    component: RegisterPage
  },
 
  // otherwise redirect to home
  { path: '*', redirect: '/' }
];

export default new VueRouter({routes});