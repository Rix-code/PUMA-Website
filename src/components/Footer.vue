<script setup lang="ts">
import { ref, onMounted, onUnmounted, computed } from 'vue'
import { useRoute } from 'vue-router'

const isScrolled = ref(false)
const currentYear = ref(new Date().getFullYear())
const route = useRoute()

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

const footerBackground = computed(() => {
    if (!isHomePage.value) {
        return 'bg-black/80 backdrop-blur-lg border-t border-white/10'
    } else {
        return isScrolled.value
            ? 'bg-black/80 backdrop-blur-lg border-t border-white/10'
            : 'bg-transparent'
    }
})
</script>

<template>
    <footer :class="[
        'w-full py-8 transition-all duration-500 relative overflow-hidden z-40',
        footerBackground
    ]">
        <div class="absolute inset-0 grid-lines opacity-20"></div>

        <div class="container relative z-10 px-4 mx-auto">
            <div class="flex flex-col items-center justify-between md:flex-row">
                <div class="flex items-center mb-6 md:mb-0">
                    <img src="../../public/logo.png" alt="PUMA Logo" class="w-auto h-10 p-1 bg-white rounded-full" />
                    <div class="ml-4">
                        <div class="flex items-center font-mono text-xl font-bold tracking-wider text-white">
                            <span>PUMA</span>
                            <span
                                class="px-2 py-1 ml-2 text-xs border rounded-full bg-white/10 border-white/20 text-white/80">EST.2023</span>
                        </div>
                        <div class="mt-1 font-mono text-sm text-white/70">
                            &copy; {{ currentYear }} <span class="text-white">FUTURE FORWARD</span>
                        </div>
                    </div>
                </div>

                <div class="w-full space-y-4 md:w-auto">
                    <div class="flex flex-wrap justify-center gap-2 md:justify-end">
                        <a v-for="(item, index) in [
                            { name: 'Privacy Policy', path: '#privacy-policy' },
                            { name: 'Terms', path: '#terms-of-service' },
                            { name: 'FAQ', path: '#faq' },
                            { name: 'Contact', path: '/contact' }
                        ]" :key="item.name" :href="item.path"
                            class="flex items-center px-3 py-2 font-mono text-xs font-medium text-white uppercase transition-all duration-300 border rounded-lg border-white/10 hover:bg-white hover:text-black group">
                            <span
                                class="mr-1.5 text-[9px] px-1 py-0.5 rounded-sm bg-white/10 text-white group-hover:bg-black group-hover:text-white transition-colors duration-300">
                                {{ (index + 1).toString().padStart(2, '0') }}
                            </span>
                            {{ item.name }}
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </footer>
</template>

<style scoped>
.grid-lines {
    background-image:
        linear-gradient(to right, rgba(255, 255, 255, 0.05) 1px, transparent 1px),
        linear-gradient(to bottom, rgba(255, 255, 255, 0.05) 1px, transparent 1px);
    background-size: 20px 20px;
}

footer {
    box-shadow: 0 -10px 30px rgba(0, 0, 0, 0.2);
}

footer.bg-black\/80 {
    box-shadow: 0 -5px 20px rgba(0, 0, 0, 0.4);
}
</style>
