<script setup lang="ts">
import { ref, onMounted, computed } from 'vue'
import { useRouter } from 'vue-router'

const router = useRouter()
const countdown = ref(10)
const isCountdownActive = ref(true)

const countdownText = computed(() => {
    return countdown.value > 0
        ? `Redirecting in ${countdown.value}s`
        : 'Redirecting...'
})

const startCountdown = () => {
    const timer = setInterval(() => {
        countdown.value--

        if (countdown.value <= 0) {
            clearInterval(timer)
            router.push('/')
        }
    }, 1000)

    return timer
}

onMounted(() => {
    const timer = startCountdown()

    return () => {
        clearInterval(timer)
    }
})

const stopRedirect = () => {
    isCountdownActive.value = false
    countdown.value = 0
}

const goHome = () => {
    router.push('/')
}

// Random error codes that appear to be processing
const errorCodes = ref([
    '0x8007045B',
    'ERR_NETWORK_404',
    'HTTP_NOT_FOUND',
    'PATH_INVALID',
    'NODE_MISSING'
])

// Animation state
const glitchInterval = ref<ReturnType<typeof setInterval> | null>(null)
const glitchActive = ref(false)

onMounted(() => {
    // Create glitch effect interval
    glitchInterval.value = setInterval(() => {
        glitchActive.value = true
        setTimeout(() => {
            glitchActive.value = false
        }, 200)
    }, 3000)

    return () => {
        if (glitchInterval.value) {
            clearInterval(glitchInterval.value)
        }
    }
})
</script>

<template>
    <div class="flex flex-col min-h-screen bg-black">
        <!-- Reuse the same navbar component here -->

        <main class="flex items-center justify-center flex-1 w-full px-4">
            <div class="w-full max-w-4xl">
                <div class="text-center">
                    <div class="relative">
                        <h1 class="font-mono text-9xl font-bold tracking-tighter text-white md:text-[12rem]"
                            :class="{ 'animate-glitch': glitchActive }">
                            404
                        </h1>

                        <div
                            class="absolute top-0 left-0 flex items-center justify-center w-full h-full pointer-events-none">
                            <div class="w-32 h-32 rounded-full bg-purple-500/20 blur-3xl"></div>
                            <div class="w-32 h-32 -ml-10 rounded-full bg-blue-500/20 blur-3xl"></div>
                        </div>
                    </div>

                    <div class="px-3 py-1 mx-auto -mt-4 font-mono text-xs tracking-wider text-white uppercase bg-white/10 w-fit rounded-xl"
                        :class="{ 'animate-pulse': glitchActive }">
                        Page not found
                    </div>

                    <p class="max-w-md mx-auto mt-6 font-mono text-white/70">
                        The page you're looking for doesn't exist or has been moved to another dimension.
                    </p>

                    <div class="flex flex-col items-center justify-center w-full max-w-xs mx-auto mt-6 font-mono">
                        <div v-if="isCountdownActive"
                            class="w-full p-4 mb-4 text-xs text-left text-white rounded-lg bg-white/5">
                            <div class="flex items-center justify-between mb-2">
                                <span>{{ countdownText }}</span>
                                <button @click="stopRedirect" class="text-xs text-white/50 hover:text-white">
                                    Cancel
                                </button>
                            </div>
                            <div class="w-full h-1 overflow-hidden rounded-full bg-white/10">
                                <div class="h-full transition-all duration-1000 bg-white"
                                    :style="{ width: `${(countdown / 10) * 100}%` }"></div>
                            </div>
                        </div>

                        <button @click="goHome"
                            class="w-full px-8 py-3 text-sm font-medium text-black uppercase transition-all duration-300 bg-white border-0 rounded-full hover:bg-white/90">
                            Return to Home
                        </button>

                        <div class="flex flex-wrap items-center justify-center gap-2 mt-8">
                            <div v-for="(code, index) in errorCodes" :key="index"
                                class="px-2 py-1 text-xs text-white rounded bg-white/10">
                                {{ code }}
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>

        <footer class="p-6 font-mono text-xs text-center text-white/50">
            &copy; {{ new Date().getFullYear() }} PUMA · All rights reserved
        </footer>
    </div>
</template>

<style scoped>
@keyframes glitch {
    0% {
        transform: translate(0);
        text-shadow: 0 0 0 rgba(255, 255, 255, 0);
    }

    20% {
        transform: translate(-2px, 2px);
        text-shadow: 3px -3px 0 rgba(255, 0, 255, 0.5);
    }

    40% {
        transform: translate(-2px, -2px);
        text-shadow: -3px 3px 0 rgba(0, 255, 255, 0.5);
    }

    60% {
        transform: translate(2px, 2px);
        text-shadow: 2px 2px 0 rgba(255, 255, 0, 0.5);
    }

    80% {
        transform: translate(2px, -2px);
        text-shadow: -2px -2px 0 rgba(0, 255, 0, 0.5);
    }

    100% {
        transform: translate(0);
        text-shadow: 0 0 0 rgba(255, 255, 255, 0);
    }
}

.animate-glitch {
    animation: glitch 0.5s ease-in-out;
}
</style>
