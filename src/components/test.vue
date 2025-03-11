<script setup>
import { ref } from "vue";
import { ContainerScroll } from "../components/ui/container-scroll";
import { FallingStarsBg } from "../components/ui/bg-falling-stars";
import { Lens } from "../components/ui/lens"; 

const hovering = ref(false);

function setHovering(value) {
  hovering.value = value;
}
</script>

<template>
  <div class="relative flex flex-col overflow-hidden">
    <FallingStarsBg class="absolute inset-0 -z-10" :color="isDark ? '#FFF' : '#555'" />

    <ContainerScroll>
      <template #title>
        <h1 class="text-4xl font-semibold text-black dark:text-white">
          Unleash the power of <br />
          <span class="mt-1 text-4xl font-bold leading-none md:text-[6rem]">
            PUMA
          </span>
        </h1>
      </template>
      <template #card>
        <Lens :hovering="hovering" @hover-update="setHovering">
          <img
            src="../../public/puma-bag.JPG"
            class="object-cover object-left-top h-full pb-10 mx-auto rounded-2xl"
            alt="hero"
            height="720"
            width="1400"
            loading="lazy"
          />
        </Lens>
      </template>
    </ContainerScroll>
  </div>
</template>
