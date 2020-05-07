<template>
  <div class="new-lesson">
    <input v-model="course_name" placeholder="Course name"/>
    <div><input name="files" ref="files" @change="onFilesChange" type="file" data-direct-upload-url="/rails/active_storage/direct_uploads" direct_upload="true" /><label>Choose an image as cover image for the course </label></div>
    <vue-editor class="wht-bg" v-model="description" useCustomImageHandler @image-added="handleUploadImage" aria-placeholder="Input overview of the course" />
    <button @click="save" type="button" class="btn btn-primary">Save changes</button>
  </div>
</template>

<script>

import Vue from 'vue';
import axios from 'axios';
import { VueEditor } from 'vue2-editor';
import * as ActiveStorage from 'activestorage';

const postApiUrl = `${process.env.ROOT_API}/courses`;
const imageUploadUrl = `${process.env.ROOT_API}/uploads`;
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
  data() {
    return {
      title: 'course name',
      course_name: null,
      course_cover: null,
      description: '',
      form: new FormData()
    }
  },
  mounted() {
    ActiveStorage.start()
  },
  created() {
    if (!this.authenticated) {
      this.$router.push('/user/login')
    }
  },
  computed: {
    authenticated() {
      return this.$store.state.authenticated
    }
  },
  methods: {
    onFilesChange: function() {
      console.log(this.$refs.files.files);
      let files = this.$refs.files.files;
      this.form.append('course_cover', files[0])
    },
    save: function() {
      this.form.append("course_name", this.course_name)
      // this.form.append("course[course_cover]", this.course_cover)
      this.form.append("description", this.description)
      axios.post(postApiUrl, this.form, {
          headers: {
            'Content-Type': 'multipart/form-data'
          }
      })
      .then((result) => {
        console.log(result)
        this.$router.push('/courses')
      })
      .catch((err) => {
        console.log(err);
      })
    },
    handleUploadImage(file, Editor, cursorLocation, resetUploader) {
      var formData = new FormData();
      formData.append("file", file);
      // axios.post(`${process.env.ROOT_API}/login`,{email: 'user1@example.com', password: '123123'})
      axios.post(imageUploadUrl, formData, {
          headers: {
            'Content-Type': 'multipart/form-data'
          }
      })
      .then((result) => {
        let url = result.data // Get url from response
        Editor.insertEmbed(cursorLocation, 'image', url);
        resetUploader();  
      })
      .catch((err) => {
        console.log(err);
      })
    },
    handlePost() {
      axios.post(postApiUrl, { title: this.title, content: this.content }).then((response) => {
        this.$router.push(`/`);
      }).catch((err) => {
        console.log(`Error: ${err}`);
      });
    }
  }
}
</script>

