<template>
  <div class="new-lesson">
    <div class="flex-center"><h1 class="flex-center">Add lesson to course</h1></div>
    <div class="flex-row full pt-10">
      <a @click="save" href="javascript:void(0);" class="flex-row flex-right full"><i class="fa fa-save"></i></a>
    </div>
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
      <button @click="save" type="button" class="btn btn-primary">Save lesson</button>
    </div>
  </div>
</template>

<script>

import Vue from 'vue';
import Server from '../services/Server';
import { VueEditor } from 'vue2-editor';

const rootUrl = `${process.env.ROOT_API}`;
const imageUploadUrl = `${process.env.API_SERVER_URL}/api/photos`;
export default {
   components: {
    VueEditor
  },
  props: ['CourseId', 'lesson_id'],
  data() {
    return {
      title: '',
      content: '',
      published: false,
      form: new FormData()
    }
  },
  watch: {
    authenticated(newValue, oldValue) {
      console.log(`Updating from ${oldValue} to ${newValue}`);
      if (newValue === false) {
        this.$router.push('/user/login')
      }
    }
  },
  created() {
    if (!this.authenticated) {
      this.$router.push('/user/login')
    }
    if (this.CourseId && this.lesson_id) {
      Server.get(`/api/courses/${this.CourseId}/lessons/${this.lesson_id}`)
      .then((result) => {
        let lesson = result.data;
        this.title = lesson.title;
        this.content = lesson.content;
        this.published = lesson.published;
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
      let files = this.$refs.files.files
      for(let file of files) {
        if (this.lesson_id) {
          this.form.append('files[]', file)
        } else {
          this.form.append('lesson[files][]', file)
        }

      }
    },
    handleCreate() {
      this.form.append("lesson[title]", this.title)
      this.form.append("lesson[content]", this.content)
      this.form.append("lesson[published]", this.published)
      Server.post(`/api/courses/${this.CourseId}/lessons`, this.form, {
          headers: {
            'Content-Type': 'multipart/form-data'
          }
      })
      .then((result) => {
        this.$store.dispatch('setFlashMessage', {text: 'Lesson added successfully', type: 'success'})
        this.$router.push(`/courses/${this.CourseId}`)
      })
      .catch((err) => {
        this.$store.dispatch('setFlashMessage', {text: 'Lesson added failed', type: 'error'})
        console.log(err);
      })
    },
    handleUpdate() {
      this.form.append("title", this.title)
      this.form.append("content", this.content)
      this.form.append("published", this.published)
      Server.put(`/api/courses/${this.CourseId}/lessons/${this.lesson_id}`, this.form, {
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
    save: function() {
      if(this.lesson_id) {
        this.handleUpdate();
      } else {
        this.handleCreate();
      }
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
        let url = result.data.photo.web.url // Get url from response
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

