<script setup lang="ts">
import { ref, onMounted, onUnmounted } from 'vue'

const isScrolled = ref(false)

const handleScroll = () => {
  isScrolled.value = window.scrollY > 50
}

onMounted(() => {
  window.addEventListener('scroll', handleScroll)
})

onUnmounted(() => {
  window.removeEventListener('scroll', handleScroll)
})
</script>

<template>
  <nav :class="[
    'fixed w-full z-50 transition-all duration-300',
    isScrolled ? 'bg-black shadow-md' : 'bg-transparent'
  ]">
    <div class="container px-4 mx-auto">
      <div class="flex items-center justify-between h-20">
        <div :class="[
          'text-2xl font-bold transition-colors',
          isScrolled ? 'text-white' : 'text-white'
        ]">
          PUMA
        </div>
        <div class="hidden space-x-8 md:flex">
          <a 
            v-for="item in ['Home', 'Vision & Mission', 'Events', 'Divisions', 'Contact']" 
            :key="item"
            :href="'#' + item.toLowerCase().replace(/ & /g, '-')"
            :class="[
              'font-medium transition-colors',
              isScrolled ? 'text-white hover:text-gray-900' : 'text-white/90 hover:text-white'
            ]"
          >
            {{ item }}
          </a>
        </div>
      </div>
    </div>
  </nav>
</template>