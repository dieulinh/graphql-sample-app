<template>
  <div>
    <div v-for="(course, index) in articles" :key="course.id" :class="'article-card '+ course.id">
      <div v-if="course">
        <router-link class="course-link"
                    :to='{name: "Article", params: {post_id: course.id}}'
                  >
          <h3 class="course-title">{{course.title}} </h3>
        </router-link>
        <div>
          <span class="text-right">{{ course.created_at }}</span>

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
    authenticated() {return this.$store.state.authenticated },
    contact_form_visible() {return this.$store.state.contact_form_visible;},
    current_user() {
      return this.$store.state.user
    }
  },
  mounted() {
    this.$store.dispatch('contact_form_visible', false)
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
   watch: {
    contact_form_visible(newValue, oldValue) {
    // Put your logic here...
      console.log(newValue)
      if (oldValue) {this.$store.dispatch('contact_form_visible', false);}


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
