<template>
  <div class="article-wrapper">
    <div v-for="course in articles" :key="course.node&&course.node.id" class="article-card">
      <div v-if="course">
        <router-link class="course-link"
                    :to='{name: "Article", params: {post_id: course.id}}'
                  >

          <h3 class="course-title">{{course.title}} </h3>
          <div class="course-desc" v-html="course.content">
          </div>

        </router-link>
      </div>
    </div>
  </div>
</template>
<script>
import axios from 'axios';

const coursesApiUrl = `${process.env.ROOT_API}/articles`;
export default {
  data() {
    return {
      articles: []
    }
  },
  created() {
    axios.get(coursesApiUrl
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
