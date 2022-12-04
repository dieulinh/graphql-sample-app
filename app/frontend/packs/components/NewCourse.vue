<template>
  <div class="new-lesson">
    <input v-model="course_name" placeholder="Course name"/>
    <div><input name="files" ref="files" @change="onFilesChange" type="file" data-direct-upload-url="/rails/active_storage/direct_uploads" direct_upload="true" /><label>Choose an image as cover image for the course </label></div>
    <vue-editor class="wht-bg" v-model="description" useCustomImageHandler @image-added="handleUploadImage" aria-placeholder="Input overview of the course" />
    <div class="flex-row half content-center pt-10">
      <button @click="save" type="button" class="half btn btn-primary" :class="{'disabled-form-control': course_name==''||description==''}" :disabled="course_name==''||description==''"> {{this.CourseId ? 'Update course' : 'Create course' }}</button></div>
  </div>
</template>

<script>

import Vue from 'vue';
import Server from '../services/Server';
import { VueEditor } from 'vue2-editor';
import * as ActiveStorage from 'activestorage';

const imageUploadUrl = `/api/course_attachments`;
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
      course_name: '',
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
    if (this.CourseId) {
      Server.get(`/api/courses/${this.CourseId}`)
      .then((result) => {
        let course = result.data;
        this.course_name = course.course_name;
        this.description = course.description;
        console.log(this.course)
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
    onFilesChange: function() {
      console.log(this.$refs.files.files);
      let files = this.$refs.files.files;
      this.form.append('course_cover', files[0])
    },
    save: function() {
      this.form.append("course_name", this.course_name)
      this.form.append("description", this.description)
      if (this.CourseId) {
        this.handleUpdate();
      } else {
        this.handleCreate();
      }
    },
    handleUpdate() {
      console.log('updating')
      Server.put(`/api/courses/${this.CourseId}`, this.form, {
          headers: {
            'Content-Type': 'multipart/form-data'
          }
      })
      .then((result) => {
        this.$store.dispatch('setFlashMessage', {text: 'Course updated successfully', type: 'success'});
        this.$router.push('/courses');
      })
      .catch((err) => {
        console.log(err);
      })
    },
    handleCreate() {
      Server.post('/api/courses', this.form, {
          headers: {
            'Content-Type': 'multipart/form-data'
          }
      })
      .then((result) => {
        console.log(result.data)
        this.$store.dispatch('setFlashMessage', {text: 'Course added successfully', type: 'success'})
        this.$router.push('/courses');
      })
      .catch((err) => {
        console.log(err);
      })
    },
    handleUploadImage(file, Editor, cursorLocation, resetUploader) {
      var formData = new FormData();
      formData.append("file", file);
      Server.post(imageUploadUrl, formData, {
          headers: {
            'Content-Type': 'multipart/form-data'
          }
      })
      .then((result) => {
        console.log(result)
        let url = result.data.avatar.opt_web.url // Get url from response
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

