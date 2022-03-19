<template>
  <div class="article-wrapper">
    <div v-for="course in articles" :key="course.id" :class="'article-card '+ course.id">
      <div v-if="course">
        <router-link class="course-link"
                    :to='{name: "Article", params: {post_id: course.id}}'
                  >

        </router-link>
        <div>
          <h3 class="course-title">{{course.title}} </h3>  <span class="text-right">{{ course.created_at | formatDateTime }}</span>
          <button @click="detelePost(course)" v-if="authenticated"> delete</button>
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

const coursesApiUrl = `/api/articles`;
export default {
  data() {
    return {
      articles: []
    }
  },
  computed: {
    authenticated() {return this.$store.state.authenticated }
  },
  methods: {
    detelePost(article) {
      server.delete(`/api/articles/${article.id}`).then(() => {
        this.articles = this.articles.filter((a_article) => {return (a_article.id != article.id) })
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
