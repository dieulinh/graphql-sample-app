<template>
  <div class="new-lesson">
    <div>
      <label class="switch">
        <input type="checkbox" v-model="published">
        <span class="slider round"></span>
      </label>
      Publish
    </div>
    

    <input v-model="title"/>
    <vue-editor class="wht-bg" v-model="content" useCustomImageHandler @image-added="handleUploadImage" />

    <button @click="save" type="button" class="btn btn-primary">Save changes</button>
  </div>
</template>

<script>

import Vue from 'vue';
import axios from 'axios';
import { VueEditor } from 'vue2-editor';
import * as ActiveStorage from 'activestorage';

const postApiUrl = `${process.env.ROOT_API}/lessons`;
const imageUploadUrl = `${process.env.ROOT_API}/uploads`;
export default {
   components: {
    VueEditor
  },
  data() {
    return {
      title: 'add',
      content: 'ddd',
      published: false,
      form: new FormData()
    }
  },
  mounted() {
    ActiveStorage.start()
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

      axios.post(postApiUrl, this.form, {
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

