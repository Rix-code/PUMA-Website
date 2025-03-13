<template>
  <div
    ref="containerRef"
    class="relative flex h-[60rem] items-center justify-center p-2 md:h-[80rem] md:p-20 overflow-auto"
  >
    <div class="relative w-full py-10 md:py-40" style="perspective: 1000px">
      <ContainerScrollTitle :translate="translateY" :scale="scaleTitle">
        <slot name="title"></slot>
      </ContainerScrollTitle>
      <ContainerScrollCard :rotate="rotate" :scale="scale">
        <slot name="card" />
      </ContainerScrollCard>
    </div>
  </div>
</template>

<script setup lang="ts">
import { useWindowSize, useElementBounding } from "@vueuse/core";
import { ref, onMounted, onUnmounted, computed } from "vue";
import ContainerScrollTitle from "./ContainerScrollTitle.vue";
import ContainerScrollCard from "./ContainerScrollCard.vue";

const containerRef = ref<HTMLElement | null>(null);
const isMobile = ref(false);

function updateIsMobile() {
  isMobile.value = window.innerWidth <= 768;
}

onMounted(() => {
  updateIsMobile();
  window.addEventListener("resize", updateIsMobile);
});

onUnmounted(() => {
  window.removeEventListener("resize", updateIsMobile);
});

const { height: windowHeight } = useWindowSize();
const { top, height } = useElementBounding(containerRef);

const scrollYProgress = computed(() => {
  if (!containerRef.value) return 0;

  const elementMiddle = top.value + height.value / 2; 
  const windowMiddle = windowHeight.value / 2; 

  let progress = (elementMiddle - windowMiddle) / windowMiddle;
  if (progress < 0) progress = 0; 

  return Math.min(Math.max(progress, 0), 1);
});

const scaleDimensions = computed(() => (isMobile.value ? [0.85, 1] : [1, 1.1]));

const rotate = computed(() => {
  if (scrollYProgress.value === 0) return 0;
  return 20 * scrollYProgress.value;
});

const scale = computed(() => {
  const [start, end] = scaleDimensions.value;
  return start + (end - start) * scrollYProgress.value;
});

const translateY = computed(() => {
  return -100 * scrollYProgress.value + (scrollYProgress.value === 0 ? 90 : 0);
});

// untuk mengecilkan bang
const scaleTitle = computed(() => {
  return 1 - 0.3 * scrollYProgress.value;
});
</script>
