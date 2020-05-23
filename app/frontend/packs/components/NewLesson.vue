<template>
  <div class="new-lesson">
    <div class="flex-center"><h1 class="flex-center">Add lesson to course</h1></div>
    <div>
      <label>
        Publish your lesson
      </label>
      <label class="switch">
        <input type="checkbox" v-model="published">
        <span class="slider round"></span>
      </label>
    </div>

    <input v-model="title" placeholder="Title"/>
    <vue-editor class="wht-bg" v-model="content" useCustomImageHandler @image-added="handleUploadImage" />
    <div class="flex-row half content-center pt-10">
      <button @click="save" type="button" class="btn btn-primary">Add lesson</button>
    </div>
  </div>
</template>

<script>

import Vue from 'vue';
import axios from 'axios';
import { VueEditor } from 'vue2-editor';
import * as ActiveStorage from 'activestorage';
const imageUploadUrl = `${process.env.ROOT_API}/uploads`;
export default {
   components: {
    VueEditor
  },
  props: ['CourseId'],
  data() {
    return {
      title: '',
      content: '',
      published: false,
      form: new FormData()
    }
  },
  methods: {
    onFilesChange: function() {
      let files = this.$refs.files.files
      for(let file of files) {
        this.form.append('lesson[files][]', file)
      }
    },
    save: function() {
      this.form.append("lesson[title]", this.title)
      this.form.append("lesson[content]", this.content)
      this.form.append("lesson[published]", this.published)
      axios.post(`${process.env.ROOT_API}/courses/${this.CourseId}/lessons`, this.form, {
          headers: {
            'Content-Type': 'multipart/form-data'
          }
      })
      .then((result) => {
        this.$store.dispatch('setFlashMessage', {text: 'Lesson added successfully', type: 'success'})
        this.$router.push(`/courses/${this.CourseId}`)
      })
      .catch((err) => {
        console.log(err);
      })
    },
    handleUploadImage(file, Editor, cursorLocation, resetUploader) {
      var formData = new FormData();
      formData.append("file", file);
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
    }
  }
}
</script>

