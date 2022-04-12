<template>
  <div class="new-lesson">
    <input v-model="title" placeholder="Title"/>

    <vue-editor class="wht-bg" v-model="content" useCustomImageHandler @image-added="handleUploadImage" aria-placeholder="Input overview of the course" />
    <div class="flex-row half content-center pt-10">
      <button @click="save" type="button" class="half btn btn-primary"> {{this.post_id ? 'Update course' : 'Create post' }}</button></div>
  </div>
</template>

<script>

import Vue from 'vue';
import server from '../services/Server';
import { VueEditor } from 'vue2-editor';

const postApiUrl = `/api/articles`;
const imageUploadUrl = `/api/photos`;
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
  props: ['post_id'],
  data() {
    return {
      title: '',
      content: '',
      form: new FormData()
    }
  },
  created() {
    if (!this.authenticated) {
      this.$router.push('/user/login')
      return;
    }

    console.log(this.current_user.roles&&this.current_user.roles.indexOf('author'))
    if (this.current_user.roles.indexOf('author')<0) {
      this.$router.push(`/blog/`)
    }
    if (this.post_id) {
      server.get(`/api/articles/${this.post_id}`)
      .then((result) => {
        let course = result.data;
        this.title = course.title;
        this.content = course.content;
      })
      .catch((err) => {
        console.log(err);
      })
    }

  },
  computed: {
    authenticated() {
      return this.$store.state.authenticated
    },
    current_user() {
      return this.$store.state.user
    }
  },
  methods: {
    save: function() {
      if(this.post_id) {
        this.handleUpdate();
      } else {
        this.handleCreate();
      }
    },
     handleUpdate() {
      this.form.append("title", this.title)
      this.form.append("content", this.content)
      server.put(`/api/articles/${this.post_id}`, this.form, {
          headers: {
            'Content-Type': 'multipart/form-data'
          }
      })
      .then((result) => {
        this.$store.dispatch('setFlashMessage', {text: 'Updating successfully', type: 'success'})
        this.$router.push('/blog')
      })
      .catch((err) => {
        console.log(err);
      })
    },
    handleCreate() {
      this.form.append("title", this.title)
      this.form.append("content", this.content)
      server.post(postApiUrl, this.form, {
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
    },
    handleUploadImage(file, Editor, cursorLocation, resetUploader) {
      var formData = new FormData();
      formData.append("file", file);
      server.post(imageUploadUrl, formData, {
          headers: {
            'Content-Type': 'multipart/form-data'
          }
      })
      .then((result) => {
        let url = result.data.photo.opt_web.url // Get url from response
        Editor.insertEmbed(cursorLocation, 'image', url);
        resetUploader();
      })
      .catch((err) => {
        console.log(err);
      })
    }
  }
}
</script>

