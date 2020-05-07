import Vue from 'vue';
import VueRouter from 'vue-router';
  
import NewLessonPage from './components/NewLesson.vue';
import LessonPage from './components/Lesson.vue';
import LoginPage from './components/Login.vue';
import RegisterPage from './components/Register.vue';
import CoursesPage from './components/Courses.vue';
import NewCoursePage from './components/NewCourse.vue';
import CoursePage from './components/Course.vue';

const routes = [
  {
    path: '/newlesson',
    component: NewLessonPage
  },
  {
    path: '/',
    component: CoursesPage,
    name: 'Home'
  },
  {
    path: '/user/login',
    component: LoginPage,
    name: 'Login'
  },
  {
    path: '/user/register',
    component: RegisterPage,
    name: 'RegisterUser'
  },
  {
    path: '/courses/new',
    name: 'NewCourse',
    component: NewCoursePage
  },
  
  {
    path: '/courses/:courseId',
    component: CoursePage,
    props: true,
    name: 'CoursePage'
  },
  // otherwise redirect to home
  { path: '*', redirect: '/' }
];

export default new VueRouter({routes});