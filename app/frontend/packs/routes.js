import Vue from 'vue';
import VueRouter from 'vue-router';
  
import NewLessonPage from './components/NewLesson.vue';
import LessonPage from './components/Lesson.vue';
import LoginPage from './components/Login.vue';
import RegisterPage from './components/Register.vue';
import ResetPasswordPage from './components/ResetPassword.vue';
import ChangePasswordPage from './components/ChangePassword.vue';
import CoursesPage from './components/Courses.vue';
import NewCoursePage from './components/NewCourse.vue';
import EditCoursePage from './components/NewCourse.vue';
import CoursePage from './components/Course.vue';

const routes = [
  {
    path: '/:CourseId/newlesson',
    component: NewLessonPage,
    name: 'NewLesson',
    props: true
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
    path: '/user/reset_password',
    component: ResetPasswordPage,
    name: 'ResetPassword'
  },
  {
    path: '/user/change_password',
    component: ChangePasswordPage,
    name: 'ChangePassword'
  },
  {
    path: '/user/register',
    component: RegisterPage,
    name: 'RegisterUser'
  },
  {
    path: '/courses/new',
    name: 'NewCourse',
    component: NewCoursePage,
    props: { default: true, CourseId: null }
  },
  {
    path: '/courses/edit/:CourseId',
    name: 'EditCourse',
    component: EditCoursePage,
    props: true,
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