import Vue from 'vue';
import VueRouter from 'vue-router';

import NewLessonPage from './components/NewLesson.vue';
import NewArticlePage from './components/NewArticle.vue';
import ArticleEditPage from './components/NewArticle.vue';

import Article from './components/Article.vue';
import NewCustomArticle from './components/NewCustomArticle.vue';
import ArticlesPage from './components/Articles.vue';
import EditLessonPage from './components/NewLesson.vue';
import LoginPage from './components/Login.vue';
import RegisterPage from './components/Register.vue';
import ResetPasswordPage from './components/ResetPassword.vue';
import ChangePasswordPage from './components/ChangePassword.vue';
import CoursesPage from './components/Courses.vue';
import NewCoursePage from './components/NewCourse.vue';
import EditCoursePage from './components/NewCourse.vue';
import CoursePage from './components/Course.vue';
import LessonViewPage from './components/LessonView.vue';
import UtilsPage from './components/Utils.vue';


const routes = [
  {
    path: '/',
    component: CoursesPage,
    name: 'Home'
  },
  {
    path: '/:CourseId/newlesson',
    component: NewLessonPage,
    name: 'NewLesson',
    props: true
  },
   {
    path: '/utils',
    component: UtilsPage,
    name: 'Utils',
  },
  {
    path: '/:CourseId/lessons/edit/:lesson_id',
    component: EditLessonPage,
    name: 'EditLesson',
    props: true
  },
  {
    path: '/:course_id/lessons/:lesson_id',
    component: LessonViewPage,
    name: 'Lesson',
    props: true
  },
  {
    path: '/new-custom-post',
    component: NewCustomArticle,
    name: 'NewCustomArticle'
  },
  {
    path: '/blog/:post_id',
    component: Article,
    props: true,
    name: 'Article'
  },
  {
    path: '/new-post',
    component: NewArticlePage,
    name: 'NewPost'
  },
  {
    path: '/edit_blog/:post_id',
    component: ArticleEditPage,
    name: 'EditArticle',
    props: true
  },
  {
    path: '/blog',
    component: ArticlesPage,
    name: 'Blog'
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
