<template>
  <div class="article-wrapper">
    <div v-for="(course, index) in articles" :key="course.id" :class="'article-card '+ course.id">
      <div v-if="course">
        <router-link class="course-link"
                    :to='{name: "Article", params: {post_id: (course.slug||course.id)}}'
                  >
          <h3 class="course-title">{{course.title}} </h3>
        </router-link>
        <div>

          <span class="text-right">{{ course.created_at | formatDateTime }}</span>
          <div v-if="authenticated&&current_user&&current_user.roles&&current_user.roles.indexOf('author')>=0">
            <router-link class="course-link"
                      :to='{name: "EditArticle", params: {post_id: (course.slug||course.id)}}'
                    >
              Edit
            </router-link>
          </div>
          <button @click="detelePost(course, index)" v-if="authenticated&&current_user&&current_user.roles&&current_user.roles.indexOf('author')>=0"> Delete</button>

          <br/>

          <div class="course-desc" v-html="course.content">
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
import server from '../services/Server';
import moment from 'moment';


const coursesApiUrl = `/api/articles`;
export default {

  filters: {
    formatDateTime(value) {

      if (value) {
        return moment(String(value)).format('YY.MM.DD HH:mm')
      }
    }
  },
  data() {
    return {
      articles: []
    }
  },
  mounted(){
    this.$store.dispatch('contact_form_visible', false)
  },
  computed: {
    authenticated() {return this.$store.state.authenticated },
    current_user() {
      return this.$store.state.user
    }
  },
  methods: {
    detelePost(article, index) {
      server.delete(`/api/articles/${article.id}`).then(() => {
        this.articles.splice(index, 1)
        this.$store.dispatch('setFlashMessage', {text: 'deleting successfully', type: 'success' });
      }).catch((err) => {
        console.log(err);
      })
    }
  },
  created() {

    server.get(coursesApiUrl
      )
      .then((result) => {
        this.articles = result.data
      })
      .catch((err) => {
        console.log(err);
      })
  }
}
</script>
