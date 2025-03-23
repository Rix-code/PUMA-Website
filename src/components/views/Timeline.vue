<script setup lang="ts">
import { ref, onMounted, computed, onBeforeUnmount } from 'vue'
import Navbar from '../Navbar.vue';
import Footer from '../Footer.vue';

const isScrolled = ref(false);
const activeEvent = ref<number | null>(null); 
const isHoveringTimeline = ref(false);

const timelineEvents = ref([
    { id: 1, year: 2023, title: "lorem", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit." },
    { id: 2, year: 2024, title: "ipsum", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit." },
    { id: 3, year: 2025, title: "dolor", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit." },
    { id: 4, year: 2026, title: "amet", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit." },
    { id: 5, year: 2027, title: "consectetur", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit." }
]);

const handleScroll = () => {
    isScrolled.value = window.scrollY > 50;
};

onMounted(() => {
    window.addEventListener('scroll', handleScroll);
    if (timelineEvents.value.length > 0) {
        activeEvent.value = timelineEvents.value[0].id; 
    }
});

onBeforeUnmount(() => {
    window.removeEventListener('scroll', handleScroll);
});

const setActiveEvent = (id: number) => {
    activeEvent.value = id;
};

const timelineProgress = computed(() => {
    if (activeEvent.value === null) return 0;
    const index = timelineEvents.value.findIndex(event => event.id === activeEvent.value);
    return ((index + 1) / timelineEvents.value.length) * 100;
});

const timelineIcon = '<circle cx="10" cy="10" r="6" /><path d="M10 4v6M10 10l3 3" />';
</script>


<template>
    <Navbar />
    <div class="min-h-screen py-12 font-mono text-white bg-black timeline-container">
        <div class="absolute inset-0 grid-lines opacity-10"></div>
        <main class="container relative z-10 px-4 py-20 mx-auto">
            <div class="mb-20 text-center">
                <h1 class="relative inline-block mb-4 text-4xl font-bold">
                    PUMA TIMELINE
                    <div
                        class="absolute w-full h-px bg-gradient-to-r from-transparent via-white to-transparent -bottom-2">
                    </div>
                </h1>
                <p class="max-w-2xl mx-auto mt-6 text-lg text-white/70">
                    Lorem ipsum, dolor sit amet consectetur adipisicing elit. Ex saepe repudiandae a cumque, in minus deserunt quam laboriosam ab blanditiis rerum minima quo, repellendus harum, sit tempore placeat cupiditate rem.
                </p>
            </div>

            <div class="relative mt-24" @mouseenter="isHoveringTimeline = true"
                @mouseleave="isHoveringTimeline = false">
                <div class="absolute h-0.5 bg-white/20 left-0 right-0 top-10 md:top-20"></div>

                <div class="absolute h-0.5 bg-white left-0 top-10 md:top-20 transition-all duration-700 ease-in-out"
                    :style="`width: ${timelineProgress}%`"></div>

                <div class="relative flex flex-col items-start justify-between md:flex-row">
                    <div v-for="event in timelineEvents" :key="event.id" 
                         class="relative px-2 mb-16 md:w-1/6 md:mb-0 group md:px-3"
                         @mouseenter="setActiveEvent(event.id)">

                        <div class="absolute left-0 md:left-1/2 transform md:-translate-x-1/2 w-6 h-6 rounded-full border-2 border-white bg-black top-8 md:top-[74px] z-10"
                            :class="{ 'bg-white': activeEvent === event.id }">
                            <div class="absolute inset-0 bg-white rounded-full animate-ping"
                                v-if="activeEvent === event.id && isHoveringTimeline" style="animation-duration: 2s;">
                            </div>
                        </div>

                        <div class="pl-10 mb-2 text-sm font-bold md:pl-0 md:text-center">
                            {{ event.year }}
                        </div>

                        <div
                            class="pl-10 transition-all duration-500 md:pl-0 md:transform md:scale-90 md:group-hover:scale-100">
                            <div class="flex items-center justify-center mb-3 bg-black border rounded-lg w-14 h-14 border-white/30 md:mx-auto"
                                :class="{ 'border-white border-2': activeEvent === event.id }">
                                <svg xmlns="http://www.w3.org/2000/svg" class="w-8 h-8" viewBox="0 0 20 20" fill="none"
                                    stroke="currentColor"
                                    :class="{ 'text-white': activeEvent === event.id, 'text-white/70': activeEvent !== event.id }">
                                    <g v-html="timelineIcon"></g>
                                </svg>
                            </div>

                            <h3 class="mb-2 text-lg font-bold md:text-center"
                                :class="{ 'text-white': activeEvent === event.id, 'text-white/70': activeEvent !== event.id }">
                                {{ event.title }}
                            </h3>

                            <div class="mt-2 text-sm text-white/60"
                                :class="{ 'block': activeEvent === event.id, 'hidden md:block': activeEvent !== event.id }">
                                {{ event.description }}
                            </div>

                            <div
                                class="absolute hidden p-4 mb-4 transition-opacity transform -translate-x-1/2 border rounded-lg opacity-0 pointer-events-none w-72 md:block bottom-full left-1/2 bg-black/90 border-white/20 group-hover:opacity-100">
                                <div class="text-sm text-white/80">{{ event.description }}</div>
                                <div
                                    class="absolute bottom-0 w-3 h-3 transform rotate-45 -translate-x-1/2 translate-y-1/2 border-b border-r left-1/2 bg-black/90 border-white/20">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>
    <Footer />
</template>

<style scoped>
.grid-lines {
    background-image:
        linear-gradient(to right, rgba(255, 255, 255, 0.05) 1px, transparent 1px),
        linear-gradient(to bottom, rgba(255, 255, 255, 0.05) 1px, transparent 1px);
    background-size: 20px 20px;
}

.timeline-container {
    background-color: #000;
    background-image:
        radial-gradient(circle at 50% 10%, rgba(255, 255, 255, 0.03) 0%, transparent 70%),
        linear-gradient(to bottom, rgba(255, 255, 255, 0.02) 0%, transparent 100%);
}

@keyframes pulse {
    0% {
        transform: scale(0.95);
        opacity: 0.7;
    }

    50% {
        transform: scale(1.05);
        opacity: 0.9;
    }

    100% {
        transform: scale(0.95);
        opacity: 0.7;
    }
}

.animate-pulse-slow {
    animation: pulse 3s infinite;
}
</style>