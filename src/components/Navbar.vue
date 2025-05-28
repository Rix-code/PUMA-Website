<script setup lang="ts">
import { ref, onMounted, onUnmounted, computed, watch } from 'vue'
import { useRoute } from 'vue-router'

const isScrolled = ref(false)
const lastScrollY = ref(0)
const isNavbarVisible = ref(true)
const isMenuOpen = ref(false)
const isUserMenuOpen = ref(false)
const isOtherDropdownOpen = ref(false)
const route = useRoute()
const isAnimating = ref(false)

const isLoggedIn = ref(false)

type UserRole = 'guest' | 'member' | 'admin';

const currentUser = ref<{
  name: string
  email: string
  avatar: string
  role: UserRole
}>({
  name: 'Guest User',
  email: '',
  avatar: 'https://i.pravatar.cc/150?u=guest', 
  role: 'guest'
})

const navItems = [
  { name: 'Home', path: '/', icon: '○' },
  { name: 'Events', path: '/timeline', icon: '◉' },
  { name: 'Organization', path: '/puma', icon: '○' }
]

const otherDropdownItems = [
  { name: 'Contact', path: '/contact', icon: '◉' },
  { name: 'Aspirations', path: '/aspirations', icon: '○' },
  { name: 'Merch', path: '/merch', icon: '◉' },
  { name: 'About', path: '/about', icon: '○' } 
];


const loginAs = (role: UserRole) => {
  isLoggedIn.value = true
  isUserMenuOpen.value = false 

  switch (role) {
    case 'admin':
      currentUser.value = {
        name: 'Admin User',
        email: 'admin@example.com',
        avatar: 'https://i.pinimg.com/474x/2d/66/90/2d669016a3e3f5316b0589741e8ca834.jpg', 
        role: 'admin'
      }
      break;
    case 'member':
      currentUser.value = {
        name: 'Registered Member',
        email: 'member@example.com',
        avatar: 'https://i.pinimg.com/474x/2d/66/90/2d669016a3e3f5316b0589741e8ca834.jpg', 
        role: 'member'
      }
      break;
  }

  if (!isNavbarVisible.value) {
    isNavbarVisible.value = true;
  }
}

const logout = () => {
  isLoggedIn.value = false
  isUserMenuOpen.value = false 
  currentUser.value = {
    name: 'Guest User',
    email: '',
    avatar: 'https://i.pravatar.cc/150?u=guest',
    role: 'guest'
  }
  if (!isNavbarVisible.value) {
    isNavbarVisible.value = true;
  }
}


const cycleLoginState = () => {
  if (currentUser.value.role === 'guest') {
    loginAs('member');
  } else if (currentUser.value.role === 'member') {
    loginAs('admin');
  } else if (currentUser.value.role === 'admin') {
    logout();
  }
};

const isHomePage = computed(() => {
  return route.path === '/'
})

const isAdmin = computed(() => {
  return isLoggedIn.value && currentUser.value.role === 'admin'
})

const isMember = computed(() => {
  return isLoggedIn.value && currentUser.value.role === 'member'
})

const isOtherPageActive = computed(() => {
  return otherDropdownItems.some(item => item.path === route.path)
})

const handleScroll = () => {
  const currentScrollY = window.scrollY
  const scrollThreshold = 50;

  if (currentScrollY > 20) {
    isScrolled.value = true
  } else {
    isScrolled.value = false
  }

  if (currentScrollY > scrollThreshold && !isMenuOpen.value && !isUserMenuOpen.value) {
    if (currentScrollY > lastScrollY.value) {
      isNavbarVisible.value = false
    } else if (currentScrollY < lastScrollY.value - 5) {
      isNavbarVisible.value = true
    }
  } else if (currentScrollY <= 20) {
    isNavbarVisible.value = true
  }
  lastScrollY.value = currentScrollY <= 0 ? 0 : currentScrollY;
}

watch(() => route.path, () => {
  isAnimating.value = true
  if (!isNavbarVisible.value) {
    isNavbarVisible.value = true;
  }
  if (isMenuOpen.value) isMenuOpen.value = false;
  if (isUserMenuOpen.value) isUserMenuOpen.value = false;
  if (isOtherDropdownOpen.value) isOtherDropdownOpen.value = false;

  setTimeout(() => {
    isAnimating.value = false
  }, 800)
})

onMounted(() => {
  window.addEventListener('scroll', handleScroll, { passive: true })
  document.addEventListener('click', closeMenusOnClickOutside)
  lastScrollY.value = window.scrollY;
})

onUnmounted(() => {
  window.removeEventListener('scroll', handleScroll)
  document.removeEventListener('click', closeMenusOnClickOutside)
})

const toggleMenu = () => {
  isMenuOpen.value = !isMenuOpen.value
  if (isUserMenuOpen.value && isMenuOpen.value) isUserMenuOpen.value = false; 
  if (isOtherDropdownOpen.value && isMenuOpen.value) isOtherDropdownOpen.value = false; 
  if (isMenuOpen.value && !isNavbarVisible.value) {
    isNavbarVisible.value = true;
  }
}

const toggleUserMenu = () => {
  isUserMenuOpen.value = !isUserMenuOpen.value
  if (isMenuOpen.value && isUserMenuOpen.value) isMenuOpen.value = false;
  if (isOtherDropdownOpen.value && isUserMenuOpen.value) isOtherDropdownOpen.value = false; 
  if (isUserMenuOpen.value && !isNavbarVisible.value) {
    isNavbarVisible.value = true;
  }
}

const toggleOtherDropdown = () => {
  isOtherDropdownOpen.value = !isOtherDropdownOpen.value
  if (isMenuOpen.value && isOtherDropdownOpen.value) isMenuOpen.value = false;
  if (isUserMenuOpen.value && isOtherDropdownOpen.value) isUserMenuOpen.value = false;
  if (isOtherDropdownOpen.value && !isNavbarVisible.value) {
    isNavbarVisible.value = true;
  }
}

const navbarContainerClasses = computed(() => {
  return [
    'fixed top-4 left-1/2 transform -translate-x-1/2 z-50 transition-all duration-500 ease-out',
    isAnimating.value ? 'scale-105' : 'scale-100',
    isNavbarVisible.value ? 'translate-y-0 opacity-100' : '-translate-y-[120%] opacity-0'
  ]
})

const dynamicIslandClasses = computed(() => {
  return [
    'relative px-6 py-3 transition-all duration-700 ease-out backdrop-blur-2xl shadow-2xl',
    'bg-black/85',
    (isScrolled.value && !isHomePage.value) ? 'border border-white/20' : 'border border-transparent',
    isMenuOpen.value && window.innerWidth < 768 ? 'rounded-3xl px-4 py-4' : 'rounded-full',
    isAnimating.value ? 'animate-pulse shadow-white/20' : ''
  ]
})

const closeMenusOnClickOutside = (event: MouseEvent) => {
  const target = event.target as HTMLElement
  if (!target.closest('.user-menu-interactive-area') && isUserMenuOpen.value) {
    isUserMenuOpen.value = false
  }
  if (!target.closest('.other-dropdown-interactive-area') && isOtherDropdownOpen.value) {
    isOtherDropdownOpen.value = false
  }
}
</script>

<template>
  <button @click="cycleLoginState"
    class="fixed z-[60] px-4 py-2 text-xs font-medium text-black transition-all duration-300 bg-white rounded-full shadow-lg top-6 right-6 hover:shadow-xl hover:scale-105"
    :title="isLoggedIn ? `Current: ${currentUser.role}. Click to switch.` : 'Click to Login as Member'">
    {{ isLoggedIn ? `Logout (${currentUser.role})` : 'Login As...' }}
  </button>

  <div v-if="isMenuOpen" class="fixed z-40 top-20 left-4 right-4 md:hidden animate-slide-down">
    <div class="p-6 border shadow-2xl bg-black/90 backdrop-blur-2xl border-white/20 rounded-3xl">
      <div v-if="isLoggedIn" class="pb-4 mb-6 border-b border-white/10">
        <div class="flex items-center space-x-3">
          <div class="relative">
            <img :src="currentUser.avatar" class="w-12 h-12 border-2 rounded-full shadow-lg border-white/20"
              :alt="currentUser.name">
            <div class="absolute w-3 h-3 bg-green-500 border-2 border-black rounded-full -bottom-1 -right-1"></div>
          </div>
          <div>
            <h3 class="font-semibold text-white">{{ currentUser.name }}</h3>
            <p class="text-sm text-white/70">{{ currentUser.email }}</p>
            <span
              class="inline-block px-2 py-0.5 mt-1 text-xs font-semibold uppercase bg-blue-500/20 text-blue-400 rounded">
              {{ currentUser.role }}
            </span>
          </div>
        </div>
      </div>

      <div class="mb-6 space-y-2">
        <router-link v-for="(item, index) in navItems" :key="`mobile-${item.name}`" :to="item.path" :class="[
          'flex items-center justify-between p-3 font-medium text-white transition-all duration-300 rounded-xl group',
          route.path === item.path ? 'bg-white/15 border border-white/20' : 'hover:bg-white/10'
        ]" @click="isMenuOpen = false">
          <div class="flex items-center">
            <span class="mr-3 text-lg opacity-70">{{ item.icon }}</span>
            <span>{{ item.name }}</span>
          </div>
          <div v-if="route.path === item.path" class="w-2 h-2 bg-white rounded-full"></div>
        </router-link>

        <div class="space-y-1">
          <div class="flex items-center p-3 text-sm font-semibold tracking-wider uppercase text-white/50">
            <span class="mr-3 text-lg opacity-70">◇</span>
            Other
          </div>
          <router-link v-for="item in otherDropdownItems" :key="`mobile-other-${item.name}`" :to="item.path" :class="[
            'flex items-center justify-between p-3 ml-6 font-medium text-white transition-all duration-300 rounded-xl group',
            route.path === item.path ? 'bg-white/15 border border-white/20' : 'hover:bg-white/10'
          ]" @click="isMenuOpen = false">
            <div class="flex items-center">
              <span class="mr-3 text-lg opacity-70">{{ item.icon }}</span>
              <span>{{ item.name }}</span>
            </div>
            <div v-if="route.path === item.path" class="w-2 h-2 bg-white rounded-full"></div>
          </router-link>
        </div>
      </div>

      <div class="space-y-2">
        <template v-if="isLoggedIn">
          <router-link to="/profile" @click="isMenuOpen = false"
            class="flex items-center w-full p-3 text-white transition-all duration-300 border border-white/10 rounded-xl bg-white/5 hover:bg-white/10">
            <span class="mr-3">◐</span>
            Profile Settings
          </router-link>

          <router-link v-if="isAdmin" to="/admin/dashboard" @click="isMenuOpen = false"
            class="flex items-center w-full p-3 text-white transition-all duration-300 border border-purple-500/20 rounded-xl bg-purple-500/10 hover:bg-purple-500/15">
            <span class="mr-3">◈</span>
            Admin Panel
          </router-link>

          <button @click="logout(); isMenuOpen = false"
            class="flex items-center w-full p-3 text-red-400 transition-all duration-300 border border-red-500/20 rounded-xl bg-red-500/10 hover:bg-red-500/15">
            <span class="mr-3">◊</span>
            Sign Out
          </button>
        </template>

        <template v-else>
          <router-link to="/login" @click="isMenuOpen = false"
            class="flex items-center justify-center w-full p-3 font-semibold text-black transition-all duration-300 bg-white rounded-xl hover:bg-white/90">
            <span class="mr-3">→</span>
            Sign Up
          </router-link>
        </template>
      </div>
    </div>
  </div>

  <nav :class="navbarContainerClasses">
    <div :class="dynamicIslandClasses">
      <div :class="[
        'flex items-center transition-all duration-500',
        isMenuOpen ? 'justify-between' : 'space-x-6'
      ]">

        <div class="flex items-center space-x-3">
          <div class="relative">
            <div class="absolute inset-0 bg-white rounded-full opacity-10 animate-pulse"></div>
            <img src="../../public/logo.png" alt="PUMA"
              class="relative w-8 h-8 p-1.5 bg-white/90 rounded-full shadow-lg backdrop-blur-sm transition-all duration-500" />
          </div>
          <span class="text-lg font-light tracking-[0.2em] text-white font-sans">PUMA</span>
        </div>

        <div :class="[
          'hidden md:flex transition-all duration-500',
          isMenuOpen ? 'hidden' : 'flex'
        ]">
          <div class="flex items-center space-x-1">
            <div class="flex items-center p-1 border rounded-full backdrop-blur-xl border-white/10 bg-white/5">
              <router-link v-for="(item, index) in navItems" :key="`desktop-${item.name}`" :to="item.path" :class="[
                'relative px-4 py-2 text-sm font-medium transition-all duration-500 group rounded-full font-sans text-white/80 hover:text-white',
                route.path === item.path ? 'text-white' : ''
              ]" :style="{
                  transitionDelay: isAnimating ? `${index * 100}ms` : '0ms',
                  transform: isAnimating ? 'translateY(-2px)' : 'translateY(0)'
                }">
                <div class="flex items-center space-x-2">
                  <span :class="[
                    'text-xs transition-all duration-500 opacity-60 group-hover:opacity-100',
                    route.path === item.path ? 'opacity-100 scale-110' : ''
                  ]">{{ item.icon }}</span>
                  <span class="tracking-wide">{{ item.name }}</span>
                </div>
                <div v-if="route.path === item.path"
                  class="absolute inset-0 border rounded-full bg-white/15 backdrop-blur-sm border-white/20 animate-dynamic-island">
                </div>
              </router-link>

              <div class="relative other-dropdown-interactive-area">
                <button @click="toggleOtherDropdown" :class="[
                  'relative px-4 py-2 text-sm font-medium transition-all duration-500 group rounded-full font-sans text-white/80 hover:text-white flex items-center space-x-2',
                  isOtherPageActive ? 'text-white' : ''
                ]">
                  <div class="flex items-center space-x-2">
                    <span :class="[
                      'text-xs transition-all duration-500 opacity-60 group-hover:opacity-100',
                      isOtherPageActive ? 'opacity-100 scale-110' : ''
                    ]">◇</span>
                    <span class="tracking-wide">Other</span>
                    <span :class="[
                      'text-xs transition-all duration-300',
                      isOtherDropdownOpen ? 'rotate-180' : 'rotate-0'
                    ]">▼</span>
                  </div>
                  <div v-if="isOtherPageActive"
                    class="absolute inset-0 border rounded-full bg-white/15 backdrop-blur-sm border-white/20 animate-dynamic-island">
                  </div>
                </button>

                <!-- Other Dropdown Menu -->
                <div v-if="isOtherDropdownOpen"
                  class="absolute left-0 w-48 mt-2 overflow-hidden transition-all duration-300 origin-top border shadow-2xl top-full rounded-2xl backdrop-blur-2xl bg-black/90 border-white/20 animate-dropdown">
                  <div class="p-2 space-y-1">
                    <router-link v-for="item in otherDropdownItems" :key="`dropdown-${item.name}`" :to="item.path"
                      @click="isOtherDropdownOpen = false" :class="[
                        'flex items-center w-full px-3 py-2 font-sans text-sm font-medium transition-all duration-300 rounded-xl group',
                        route.path === item.path ? 'bg-white/15 text-white border border-white/20' : 'text-white/80 hover:bg-white/10 hover:text-white'
                      ]">
                      <span :class="[
                        'mr-3 text-white/60 group-hover:text-white transition-all duration-300',
                        route.path === item.path ? 'text-white' : ''
                      ]">{{ item.icon }}</span>
                      {{ item.name }}
                    </router-link>
                  </div>
                </div>
              </div>
            </div>

            <div class="w-px h-6 mx-4 bg-white/20"></div>

            <template v-if="!isLoggedIn">
              <router-link to="/login"
                class="px-6 py-2 font-sans text-sm font-medium text-black transition-all duration-500 bg-white rounded-full hover:bg-white/90 hover:shadow-lg hover:scale-105 active:scale-95">
                Sign Up
              </router-link>
            </template>

            <div v-else class="relative user-menu-interactive-area">
              <button @click="toggleUserMenu"
                class="flex items-center justify-center w-10 h-10 p-0.5 overflow-hidden transition-all duration-500 bg-white/15 rounded-full hover:bg-white/25 hover:scale-110 backdrop-blur-sm border border-white/20">
                <img :src="currentUser.avatar" alt="User" class="object-cover w-full h-full rounded-full" />
              </button>

              <div v-if="isUserMenuOpen"
                class="absolute right-0 w-64 mt-3 overflow-hidden transition-all duration-300 origin-top-right border shadow-2xl rounded-2xl backdrop-blur-2xl bg-black/90 border-white/20 animate-dropdown">
                <div class="p-4 border-b border-white/10">
                  <div class="flex items-center space-x-3">
                    <img :src="currentUser.avatar" class="w-12 h-12 border-2 rounded-full border-white/10"
                      :alt="currentUser.name">
                    <div>
                      <p class="text-sm font-medium text-white">{{ currentUser.name }}</p>
                      <p class="text-xs text-white/60">{{ currentUser.email }}</p>
                      <p class="mt-1 text-xs font-semibold uppercase text-sky-400">{{ currentUser.role }}</p>
                    </div>
                  </div>
                </div>
                <div class="p-2 space-y-1">
                  <router-link to="/profile" @click="isUserMenuOpen = false"
                    class="flex items-center w-full px-3 py-2 font-sans text-sm font-medium text-white transition-all duration-300 rounded-xl hover:bg-white/10 group">
                    <span class="mr-3 text-white/60 group-hover:text-white">◐</span>
                    Profile
                  </router-link>
                  <router-link v-if="isAdmin" to="/admin/dashboard" @click="isUserMenuOpen = false"
                    class="flex items-center w-full px-3 py-2 font-sans text-sm font-medium text-white transition-all duration-300 rounded-xl hover:bg-white/10 group">
                    <span class="mr-3 text-white/60 group-hover:text-white">◈</span>
                    Admin Panel
                  </router-link>
                  <hr class="my-2 border-white/10">
                  <button @click="logout"
                    class="flex items-center w-full px-3 py-2 font-sans text-sm font-medium transition-all duration-300 text-white/80 rounded-xl hover:bg-red-500/10 hover:text-red-400 group">
                    <span class="mr-3 text-white/60 group-hover:text-red-400">◊</span>
                    Sign Out
                  </button>
                </div>
              </div>
            </div>
          </div>
        </div>

        <!-- Mobile Menu Toggle -->
        <button :class="[
          'relative p-3 transition-all duration-500 rounded-full md:hidden backdrop-blur-sm border',
          'bg-white/10 hover:bg-white/20 border-white/20 text-white hover:scale-110 active:scale-95',
          isMenuOpen ? 'rotate-90 bg-white/20' : 'rotate-0'
        ]" @click="toggleMenu">
          <div class="flex flex-col items-center justify-center w-5 h-5">
            <span
              :class="['block h-0.5 w-5 bg-white rounded-full transition-all duration-500', isMenuOpen ? 'rotate-45 translate-y-0.5' : '-translate-y-1']"></span>
            <span
              :class="['block h-0.5 w-5 bg-white rounded-full transition-all duration-500', isMenuOpen ? 'opacity-0 scale-0' : 'opacity-100 scale-100']"></span>
            <span
              :class="['block h-0.5 w-5 bg-white rounded-full transition-all duration-500', isMenuOpen ? '-rotate-45 -translate-y-0.5' : 'translate-y-1']"></span>
          </div>
        </button>
      </div>
    </div>
  </nav>
</template>

<style scoped>
@keyframes dynamic-island {
  0% {
    transform: scale(1);
  }

  50% {
    transform: scale(1.05);
  }

  100% {
    transform: scale(1);
  }
}

@keyframes dropdown {
  from {
    opacity: 0;
    transform: translateY(-10px) scale(0.95);
  }

  to {
    opacity: 1;
    transform: translateY(0) scale(1);
  }
}

@keyframes slide-down {
  from {
    opacity: 0;
    transform: translateY(-20px) scale(0.95);
  }

  to {
    opacity: 1;
    transform: translateY(0) scale(1);
  }
}

.animate-dynamic-island {
  animation: dynamic-island 0.8s ease-out;
}

.animate-dropdown {
  animation: dropdown 0.3s ease-out;
}

.animate-slide-down {
  animation: slide-down 0.3s ease-out;
}

.backdrop-blur-2xl {
  backdrop-filter: blur(32px);
  -webkit-backdrop-filter: blur(32px);
}

.backdrop-blur-xl {
  backdrop-filter: blur(24px);
  -webkit-backdrop-filter: blur(24px);
}

nav {
  min-width: auto;
  max-width: calc(100vw - 2rem);
}

/* Smooth transitions for all interactive elements */
* {
  transition-timing-function: cubic-bezier(0.4, 0, 0.2, 1);
}

/* Enhanced shadow effects */
.shadow-2xl {
  box-shadow: 0 20px 40px -10px rgba(0, 0, 0, 0.3), 0 10px 20px -15px rgba(0, 0, 0, 0.2);
}

/* Mobile responsive adjustments */
@media (min-width: 768px) {
  nav>div {
    max-width: 1024px;
  }
}

/* Enhanced mobile touch interactions */
@media (hover: none) and (pointer: coarse) {
  .hover\:scale-105:active {
    transform: scale(1.02);
  }

  .hover\:scale-110:active {
    transform: scale(1.05);
  }
}
</style>