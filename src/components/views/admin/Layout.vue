<script setup lang="ts">
import { ref, computed} from 'vue'
import { useRoute } from 'vue-router'
import SideBar from './Sidebar.vue'

const isCollapsed = ref(false)

const route = useRoute()

type RoutePathsType = '/admin' | '/admin/news' | '/admin/users' | '/admin/settings' | '/admin/event ' | string;

const routeTitles: Record<RoutePathsType, string> = {
    '/admin/dashboard': 'Dashboard',
    '/admin/news': 'News Management',
    '/admin/users': 'User Management',
    '/admin/settings': 'System Settings',
    '/admin/event': 'Event Management',
    '/admin/member': 'Member Management',
    '/admin/organizations': 'Organizations Management',
}

const pageTitle = computed(() => {
    return routeTitles[route.path as RoutePathsType] || 'Dashboard'
})

const breadcrumbs = computed(() => {
    const paths = route.path.split('/').filter(Boolean)
    let currentPath = ''

    return paths.map(path => {
        currentPath += `/${path}`
        return {
            name: path.charAt(0).toUpperCase() + path.slice(1),
            path: currentPath
        }
    })
})

const handleSidebarToggle = (collapsed: boolean) => {
    isCollapsed.value = collapsed
}

</script>
<template>
    <div class="flex h-screen bg-gray-100">
        <SideBar @toggle="handleSidebarToggle" />
        <div :class="[
            'flex-1 transition-all duration-300 overflow-hidden',
            isCollapsed ? 'ml-16 sm:ml-20' : 'ml-16 sm:ml-64'
        ]">
            <header
                class="sticky top-0 z-20 flex items-center justify-between h-16 px-4 border-b sm:px-6 bg-gradient-to-r from-black/90 to-black/80 backdrop-blur-lg border-white/10">
                <div class="flex items-center">
                    <div class="items-center hidden text-sm sm:flex text-white/70">
                        <router-link v-for="(crumb, index) in breadcrumbs" :key="index" :to="crumb.path"
                            class="transition-colors duration-200 hover:text-white">
                            {{ crumb.name }}
                            <span v-if="index < breadcrumbs.length - 1" class="mx-2">/</span>
                        </router-link>
                    </div>

                    <h1 class="text-lg font-medium text-white sm:hidden">
                        <slot name="header-title">{{ pageTitle }}</slot>
                    </h1>
                </div>
                
                <div class="flex items-center space-x-1 sm:space-x-3">
                    <slot name="header-actions">
                        <h1 class="hidden text-lg font-medium text-white sm:block">
                            <slot name="header-title">{{ pageTitle }}</slot>
                        </h1>
                    </slot>
                </div>
            </header>

            <main class="p-4 sm:p-6 overflow-auto h-[calc(100vh-4rem)]">
                <div class="p-4 mb-6 bg-white rounded-lg shadow-md sm:p-6">
                    <slot></slot>
                </div>
            </main>
        </div>
    </div>
</template>
<style scoped>
@media (max-width: 640px) {
    .breadcrumb {
        display: none;
    }
}

.mobile-menu-enter-active,
.mobile-menu-leave-active {
    transition: transform 0.3s ease;
}

.mobile-menu-enter-from,
.mobile-menu-leave-to {
    transform: translateX(-100%);
}
</style>