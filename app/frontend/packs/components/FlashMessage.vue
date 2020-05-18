<template>
  <div :key="text" class="text-green" :class="{'notification': message.text,
  'text-failed': message.type=='error'
  }">
    {{ text }}
  </div>
</template>

<script>
export default {
  props: ["message"],
  computed: {
    text() {
      return this.message.text;
    },
    flashType() {
      return this.message.type
    }
  }
};
</script>