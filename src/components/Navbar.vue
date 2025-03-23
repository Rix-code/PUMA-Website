<script setup lang="ts">
import { ref, onMounted, onUnmounted, computed } from 'vue'
import { useRoute } from 'vue-router'

const isScrolled = ref(false)
const isMenuOpen = ref(false)
const isUserMenuOpen = ref(false)
const route = useRoute()

const isLoggedIn = ref(false)
const currentUser = ref({
  name: 'John Doe',
  email: 'john@example.com',
  avatar: 'https://i.pinimg.com/474x/2d/66/90/2d669016a3e3f5316b0589741e8ca834.jpg',
  role: 'member'
})

const navItems = [
  { name: 'Home', path: '/', showNumber: true },
  { name: 'Events', path: '/timeline', showNumber: true },
  { name: 'Organization', path: '/puma', showNumber: true },
  { name: 'Contact', path: '/contact', showNumber: true }
]

const toggleLoginState = () => {
  isLoggedIn.value = !isLoggedIn.value
  if (isUserMenuOpen.value) {
    isUserMenuOpen.value = false
  }
}

const isHomePage = computed(() => {
  return route.path === '/'
})

const isAdmin = computed(() => {
  return currentUser.value.role !== 'guest'
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

const toggleUserMenu = () => {
  if (currentUser.value.role !== 'guest') {
    isUserMenuOpen.value = !isUserMenuOpen.value
  }
}

const navbarBackground = computed(() => {
  if (!isHomePage.value) {
    return 'bg-black/80 backdrop-blur-lg border-b border-white/10'
  } else {
    return isScrolled.value 
      ? 'bg-black/80 backdrop-blur-lg border-b border-white/10' 
      : 'bg-transparent'
  }
})

const closeUserMenu = (event: MouseEvent) => {
  const target = event.target as HTMLElement
  if (!target.closest('.user-menu') && isUserMenuOpen.value) {
    isUserMenuOpen.value = false
  }
}

onMounted(() => {
  document.addEventListener('click', closeUserMenu)
})

onUnmounted(() => {
  document.removeEventListener('click', closeUserMenu)
})
</script>

<template>
  <nav :class="[
    'fixed w-full z-50 transition-all duration-500',
    navbarBackground
  ]">
    <button 
      @click="toggleLoginState" 
      class="fixed z-50 px-3 py-2 text-xs font-bold text-black bg-white rounded-lg shadow-xl bottom-4 right-4"
    >
      Toggle Login State
    </button>
    
    <div class="container px-4 mx-auto">
      <div class="flex items-center justify-between h-20">
        <div class="flex items-center">
          <img src="../../public/logo.png" alt="PUMA Logo" class="w-auto h-12 p-1 bg-white rounded-full" />
          <span class="ml-2 font-mono text-2xl font-bold tracking-wider text-white">PUMA</span>
        </div>

        <div class="hidden md:flex">
          <div class="relative flex space-x-3">
            <router-link 
              v-for="(item, index) in navItems" 
              :key="item.name" 
              :to="item.path"
              class="px-4 py-2 font-mono text-sm font-medium uppercase transition-all duration-300 border-0 rounded-full group"
              :class="[
                (isScrolled || !isHomePage) ? 'hover:text-black hover:bg-white text-white' : 'hover:bg-white/10 text-white'
              ]">
              <div class="flex items-center">
                <span
                  v-if="item.showNumber"
                  class="mr-1 text-xs px-1.5 py-0.5 rounded-full bg-white/10 text-white group-hover:bg-black/20 group-hover:text-white transition-colors duration-300">
                  {{ (index + 1).toString().padStart(2, '0') }}
                </span>
                {{ item.name }}
              </div>
            </router-link>
            
            <template v-if="!isLoggedIn">
              <router-link 
                to="/login"
                class="px-4 py-2 font-mono text-sm font-medium text-black uppercase transition-all duration-300 bg-white border-0 rounded-full hover:bg-white/90">
                <div class="flex items-center">
                  Login
                </div>
              </router-link>
            </template>
            
            <div v-else class="relative user-menu">
              <button 
                @click="toggleUserMenu"
                class="flex items-center justify-center w-10 h-10 p-0.5 overflow-hidden transition-all duration-300 bg-white rounded-full hover:ring-2 hover:ring-white">
                <img 
                  :src="currentUser.avatar" 
                  alt="User avatar" 
                  class="object-cover w-full h-full rounded-full"
                />
              </button>
              
              <div 
                v-if="isUserMenuOpen"
                class="absolute right-0 w-48 mt-2 overflow-hidden transition-all duration-300 origin-top-right bg-black border shadow-lg border-white/10 rounded-xl backdrop-blur-lg">
                <div class="px-4 py-3 border-b border-white/10">
                  <p class="text-sm font-medium text-white">{{ currentUser.name }}</p>
                  <p class="text-xs truncate text-white/70">{{ currentUser.email }}</p>
                </div>
                <div class="py-1">
                  <router-link to="/profile" class="block px-4 py-2 text-sm text-white hover:bg-white/10">Your Profile</router-link>
                  <router-link 
                    v-if="isAdmin" 
                    to="/admin/dashboard" 
                    class="block px-4 py-2 text-sm text-white hover:bg-white/10 bg-purple-900/50">
                    Admin Dashboard
                  </router-link>
                  <button @click="toggleLoginState" class="block w-full px-4 py-2 text-sm text-left text-white hover:bg-white/10">Sign out</button>
                </div>
              </div>
            </div>
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
      isMenuOpen ? 'max-h-96 border-opacity-100' : 'max-h-0 border-opacity-0'
    ]">
      <div class="container px-4 mx-auto bg-black/80 backdrop-blur-lg rounded-b-2xl">
        <div class="py-4 space-y-2">
          <router-link 
            v-for="(item, index) in navItems" 
            :key="item.name" 
            :to="item.path"
            class="block px-4 py-2 mx-2 font-mono text-sm text-white transition-all duration-300 group hover:bg-white hover:text-black rounded-xl"
            @click="isMenuOpen = false">
            <div class="flex items-center">
              <span
                v-if="item.showNumber"
                class="px-2 py-1 mr-2 text-xs text-white transition-colors duration-300 rounded-full bg-white/10 group-hover:bg-black/20 group-hover:text-white">
                {{ (index + 1).toString().padStart(2, '0') }}
              </span>
              {{ item.name }}
            </div>
          </router-link>
            
          <template v-if="!isLoggedIn">
            <router-link 
              to="/login"
              class="block px-4 py-2 mx-2 font-mono text-sm text-black transition-all duration-300 bg-white rounded-xl"
              @click="isMenuOpen = false">
              Login
            </router-link>
          </template>
          <template v-else>
            <div class="px-4 py-3 mx-2 space-y-3 font-mono text-sm transition-all duration-300 rounded-xl bg-white/5">
              <div class="flex items-center space-x-3">
                <img :src="currentUser.avatar" class="w-10 h-10 rounded-full" :alt="currentUser.name">
                <div>
                  <div class="font-medium text-white">{{ currentUser.name }}</div>
                  <div class="text-xs text-white/70">{{ currentUser.email }}</div>
                </div>
              </div>
              <div class="grid gap-2 pt-2 border-t border-white/10">
                <router-link to="/profile" class="px-3 py-1.5 text-xs text-center text-white transition-all duration-300 rounded-lg bg-white/10 hover:bg-white/20">
                  Profile
                </router-link>
                <router-link 
                  v-if="isAdmin"
                  to="/admin/dashboard" 
                  class="px-3 py-1.5 text-xs text-center text-white transition-all duration-300 rounded-lg bg-purple-900/50 hover:bg-purple-900/70">
                  Admin Dashboard
                </router-link>
                <button @click="toggleLoginState" class="px-3 py-1.5 text-xs text-center text-white transition-all duration-300 rounded-lg bg-white/10 hover:bg-white/20">
                  Sign out
                </button>
              </div>
            </div>
          </template>
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