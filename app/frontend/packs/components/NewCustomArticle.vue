<template>
  <div class="new-lesson">
    <input v-model="article_url" placeholder="source link"/>

    <div class="flex-row half content-center pt-10">
      <button @click="save" type="button" class="half btn btn-primary"> Add artilce</button></div>
  </div>
</template>

<script>

import Vue from 'vue';
import Server from '../services/Server';
import { VueEditor } from 'vue2-editor';

const postApiUrl = `/api/articles/add_custom`;
const rootUrl = `${process.env.ROOT_API}/articles`;
const imageUploadUrl = `${process.env.ROOT_API}/photos`;
export default {
   components: {
    VueEditor
  },
  watch: {
    authenticated(newValue, oldValue) {
      console.log(`Updating from ${oldValue} to ${newValue}`);
      if (newValue === false) {
        this.$router.push('/user/login')
      }
    }
  },
  props: ['CourseId'],
  data() {
    return {
      article_url: null,
      course_name: null,
      course_cover: null,
      content: '',
      form: new FormData()
    }
  },
  created() {
    if (!this.authenticated) {
      this.$router.push('/user/login')
    }
    if (this.CourseId) {
      Server.get(`${rootUrl}/${this.CourseId}`)
      .then((result) => {
        let course = result.data;
        this.course_name = course.course_name;
        this.description = course.description;
      })
      .catch((err) => {
        console.log(err);
      })
    }
  },
  computed: {
    authenticated() {
      return this.$store.state.authenticated
    }
  },
  methods: {
    save: function() {
      this.handleCreate();
    },

    handleCreate() {
      this.form.append("article_url", this.article_url)
      Server.post(postApiUrl, this.form, {
          headers: {
            'Content-Type': 'multipart/form-data'
          }
      })
      .then((result) => {
        this.$store.dispatch('setFlashMessage', {text: 'Post added successfully', type: 'success'})
        this.$router.push('/blog')
      })
      .catch((err) => {
        console.log(err);
      })
    }
  }
}
</script>

