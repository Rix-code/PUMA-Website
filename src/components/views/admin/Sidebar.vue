<script setup lang="ts">
import { ref, computed, onMounted, onUnmounted, reactive, watch } from 'vue'
import { useRoute } from 'vue-router'

const props = defineProps({
    defaultCollapsed: {
        type: Boolean,
        default: false
    }
})

const emit = defineEmits(['toggle'])

const isCollapsed = ref(props.defaultCollapsed)
const isUserMenuOpen = ref(false)
const route = useRoute()
const state = reactive({
    isMobile: false,
    menuPosition: { left: '16rem', top: '4rem' }
})

watch(() => route.path, () => {
    if (isUserMenuOpen.value) {
        updateMenuPosition()
    }
}, { immediate: true })

const currentUser = ref({
    name: 'John Doe',
    role: 'Administrator',
    email: 'john@example.com',
    avatar: 'https://i.pinimg.com/474x/2d/66/90/2d669016a3e3f5316b0589741e8ca834.jpg'
})
const navItems = [
    { name: 'Dashboard', path: '/admin/dashboard', icon: 'M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6', showNumber: false },
    { name: 'Users', path: '/admin/users', icon: 'M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197M13 7a4 4 0 11-8 0 4 4 0 018 0z', showNumber: false },
    { name: 'Events', path: '/admin/event', icon: 'M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z', showNumber: false },
    { name: 'Member', path: '/admin/member', icon: 'M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z', showNumber: false },
    { name: 'Organizations', path: '/admin/organizations', icon: 'M19 21V5a2 2 0 00-2-2H7a2 2 0 00-2 2v16m14 0h2m-2 0h-5m-9 0H3m2 0h5M9 7h1m-1 4h1m4-4h1m-1 4h1m-5 10v-5a1 1 0 011-1h2a1 1 0 011 1v5m-4 0h4', showNumber: false },
    {name: 'News', path: '/admin/news', icon: 'M19 20H5a2 2 0 01-2-2V6a2 2 0 012-2h10a2 2 0 012 2v1m2 13a2 2 0 01-2-2V7m2 13a2 2 0 002-2V9a2 2 0 00-2-2h-2m-4-3H9M7 16h6M7 8h6v4H7V8z', showNumber: false
    }
]

const loadSavedState = () => {
    const savedState = localStorage.getItem('sidebarCollapsed')
    if (savedState !== null) {
        isCollapsed.value = savedState === 'true'
        emit('toggle', isCollapsed.value)
    }
}

const toggleSidebar = () => {
    isCollapsed.value = !isCollapsed.value
    localStorage.setItem('sidebarCollapsed', isCollapsed.value.toString())
    emit('toggle', isCollapsed.value)
}

const toggleUserMenu = () => {
    isUserMenuOpen.value = !isUserMenuOpen.value
    updateMenuPosition()
}

const updateMenuPosition = () => {
    if (isCollapsed.value) {
        state.menuPosition.left = state.isMobile ? '4rem' : '4.5rem'
    } else {
        state.menuPosition.left = '16rem'
    }
}

const activePath = computed(() => {
    return route.path
})

const closeUserMenu = (event: MouseEvent) => {
    const target = event.target as HTMLElement
    if (!target.closest('.user-menu') && isUserMenuOpen.value) {
        isUserMenuOpen.value = false
    }
}

const handleResize = () => {
    state.isMobile = window.innerWidth < 768
    if (state.isMobile && !isCollapsed.value) {
        isCollapsed.value = true
        localStorage.setItem('sidebarCollapsed', 'true')
        emit('toggle', true)
    }
    updateMenuPosition()
}

onMounted(() => {
    document.addEventListener('click', closeUserMenu)
    
    loadSavedState()
    
    handleResize()
    
    window.addEventListener('resize', handleResize)
})

onUnmounted(() => {
    document.removeEventListener('click', closeUserMenu)
    window.removeEventListener('resize', handleResize)
})
</script>

<template>
    <aside :class="[
        'h-screen z-40 transition-all duration-300 border-r border-white/10 fixed left-0 top-0',
        isCollapsed ? 'w-16 sm:w-20' : 'w-64',
        'bg-gradient-to-b from-black to-black/90 backdrop-blur-lg'
    ]">
        <div class="flex items-center justify-between h-16 px-4 border-b border-white/10">
            <div class="flex items-center">
                <div
                    class="flex items-center justify-center flex-shrink-0 w-10 h-10 overflow-hidden bg-white rounded-full">
                    <img src="/logo.png" alt="PUMA Logo" class="object-contain w-8 h-8" />
                </div>
                <span :class="[
                    'ml-3 font-sans text-xl font-bold tracking-wide text-white transition-opacity duration-300',
                    isCollapsed ? 'opacity-0 hidden' : 'opacity-100'
                ]">PUMA</span>
            </div>
            <button @click="toggleSidebar"
                class="flex items-center justify-center w-8 h-8 text-white transition-all duration-200 rounded-full bg-white/10 hover:bg-white/20 focus:outline-none focus:ring-2 focus:ring-white/30">
                <svg xmlns="http://www.w3.org/2000/svg" class="w-5 h-5" fill="none" viewBox="0 0 24 24"
                    stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" :d="isCollapsed
                        ? 'M9 5l7 7-7 7'
                        : 'M15 19l-7-7 7-7'" />
                </svg>
            </button>
        </div>

        <div :class="[
            'transition-all duration-300 border-b border-white/10',
            isCollapsed ? 'px-3 py-4' : 'px-4 py-4'
        ]">
            <div :class="[
                'flex items-center user-menu',
                isCollapsed ? 'justify-center' : 'space-x-3'
            ]">
                <button @click="toggleUserMenu"
                    class="relative flex items-center justify-center overflow-hidden transition-all duration-300 bg-white rounded-full w-9 h-9 hover:ring-2 hover:ring-white/40 focus:outline-none">
                    <img :src="currentUser.avatar" alt="User avatar" class="object-cover w-full h-full rounded-full" />
                </button>

                <div v-if="!isCollapsed" class="flex flex-col overflow-hidden">
                    <span class="text-sm font-medium text-white truncate">{{ currentUser.name }}</span>
                    <span class="text-xs truncate text-white/70">{{ currentUser.role }}</span>
                </div>

                <div v-if="isUserMenuOpen"
                    class="absolute left-0 z-50 w-56 mt-2 overflow-hidden transition-all duration-200 origin-top-left border rounded-lg shadow-lg bg-black/95 border-white/10 backdrop-blur-lg user-menu-dropdown"
                    :style="{ left: state.menuPosition.left, top: state.menuPosition.top }">
                    <div class="px-4 py-3 border-b border-white/10">
                        <p class="text-sm font-medium text-white">{{ currentUser.name }}</p>
                        <p class="text-xs truncate text-white/70">{{ currentUser.email }}</p>
                    </div>
                    <div class="py-1">
                        <router-link to="/profile"
                            class="flex items-center px-4 py-2 text-sm text-white hover:bg-white/10">
                            <svg xmlns="http://www.w3.org/2000/svg" class="w-4 h-4 mr-2" fill="none" viewBox="0 0 24 24"
                                stroke="currentColor">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                    d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z" />
                            </svg>
                            Your Profile
                        </router-link>
                        <router-link to="/" class="flex items-center px-4 py-2 text-sm text-white hover:bg-white/10">
                            <svg xmlns="http://www.w3.org/2000/svg" class="w-4 h-4 mr-2" fill="none" viewBox="0 0 24 24"
                                stroke="currentColor">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                    d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6" />
                            </svg>
                            View Site
                        </router-link>
                        <div class="my-1 border-t border-white/10"></div>
                        <button
                            class="flex items-center w-full px-4 py-2 text-sm text-left text-red-400 hover:bg-white/10">
                            <svg xmlns="http://www.w3.org/2000/svg" class="w-4 h-4 mr-2" fill="none" viewBox="0 0 24 24"
                                stroke="currentColor">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                    d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1" />
                            </svg>
                            Sign out
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <nav class="py-2 overflow-y-auto max-h-[calc(100vh-12rem)]">
            <div class="px-2 space-y-1">
                <router-link v-for="(item, index) in navItems" :key="item.name" :to="item.path" :class="[
                    'flex items-center transition-all duration-200 rounded-lg group',
                    isCollapsed ? 'py-3 px-2 mx-1 justify-center' : 'py-2.5 px-3 mx-1',
                    activePath === item.path
                        ? 'bg-white text-black font-medium'
                        : 'text-white hover:bg-white/10'
                ]">
                    <div class="relative flex-shrink-0">
                        <svg xmlns="http://www.w3.org/2000/svg" :class="[
                            'transition-all duration-300',
                            isCollapsed ? 'w-5 h-5' : 'w-5 h-5'
                        ]" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" :d="item.icon" />
                        </svg>

                        <span v-if="item.showNumber && !isCollapsed" :class="[
                            'absolute -right-1.5 -top-1.5 text-xs w-4 h-4 flex items-center justify-center rounded-full transition-colors duration-300',
                            activePath === item.path
                                ? 'bg-black text-white'
                                : 'bg-white/10 text-white group-hover:bg-white/20'
                        ]">
                            {{ index + 1 }}
                        </span>
                    </div>

                    <span :class="[
                        'transition-all duration-300 truncate',
                        isCollapsed ? 'hidden' : 'ml-3 font-medium text-sm'
                    ]">
                        {{ item.name }}
                    </span>
                </router-link>
            </div>
        </nav>

        <div class="absolute bottom-0 left-0 w-full p-3 border-t border-white/10" v-if="!isCollapsed">
            <button
                class="flex items-center justify-center w-full px-3 py-2 text-sm font-medium text-black transition-all duration-300 bg-white border-0 rounded-lg hover:bg-white/90 focus:outline-none focus:ring-2 focus:ring-white/30">
                <svg xmlns="http://www.w3.org/2000/svg" class="w-4 h-4 mr-2" fill="none" viewBox="0 0 24 24"
                    stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                        d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1" />
                </svg>
                Logout
            </button>
        </div>
        <div class="absolute bottom-0 left-0 w-full p-3 border-t border-white/10" v-else>
            <button
                class="flex items-center justify-center w-full p-2 text-black transition-all duration-300 bg-white rounded-lg hover:bg-white/90 focus:outline-none focus:ring-2 focus:ring-white/30">
                <svg xmlns="http://www.w3.org/2000/svg" class="w-4 h-4" fill="none" viewBox="0 0 24 24"
                    stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                        d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1" />
                </svg>
            </button>
        </div>
    </aside>
</template>

<style scoped>
aside {
    box-shadow: 0 0 25px rgba(0, 0, 0, 0.5);
}

.overflow-y-auto {
    scrollbar-width: thin;
    scrollbar-color: rgba(255, 255, 255, 0.15) rgba(255, 255, 255, 0.03);
}

.overflow-y-auto::-webkit-scrollbar {
    width: 3px;
}

.overflow-y-auto::-webkit-scrollbar-track {
    background: rgba(255, 255, 255, 0.03);
}

.overflow-y-auto::-webkit-scrollbar-thumb {
    background: rgba(255, 255, 255, 0.15);
    border-radius: 3px;
}

.overflow-y-auto::-webkit-scrollbar-thumb:hover {
    background: rgba(255, 255, 255, 0.25);
}

@media (max-width: 768px) {
    aside {
        transform: translateX(0);
        transition: transform 0.3s ease;
    }
    
    aside.closed {
        transform: translateX(-100%);
    }
}

/* Dropdown menu responsive positioning */
@media (max-width: 640px) {
    .user-menu-dropdown {
        left: 4rem !important;
        right: auto !important;
    }
}
</style>