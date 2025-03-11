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
    <footer :class="[
        'w-full py-6 transition-all duration-300',
        isScrolled ? 'bg-black shadow-md' : 'bg-transparent'
    ]">
        <div class="container px-4 mx-auto">
            <div class="flex flex-col items-center justify-between md:flex-row">
                <div :class="[
                    'text-lg font-semibold transition-colors',
                    isScrolled ? 'text-white' : 'text-white'
                ]">
                    &copy; {{ new Date().getFullYear() }} PUMA. All Rights Reserved.
                </div>
                <div class="flex mt-4 space-x-6 md:mt-0">
                    <a v-for="item in ['Privacy Policy', 'Terms of Service', 'Contact']" :key="item"
                        :href="'#' + item.toLowerCase().replace(/ /g, '-')" :class="[
                            'text-sm font-medium transition-colors',
                            isScrolled ? 'text-white hover:text-gray-900' : 'text-white/90 hover:text-white'
                        ]">
                        {{ item }}
                    </a>
                </div>
            </div>
        </div>
    </footer>
</template>