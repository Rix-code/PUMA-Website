<script setup lang="ts">
import { ref, onMounted } from 'vue';
import Navbar from '../Navbar.vue'; 
import Footer from '../Footer.vue';   

const isLoading = ref<boolean>(true);

const pinColors = ['bg-gray-700', 'bg-slate-700', 'bg-zinc-600', 'bg-neutral-700'];
const noteBgColor = 'bg-gradient-to-br from-gray-50 to-slate-100';

const getPinColor = (index: number) => pinColors[index % pinColors.length];

onMounted(() => {
    setTimeout(() => {
        isLoading.value = false;
    }, 300);
});
</script>

<template>
    <Navbar />
    <div
        class="relative flex flex-col items-center justify-center min-h-screen pt-20 pb-20 text-center bg-gradient-to-br from-white via-gray-50 to-slate-50">
        <div class="absolute inset-0 dot-background"></div>
        <div class="absolute inset-0 opacity-10"
            style="background-image: radial-gradient(circle at 1px 1px, rgba(100,116,139,0.15) 1px, transparent 0); background-size: 32px 32px;">
        </div>

        <svg class="absolute inset-0 z-0 w-full h-full pointer-events-none" preserveAspectRatio="none">
            <line x1="10%" y1="15%" x2="40%" y2="45%" stroke="#e5e7eb" stroke-width="1" stroke-dasharray="4,4"
                opacity="0.6" />
            <line x1="90%" y1="25%" x2="60%" y2="55%" stroke="#d1d5db" stroke-width="1" stroke-dasharray="4,4"
                opacity="0.6" />
            <line x1="25%" y1="85%" x2="75%" y2="60%" stroke="#e5e7eb" stroke-width="1" stroke-dasharray="4,4"
                opacity="0.6" />
            <line x1="50%" y1="5%" x2="50%" y2="95%" stroke="#d1d5db" stroke-width="0.5" stroke-dasharray="2,2"
                opacity="0.4" />
            <line x1="5%" y1="50%" x2="95%" y2="50%" stroke="#d1d5db" stroke-width="0.5" stroke-dasharray="2,2"
                opacity="0.4" />
        </svg>

        <main class="relative z-10 p-6 transform"
            :class="{ 'opacity-0 translate-y-5': isLoading, 'opacity-100 translate-y-0 transition-all duration-700 ease-out': !isLoading }">
            <div class="relative inline-block">
                <div :class="`relative p-8 sm:p-12 md:p-16 ${noteBgColor} border border-gray-300 shadow-2xl transform -rotate-1 group`"
                    style="clip-path: polygon(0 0, 100% 0, 100% 93%, 93% 100%, 0 100%); min-width: 300px; max-width: 600px;">

                    <div
                        :class="`absolute -top-2.5 left-1/4 w-5 h-5 ${getPinColor(0)} rounded-full shadow-lg z-20 group-hover:scale-110 transition-transform duration-300`">
                        <div class="absolute bg-white rounded-full inset-1 opacity-40"></div>
                    </div>
                    <div
                        :class="`absolute -top-2.5 right-1/4 w-5 h-5 ${getPinColor(1)} rounded-full shadow-lg z-20 group-hover:scale-110 transition-transform duration-300`">
                        <div class="absolute bg-white rounded-full inset-1 opacity-40"></div>
                    </div>
                    <div
                        :class="`absolute -bottom-2.5 left-1/3 w-4 h-4 ${getPinColor(2)} rounded-full shadow-lg z-20 group-hover:scale-110 transition-transform duration-300`">
                        <div class="absolute bg-white rounded-full inset-0.5 opacity-40"></div>
                    </div>


                    <div
                        class="absolute px-3 py-1 font-mono text-sm font-bold tracking-wider text-red-700 uppercase transform border-2 border-red-600 top-6 left-6 -rotate-[15deg] opacity-80 group-hover:opacity-100 transition-opacity">
                        CLASSIFIED
                    </div>
                    <div
                        class="absolute px-4 py-1.5 font-mono text-xs font-semibold tracking-wider text-gray-700 uppercase transform bg-yellow-300/70 border border-yellow-500/50 shadow-sm bottom-6 right-6 rotate-[10deg] opacity-90 group-hover:opacity-100 transition-opacity">
                        SITE UPDATE PENDING
                    </div>


                    <header class="relative mb-8 text-center">
                        <div class="relative inline-block">
                            <h1
                                class="mb-2 font-mono text-5xl font-bold tracking-wider text-black uppercase sm:text-6xl md:text-7xl">
                                COMING <span
                                    class="text-transparent bg-gradient-to-r from-gray-700 to-black bg-clip-text">SOON</span>
                            </h1>
                        </div>
                        <p
                            class="max-w-md mx-auto mt-1 font-mono text-xl leading-7 tracking-wide text-gray-500 uppercase">
                            Project Status: Active Development
                        </p>
                    </header>

                    <div class="w-3/4 h-px mx-auto my-8 bg-gray-300"></div>

                    <p class="px-4 mb-6 font-mono text-lg text-gray-700 sm:text-xl">
                        Our agents are diligently working on new features.
                        This section is currently <strong class="font-semibold text-black">under wraps</strong>.
                    </p>
                    <p class="font-mono text-gray-600 text-md">
                        Stay tuned for further intelligence.
                    </p>

                    <div class="mt-10">
                        <span class="font-mono text-sm text-gray-500 uppercase">Clearance Level: Authorized Personnel
                            Only</span>
                    </div>


                    <div class="absolute bottom-0 right-0 w-10 h-10 bg-gray-300/80 opacity-60 group-hover:opacity-80"
                        style="clip-path: polygon(100% 0, 0 100%, 100% 100%);"></div>
                </div>

                <div class="absolute mt-8 transform cursor-default top-full -right-10 md:-right-20 rotate-3 group"
                    style="width: 200px;">
                    <div
                        :class="`absolute -top-1.5 left-1/2 transform -translate-x-1/2 w-3.5 h-3.5 ${getPinColor(3)} rounded-full shadow-md z-10`">
                        <div class="absolute bg-white rounded-full inset-0.5 opacity-30"></div>
                    </div>
                    <div class="px-4 py-3 border border-gray-200 shadow-lg bg-gradient-to-br from-slate-50 to-gray-100"
                        style="clip-path: polygon(0 0, 100% 0, 100% 88%, 88% 100%, 0 100%);">
                        <p class="font-mono text-xs font-bold tracking-wider text-gray-600 uppercase">INTEL UPDATE:</p>
                        <p class="mt-1 font-mono text-sm text-gray-700">404?</p>
                        <div class="mt-1.5 h-px bg-gray-300/70 w-full"></div>
                        <p class="mt-1.5 font-mono text-[0.7rem] text-gray-500">FILE: #CS001</p>
                    </div>
                </div>

            </div>
        </main>
    </div>
    <Footer />
</template>

<style>

.dot-background {
    background-image: radial-gradient(circle at 2px 2px, rgba(107, 114, 128, 0.1) 1px, transparent 0);
    background-size: 25px 25px;
    background-position: 0 0, 12.5px 12.5px;
    animation: dot-drift 25s linear infinite;
}

@keyframes dot-drift {
    0% {
        background-position: 0 0, 12.5px 12.5px;
    }

    100% {
        background-position: 25px 25px, 37.5px 37.5px;
    }
}

.group:hover .absolute.-top-2\.5,
.group:hover .absolute.-top-1\.5,
.group:hover .absolute.-bottom-2\.5 {
    animation: pin-subtle 0.4s ease-in-out;
}

@keyframes pin-subtle {

    0%,
    100% {
        transform: translateX(-50%) rotate(0deg);
    }

    50% {
        transform: translateX(-50%) rotate(-2deg) scale(1.05);
    }
}

.absolute[class*="left-1/4"],
.absolute[class*="right-1/4"] {
}


.font-mono-space {
    font-family: 'ui-monospace', 'SFMono-Regular', 'Menlo', 'Monaco', 'Consolas', "Liberation Mono", "Courier New", monospace;
}

svg line {
    animation: string-flow-subtle 8s ease-in-out infinite alternate;
}

@keyframes string-flow-subtle {
    0% {
        stroke-dashoffset: 0;
        opacity: 0.3;
    }

    50% {
        stroke-dashoffset: 15;
        opacity: 0.5;
    }

    100% {
        stroke-dashoffset: 0;
        opacity: 0.3;
    }
}


</style>