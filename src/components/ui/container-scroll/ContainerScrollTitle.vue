<template>
  <div :style="{ transform: `translateY(${translate}px)` }" class="max-w-5xl mx-auto text-center">
    <slot></slot>
  </div>
</template>

<script setup lang="ts">
defineProps({
  translate: {
    type: Number,
    required: true
  }
});
</script>
