<template>
  <div
    :style="{
      transform: `rotateX(${rotate}deg) scale(${scale})`,
      boxShadow:
        '0 0 #0000004d, 0 9px 20px #0000004a, 0 37px 37px #00000042, 0 84px 50px #00000026, 0 149px 60px #0000000a, 0 233px 65px #00000003',
    }"
    class="mx-auto -mt-12 w-full max-w-5xl rounded-[30px] border-4 border-[#6C6C6C] bg-[#222222] p-2 shadow-2xl md:p-6 overflow-hidden"
  >
    <div class="w-full h-auto bg-gray-100 rounded-2xl">
      <slot></slot>
    </div>
  </div>
</template>

<script setup lang="ts">
defineProps({
  rotate: {
    type: Number,
    required: true
  },
  scale: {
    type: Number,
    required: true
  }
});
</script>
