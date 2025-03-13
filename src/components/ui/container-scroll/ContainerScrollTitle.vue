<template>
  <div 
    :style="{ transform: `translateY(${translate}px) scale(${scale})` }" 
    class="max-w-5xl mx-auto text-center transition-transform duration-200"
  >
    <slot></slot>
  </div>
</template>

<script setup lang="ts">
defineProps({
  translate: {
    type: Number,
    required: true
  },
  scale: {
    type: Number,
    required: true
  }
});
</script>
