<script setup lang="ts">
import { ref, onMounted, onUnmounted } from 'vue';
import Navbar from '../Navbar.vue';
import VisionMission from '../VisionMission.vue';
import Events from '../Events.vue';
import Divisions from '../Divisions.vue';
import test from '../test.vue';
import Footer from '../footer.vue';
import News from '../News.vue';

const velocity = ref(2);
const targetVelocity = ref(2);
const position = ref(0);
const scrollContainerRef = ref<HTMLElement | null>(null);
let animationFrame: number;

const startScrolling = () => {
    const animate = () => {
        if (scrollContainerRef.value) {
            velocity.value += (targetVelocity.value - velocity.value) * 0.1;
            position.value -= velocity.value;
            if (position.value <= -scrollContainerRef.value.scrollWidth / 2) {
                position.value = 0;
            }
            scrollContainerRef.value.style.transform = `translateX(${position.value}px)`;
        }
        animationFrame = requestAnimationFrame(animate);
    };
    animationFrame = requestAnimationFrame(animate);
};

const stopScrolling = () => {
    cancelAnimationFrame(animationFrame);
};

const slowDown = () => {
    targetVelocity.value = 0.5;
};

const speedUp = () => {
    targetVelocity.value = 2;
};

onMounted(() => {
    startScrolling();
    rotateText();

    if (scrollContainerRef.value) {
        scrollContainerRef.value.addEventListener("mouseenter", slowDown);
        scrollContainerRef.value.addEventListener("mouseleave", speedUp);
    }
});

onUnmounted(() => {
    stopScrolling();

    if (scrollContainerRef.value) {
        scrollContainerRef.value.removeEventListener("mouseenter", slowDown);
        scrollContainerRef.value.removeEventListener("mouseleave", speedUp);
    }
});

const texts = [
    '<span class="text-blue-500">Kaustav Cabinet</span>',
    'Empowering Innovation',
    'Leading with Vision'
];

const currentIndex = ref(0);
const animatedText = ref(texts[currentIndex.value]);

const rotateText = () => {
    setInterval(() => {
        currentIndex.value = (currentIndex.value + 1) % texts.length;
        animatedText.value = texts[currentIndex.value];
    }, 3000);
};
</script>

<template>
    <div class="min-h-screen font-montserrat">
        <Navbar />
        <section id="home" class="relative flex items-center h-screen">
            <div class="absolute inset-0">
                <img src="../../../public/puma-bag.JPG" class="object-cover w-full h-full" alt="Background" />
                <div class="absolute inset-0 bg-gradient-to-b from-black/70 to-black/50"></div>
            </div>
            <div class="relative max-w-4xl px-8 pt-20 md:px-16 md:pt-32">
                <h1 class="text-5xl font-extrabold text-white md:text-7xl animate-fadeInUp">
                    PUMA INFORMATICS
                </h1>
                <p class="mt-3 text-2xl font-medium text-white/90 animate-fadeInUp animate-delay-200">
                    <span class="inline-block animate-rotateText" v-html="animatedText"></span>
                </p>
                <p class="mt-2 text-lg text-white/80 md:text-xl animate-fadeInUp animate-delay-300">
                    Lorem ipsum dolor sit amet consectetur adipisicing elit. Quasi sequi quis ullam, dolorum fuga.
                </p>
                <a href="#vision"
                    class="inline-block px-8 py-3 mt-6 text-black transition-colors bg-white rounded-full hover:bg-gray-100 animate-fadeInUp animate-delay-400">
                    Discover More
                </a>
            </div>
        </section>
        <Events />
        <News />
        <Divisions />
        <test />
        <Footer />
    </div>
</template>

<style scoped>
@import url('https://fonts.googleapis.com/css2?family=Montserrat:wght@400;600;800&display=swap');

.font-montserrat {
    font-family: 'Montserrat', sans-serif;
}

@keyframes rotateText {
    0% {
        opacity: 0;
        transform: rotateX(90deg);
    }

    50% {
        opacity: 1;
        transform: rotateX(0deg);
    }

    100% {
        opacity: 0;
        transform: rotateX(-90deg);
    }
}

.animate-rotateText {
    display: inline-block;
    animation: rotateText 3s infinite ease-in-out;
}
</style>
