<script setup lang="ts">
import { ref, onMounted, onUnmounted, computed } from 'vue'
import { useRoute } from 'vue-router'

const isScrolled = ref(false)
const isMenuOpen = ref(false)
const route = useRoute()

// Check if current route is home page
const isHomePage = computed(() => {
  return route.path === '/'
})

const handleScroll = () => {
  isScrolled.value = window.scrollY > 50
}

onMounted(() => {
  window.addEventListener('scroll', handleScroll)
})

onUnmounted(() => {
  window.removeEventListener('scroll', handleScroll)
})

const toggleMenu = () => {
  isMenuOpen.value = !isMenuOpen.value
}

// Computed property for navbar background
const navbarBackground = computed(() => {
  if (!isHomePage.value) {
    // Always black background on non-home pages
    return 'bg-black/80 backdrop-blur-lg border-b border-white/10'
  } else {
    // On home page, transparent to black based on scroll
    return isScrolled.value 
      ? 'bg-black/80 backdrop-blur-lg border-b border-white/10' 
      : 'bg-transparent'
  }
})
</script>

<template>
  <nav :class="[
    'fixed w-full z-50 transition-all duration-500',
    navbarBackground
  ]">
    <div class="container px-4 mx-auto">
      <div class="flex items-center justify-between h-20">
        <div class="flex items-center">
          <img src="../../public/logo.png" alt="PUMA Logo" class="w-auto h-12 p-1 bg-white rounded-full" />
          <span class="ml-2 font-mono text-2xl font-bold tracking-wider text-white">PUMA</span>
        </div>

        <div class="hidden md:flex">
          <div class="relative flex space-x-3">
            <router-link v-for="(item, index) in [
              { name: 'Home', path: '/' },
              { name: 'Vision & Mission', path: '#' },
              { name: 'Events', path: '/timeline' },
              { name: 'Divisions', path: '#' },
              { name: 'Contact', path: '/contact' }
            ]" :key="item.name" :to="item.path"
              class="px-4 py-2 font-mono text-sm font-medium text-white uppercase transition-all duration-300 border-0 rounded-full group"
              :class="[
                isScrolled || !isHomePage ? 'hover:text-black hover:bg-white' : 'hover:bg-white/10'
              ]">
              <div class="flex items-center">
                <span
                  class="mr-1 text-xs px-1.5 py-0.5 rounded-full bg-white/10 text-white group-hover:bg-black/20 group-hover:text-white transition-colors duration-300">
                  {{ (index + 1).toString().padStart(2, '0') }}
                </span>
                {{ item.name }}
              </div>
            </router-link>

          </div>
        </div>

        <button class="p-2 text-white rounded-full md:hidden bg-white/10" @click="toggleMenu">
          <div class="w-6 flex flex-col items-end space-y-1.5">
            <div :class="[
              'h-0.5 bg-white transition-all duration-300 rounded-full',
              isMenuOpen ? 'w-6 transform rotate-45 translate-y-2' : 'w-6'
            ]"></div>
            <div :class="[
              'h-0.5 bg-white transition-all duration-300 rounded-full',
              isMenuOpen ? 'opacity-0' : 'w-4'
            ]"></div>
            <div :class="[
              'h-0.5 bg-white transition-all duration-300 rounded-full',
              isMenuOpen ? 'w-6 transform -rotate-45 -translate-y-2' : 'w-5'
            ]"></div>
          </div>
        </button>
      </div>
    </div>

    <div :class="[
      'md:hidden overflow-hidden transition-all duration-500',
      isMenuOpen ? 'max-h-64 border-opacity-100' : 'max-h-0 border-opacity-0'
    ]">
      <div class="container px-4 mx-auto bg-black/80 backdrop-blur-lg rounded-b-2xl">
        <div class="py-4 space-y-2">
          <a v-for="(item, index) in ['Home', 'Vision & Mission', 'Events', 'Divisions', 'Contact']" :key="item"
            :href="'#' + item.toLowerCase().replace(/ & /g, '-')"
            class="block px-4 py-2 mx-2 font-mono text-sm text-white transition-all duration-300 group hover:bg-white hover:text-black rounded-xl">
            <div class="flex items-center">
              <span
                class="px-2 py-1 mr-2 text-xs text-white transition-colors duration-300 rounded-full bg-white/10 group-hover:bg-black/20 group-hover:text-white">
                {{ (index + 1).toString().padStart(2, '0') }}
              </span>
              {{ item }}
            </div>
          </a>
        </div>
      </div>
    </div>
  </nav>
</template>

<style scoped>

@keyframes pulse {
  0% {
    box-shadow: 0 0 0 0 rgba(255, 255, 255, 0.3);
  }

  70% {
    box-shadow: 0 0 0 10px rgba(255, 255, 255, 0);
  }

  100% {
    box-shadow: 0 0 0 0 rgba(255, 255, 255, 0);
  }
}

.nav-item-active {
  animation: pulse 2s infinite;
}

nav {
  box-shadow: 0 0 25px rgba(0, 0, 0, 0.1);
}

nav.bg-black\/80 {
  box-shadow: 0 0 15px rgba(0, 0, 0, 0.3);
}
</style>