<script lang="ts">
import { defineComponent } from 'vue';
import Navbar from '../Navbar.vue';
import Footer from '../Footer.vue';

const cardBackgrounds = [
    'from-gray-50 to-slate-100',    
    'from-slate-50 to-gray-100',    
    'from-zinc-50 to-slate-100',      
    'from-neutral-50 to-gray-100',   
    'from-stone-50 to-slate-100',    
    'from-gray-100 to-slate-50',    
    'from-slate-100 to-zinc-50',     
    'from-gray-50 to-neutral-100',  
];

const pinColors = ['bg-gray-700', 'bg-slate-700', 'bg-zinc-600', 'bg-neutral-700', 'bg-stone-600', 'bg-gray-600', 'bg-slate-600', 'bg-zinc-700'];
const evidenceTypes = ['CASE', 'FILE', 'DATA', 'INFO', 'LEAD', 'DOCS', 'INTEL', 'PROOF', 'UNIT'];

export default defineComponent({
    components: {
        Navbar,
        Footer,
    },
    setup() {
        const getCardBg = (index: number) => cardBackgrounds[index % cardBackgrounds.length];
        const getPinColor = (index: number) => pinColors[index % pinColors.length];
        const getEvidenceType = (index: number) => evidenceTypes[index % evidenceTypes.length];

        return {
            getCardBg,
            getPinColor,
            getEvidenceType,
        };
    }
});
</script>

<template>
    <Navbar />
    <div
        class="relative min-h-screen py-12 pt-24 overflow-hidden font-mono text-gray-800 bg-gradient-to-br from-white via-gray-50 to-slate-50">
        <div class="absolute inset-0 dot-background"></div>

        <div class="absolute inset-0 opacity-10"
            style="background-image: radial-gradient(circle at 1px 1px, rgba(100,116,139,0.15) 1px, transparent 0); background-size: 32px 32px;">
        </div>

        <div :class="`absolute w-3 h-3 ${getPinColor(0)} rounded-full shadow-md top-20 left-10 rotate-12`">
            <div class="absolute bg-white rounded-full inset-0.5 opacity-40"></div>
        </div>
        <div :class="`absolute w-2 h-2 ${getPinColor(1)} rounded-full shadow-md top-32 right-20 rotate-45`">
            <div class="absolute bg-white rounded-full inset-0.5 opacity-40"></div>
        </div>
        <div :class="`absolute w-4 h-4 ${getPinColor(2)} rounded-full shadow-md bottom-40 left-16 -rotate-12`">
            <div class="absolute bg-white rounded-full inset-0.5 opacity-40"></div>
        </div>

        <section class="relative z-10 pt-16 pb-12">
            <div class="container px-6 mx-auto text-center">
                <div class="relative max-w-4xl mx-auto group">
                    <div :class="`relative p-8 transform bg-gradient-to-br ${getCardBg(0)} border border-gray-200 shadow-xl hover:shadow-2xl transition-all duration-300 -rotate-1`"
                        style="clip-path: polygon(0 0, 100% 0, 100% 92%, 92% 100%, 0 100%);">
                        <div
                            :class="`absolute -top-2 -left-2 w-4 h-4 ${getPinColor(0)} rounded-full shadow-lg z-10 group-hover:scale-110 transition-transform duration-300`">
                            <div class="absolute bg-white rounded-full inset-1 opacity-40"></div>
                        </div>
                        <div
                            :class="`absolute -top-2 -right-2 w-4 h-4 ${getPinColor(1)} rounded-full shadow-lg z-10 group-hover:scale-110 transition-transform duration-300`">
                            <div class="absolute bg-white rounded-full inset-1 opacity-40"></div>
                        </div>

                        <div
                            class="absolute w-8 h-4 transform rotate-45 bg-gray-100 border border-gray-200 shadow-sm top-2 right-3 opacity-80">
                        </div>

                        <h1 class="mb-4 text-5xl font-bold tracking-wider text-black uppercase case-title">PUMA INFORMATICS</h1>
                        <div class="w-32 h-px mx-auto mb-6 bg-gray-300"></div>
                        <p class="max-w-2xl mx-auto text-lg leading-relaxed text-gray-700">
                            <span
                                class="px-2 py-1 mr-2 text-xs font-bold tracking-wider text-gray-700 uppercase border border-gray-400 rounded">CONFIDENTIAL</span>
                            PUMA Informatics is the official student organization for the Informatics Department at
                            President
                            University. We are dedicated to developing students' capabilities in technology and
                            fostering a community of
                            forward-thinking tech enthusiasts who contribute positively to society.
                        </p>

                        <div
                            class="absolute px-3 py-1 font-mono text-xs font-bold tracking-wider text-gray-600 uppercase transform border border-gray-600 -bottom-2 -right-4 rotate-12 opacity-70">
                            {{ getEvidenceType(0) }} #001
                        </div>
                        <div class="absolute bottom-0 right-0 w-8 h-8 bg-gray-200 opacity-60"
                            style="clip-path: polygon(100% 0, 0 100%, 100% 100%);"></div>
                    </div>
                </div>
            </div>
        </section>

        <section class="container relative z-10 px-6 py-12 mx-auto">
            <div class="relative max-w-4xl mx-auto mb-12 group">
                <div :class="`relative p-6 transform bg-gradient-to-br ${getCardBg(1)} border border-gray-200 shadow-xl hover:shadow-2xl transition-all duration-300 rotate-1`"
                    style="clip-path: polygon(0 0, 100% 0, 100% 92%, 92% 100%, 0 100%);">
                    <div
                        :class="`absolute -top-2 -left-2 w-4 h-4 ${getPinColor(2)} rounded-full shadow-lg z-10 group-hover:scale-110 transition-transform duration-300`">
                        <div class="absolute bg-white rounded-full inset-1 opacity-40"></div>
                    </div>
                    <div
                        :class="`absolute -top-2 -right-2 w-4 h-4 ${getPinColor(3)} rounded-full shadow-lg z-10 group-hover:scale-110 transition-transform duration-300`">
                        <div class="absolute bg-white rounded-full inset-1 opacity-40"></div>
                    </div>
                    <div
                        class="absolute w-6 h-3 transform bg-gray-100 border border-gray-200 shadow-sm bottom-8 left-2 opacity-80 -rotate-12">
                    </div>

                    <div class="text-center">
                        <h2 class="mb-4 text-4xl font-bold tracking-wider text-black uppercase">SUSPECT PROFILE: KAUSTAV
                            CABINET</h2>
                        <div class="w-24 h-px mx-auto mb-6 bg-gray-300"></div>
                        <p class="max-w-2xl mx-auto text-lg leading-relaxed text-gray-700">
                            The Kaustav Cabinet is the current leadership body of PUMA Informatics for the 2024 period.
                            Named
                            after a legendary gem, the cabinet focuses on polishing the potential of each informatics
                            student and creating
                            opportunities for growth and development in the field of technology.
                        </p>
                    </div>

                    <div
                        class="absolute px-3 py-1 font-mono text-xs font-bold tracking-wider text-gray-600 uppercase transform border border-gray-600 -bottom-2 -left-4 -rotate-12 opacity-70">
                        {{ getEvidenceType(1) }} #002
                    </div>
                    <div class="absolute bottom-0 right-0 w-8 h-8 bg-gray-200 opacity-60"
                        style="clip-path: polygon(100% 0, 0 100%, 100% 100%);"></div>
                </div>
            </div>
        </section>

        <section class="container relative z-10 px-6 py-12 mx-auto">
            <div class="grid grid-cols-1 gap-12 md:grid-cols-2">
                <div class="relative group">
                    <div :class="`relative p-6 transform bg-gradient-to-br ${getCardBg(2)} border border-gray-200 shadow-xl hover:shadow-2xl transition-all duration-300 -rotate-2`"
                        style="clip-path: polygon(0 0, 100% 0, 100% 90%, 90% 100%, 0 100%);">
                        <div
                            :class="`absolute -top-2 -left-2 w-3 h-3 ${getPinColor(4)} rounded-full shadow-lg z-10 group-hover:scale-110 transition-transform duration-300`">
                            <div class="absolute bg-white rounded-full inset-0.5 opacity-40"></div>
                        </div>
                        <div
                            :class="`absolute -top-2 -right-2 w-3 h-3 ${getPinColor(5)} rounded-full shadow-lg z-10 group-hover:scale-110 transition-transform duration-300`">
                            <div class="absolute bg-white rounded-full inset-0.5 opacity-40"></div>
                        </div>

                        <div class="flex items-center mb-4">
                            <div
                                class="px-2 py-1 mr-3 text-xs font-bold tracking-wider text-gray-700 uppercase border border-gray-400 rounded">
                                Restricted
                            </div>
                            <h2 class="text-2xl font-bold tracking-wider text-black uppercase">VISION STATEMENT</h2>
                        </div>
                        <div class="w-full h-px mb-3 bg-gray-300"></div>
                        <div class="space-y-3 text-gray-700">
                            <p class="text-lg font-semibold leading-relaxed">
                                Kaustav CABINET PUMA Informatics serves as a platform for informatics students to become
                                an excellent generation with impactful and high-quality intellectual, emotional,
                                spiritual, moral, and social capabilities.
                            </p>
                        </div>

                        <div
                            class="absolute px-3 py-1 font-mono text-xs font-bold tracking-wider text-gray-600 uppercase transform border border-gray-600 -bottom-2 -right-4 rotate-12 opacity-70">
                            {{ getEvidenceType(2) }} #003
                        </div>
                        <div class="absolute bottom-0 right-0 w-6 h-6 bg-gray-200 opacity-60"
                            style="clip-path: polygon(100% 0, 0 100%, 100% 100%);"></div>
                    </div>
                    <svg class="absolute w-12 h-12 transform -bottom-5 -right-5" viewBox="0 0 100 100"
                        preserveAspectRatio="none" style="opacity: 0.4;">
                        <line x1="0" y1="0" x2="100" y2="100" stroke="#dc2626" stroke-width="2"
                            stroke-dasharray="4,4" />
                    </svg>
                </div>

                <div class="relative group">
                    <div :class="`relative p-6 transform bg-gradient-to-br ${getCardBg(3)} border border-gray-200 shadow-xl hover:shadow-2xl transition-all duration-300 rotate-1`"
                        style="clip-path: polygon(0 0, 100% 0, 100% 90%, 90% 100%, 0 100%);">
                        <div
                            :class="`absolute -top-2 -left-2 w-3 h-3 ${getPinColor(6)} rounded-full shadow-lg z-10 group-hover:scale-110 transition-transform duration-300`">
                            <div class="absolute bg-white rounded-full inset-0.5 opacity-40"></div>
                        </div>
                        <div
                            :class="`absolute -top-2 -right-2 w-3 h-3 ${getPinColor(7)} rounded-full shadow-lg z-10 group-hover:scale-110 transition-transform duration-300`">
                            <div class="absolute bg-white rounded-full inset-0.5 opacity-40"></div>
                        </div>

                        <div class="flex items-center mb-4">
                            <div
                                class="px-2 py-1 mr-3 text-xs font-bold tracking-wider text-gray-700 uppercase border border-gray-400 rounded">
                                SENSITIVE
                            </div>
                            <h2 class="text-2xl font-bold tracking-wider text-black uppercase">MISSION BREAKDOWN</h2>
                        </div>
                        <div class="w-full h-px mb-4 bg-gray-300"></div>
                        <div class="space-y-4 text-gray-700">
                            <div v-for="(mission, mIndex) in [
                                { title: 'INTELLECTUAL', text: 'Providing innovative and effective information in the field of technology to create intellectual Informatics students.', borderColor: 'border-slate-400', titleColor: 'text-slate-700' },
                                { title: 'SOCIAL', text: 'Taking an active social role in improving the quality of life in society through initiatives, sustainable collaborations, and developing informatics solutions that have a positive impact locally and globally.', borderColor: 'border-gray-400', titleColor: 'text-gray-700' },
                                { title: 'EMOTIONAL', text: 'Strengthening emotional bonds by optimizing communication forums for conveying information and aspirations of informatics students within the academic community of President University\'s Informatics Department.', borderColor: 'border-neutral-400', titleColor: 'text-neutral-700' },
                                { title: 'MORAL', text: 'Prioritizing moral and integrity in every aspect of activities and learning within the Informatics Department of President University.', borderColor: 'border-stone-400', titleColor: 'text-stone-700' },
                                { title: 'SPIRITUAL', text: 'Integrating spiritual values into every activity and program within PUMA Informatics.', borderColor: 'border-zinc-400', titleColor: 'text-zinc-700' },
                            ]" :key="mIndex" :class="`p-3 bg-white/70 border-l-4 ${mission.borderColor} shadow-sm`">
                                <h3 :class="`mb-1 font-bold ${mission.titleColor}`">{{ mission.title }}</h3>
                                <p class="text-sm">{{ mission.text }}</p>
                            </div>
                        </div>

                        <div
                            class="absolute px-3 py-1 font-mono text-xs font-bold tracking-wider text-gray-600 uppercase transform border border-gray-600 -bottom-2 -left-4 -rotate-12 opacity-70">
                            {{ getEvidenceType(3) }} #004
                        </div>
                        <div class="absolute bottom-0 right-0 w-6 h-6 bg-gray-200 opacity-60"
                            style="clip-path: polygon(100% 0, 0 100%, 100% 100%);"></div>
                    </div>
                </div>
            </div>
        </section>

        <section class="relative pt-12 pb-12">
            <div class="container px-6 mx-auto mb-12">
                <div class="relative max-w-2xl mx-auto group">
                    <div :class="`relative p-4 text-center transform bg-gradient-to-br ${getCardBg(0)} border border-gray-200 shadow-xl hover:shadow-2xl transition-all duration-300 -rotate-1`"
                        style="clip-path: polygon(0 0, 100% 0, 100% 92%, 92% 100%, 0 100%);">
                        <div
                            :class="`absolute -top-2 -left-2 w-3 h-3 ${getPinColor(0)} rounded-full shadow-lg z-10 group-hover:scale-110 transition-transform duration-300`">
                            <div class="absolute bg-white rounded-full inset-0.5 opacity-40"></div>
                        </div>
                        <div
                            :class="`absolute -top-2 -right-2 w-3 h-3 ${getPinColor(1)} rounded-full shadow-lg z-10 group-hover:scale-110 transition-transform duration-300`">
                            <div class="absolute bg-white rounded-full inset-0.5 opacity-40"></div>
                        </div>

                        <h2 class="mb-2 text-4xl font-bold text-black uppercase">EVIDENCE ANALYSIS</h2>
                        <div class="w-24 h-px mx-auto bg-gray-300"></div>
                        <p class="mt-2 text-lg font-bold text-gray-700 uppercase">LOGO PHILOSOPHY INVESTIGATION</p>
                        <div class="absolute bottom-0 right-0 w-8 h-8 bg-gray-200 opacity-60"
                            style="clip-path: polygon(100% 0, 0 100%, 100% 100%);"></div>
                    </div>
                </div>
            </div>

            <div class="container relative z-10 px-6 mx-auto">
                <div class="grid grid-cols-1 gap-12 lg:grid-cols-2">
                    <div class="relative group">
                        <div :class="`relative transform bg-gradient-to-br ${getCardBg(4)} border border-gray-200 shadow-xl hover:shadow-2xl transition-all duration-300 -rotate-1`"
                            style="clip-path: polygon(0 0, 100% 0, 100% 92%, 92% 100%, 0 100%);">
                            <div
                                :class="`absolute -top-2 -left-2 w-4 h-4 ${getPinColor(2)} rounded-full shadow-lg z-10 group-hover:scale-110 transition-transform duration-300`">
                                <div class="absolute bg-white rounded-full inset-1 opacity-40"></div>
                            </div>
                            <div
                                :class="`absolute -top-2 -right-2 w-4 h-4 ${getPinColor(3)} rounded-full shadow-lg z-10 group-hover:scale-110 transition-transform duration-300`">
                                <div class="absolute bg-white rounded-full inset-1 opacity-40"></div>
                            </div>
                            <div
                                class="absolute w-10 h-5 transform bg-gray-100 border border-gray-200 shadow-sm top-4 right-4 opacity-80 rotate-25">
                            </div>

                            <div
                                class="relative flex items-center justify-center h-64 p-8 overflow-hidden bg-gray-100/70">
                                <div class="absolute inset-0 opacity-20 clean-evidence-grid"></div>
                                <div class="relative w-48 h-48 transition-transform duration-500 hover:scale-110">
                                    <img src="../../../public/logo.png" alt="puma logo"
                                        class="object-contain w-full h-full">
                                    <div
                                        class="absolute px-2 py-1 text-xs font-bold text-gray-700 uppercase bg-gray-200 border border-gray-400 rounded shadow-lg -bottom-2 -right-2">
                                        EXHIBIT A
                                    </div>
                                </div>
                            </div>

                            <div class="p-6">
                                <div class="flex items-center mb-4">
                                    <span
                                        class="px-3 py-1 mr-3 text-xs font-bold text-gray-700 uppercase bg-gray-200 border border-gray-300 rounded">EST.2023</span>
                                    <h2 class="text-2xl font-bold tracking-wider text-black uppercase">PUMA INFORMATICS
                                    </h2>
                                </div>
                                <div class="w-full h-px mb-3 bg-gray-300"></div>
                                <div class="space-y-3 text-sm text-gray-700">
                                    <div class="p-3 border-l-4 border-slate-400 bg-slate-50/70">
                                        <p><strong>Finding 1:</strong> Set of trapezoids forming the letter C.
                                            Symbolizes Computer Science faculty with a dynamic, modern impression.</p>
                                    </div>
                                    <div class="p-3 border-l-4 border-gray-400 bg-gray-50/70">
                                        <p><strong>Finding 2:</strong> The two rectangles that make up the IT text.
                                            Represents the Informatics department within the Computing faculty.</p>
                                    </div>
                                    <div class="p-3 border-l-4 border-neutral-400 bg-neutral-50/70">
                                        <p><strong>Finding 3:</strong> Distance Between Letter C Trapezoids. Shows
                                            diversity and inclusion within PUMA Informatics.</p>
                                    </div>
                                </div>
                                <div class="mt-6">
                                    <button
                                        class="flex items-center px-4 py-2 text-xs font-bold text-white transition-all duration-300 border rounded-lg bg-slate-700 border-slate-800 hover:bg-slate-800 group">
                                        <span>INVESTIGATE FURTHER</span>
                                        <svg xmlns="http://www.w3.org/2000/svg"
                                            class="w-4 h-4 ml-2 transition-transform duration-300 group-hover:translate-x-1"
                                            fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
                                        </svg>
                                    </button>
                                </div>
                            </div>

                            <div
                                class="absolute px-3 py-1 font-mono text-xs font-bold tracking-wider text-gray-600 uppercase transform border border-gray-600 -bottom-2 -right-4 rotate-12 opacity-70">
                                {{ getEvidenceType(4) }} #005
                            </div>
                            <div class="absolute bottom-0 right-0 w-8 h-8 bg-gray-200 opacity-60"
                                style="clip-path: polygon(100% 0, 0 100%, 100% 100%);"></div>
                        </div>
                    </div>

                    <div class="relative group">
                        <div :class="`relative transform bg-gradient-to-br ${getCardBg(5)} border border-gray-200 shadow-xl hover:shadow-2xl transition-all duration-300 rotate-1`"
                            style="clip-path: polygon(0 0, 100% 0, 100% 92%, 92% 100%, 0 100%);">
                            <div
                                :class="`absolute -top-2 -left-2 w-4 h-4 ${getPinColor(4)} rounded-full shadow-lg z-10 group-hover:scale-110 transition-transform duration-300`">
                                <div class="absolute bg-white rounded-full inset-1 opacity-40"></div>
                            </div>
                            <div
                                :class="`absolute -top-2 -right-2 w-4 h-4 ${getPinColor(5)} rounded-full shadow-lg z-10 group-hover:scale-110 transition-transform duration-300`">
                                <div class="absolute bg-white rounded-full inset-1 opacity-40"></div>
                            </div>
                            <div
                                class="absolute w-8 h-4 transform bg-gray-100 border border-gray-200 shadow-sm top-4 left-4 opacity-80 -rotate-15">
                            </div>

                            <div
                                class="relative flex items-center justify-center h-64 p-8 overflow-hidden bg-gray-100/70">
                                <div class="absolute inset-0 opacity-20 clean-evidence-grid"></div>
                                <div class="relative w-48 h-48 transition-transform duration-500 hover:scale-110">
                                    <img src="../../../public/kaustav.png" alt="kaustav logo"
                                        class="object-contain w-full h-full">
                                    <div
                                        class="absolute px-2 py-1 text-xs font-bold text-gray-700 uppercase bg-gray-200 border border-gray-400 rounded shadow-lg -bottom-2 -right-2">
                                        EXHIBIT B
                                    </div>
                                </div>
                            </div>

                            <div class="p-6">
                                <div class="flex items-center mb-4">
                                    <span
                                        class="px-3 py-1 mr-3 text-xs font-bold text-gray-700 uppercase bg-gray-200 border border-gray-300 rounded">EST.2024</span>
                                    <h2 class="text-2xl font-bold tracking-wider text-black uppercase">KAUSTAV CABINET
                                    </h2>
                                </div>
                                <div class="w-full h-px mb-3 bg-gray-300"></div>
                                <div class="space-y-3 text-sm text-gray-700">
                                    <div class="p-3 border-l-4 border-slate-400 bg-slate-50/70">
                                        <p><strong>Analysis:</strong> Inspired by Ganesha, deity of wisdom. Elephant
                                            head with single tusk.</p>
                                    </div>
                                    <div class="p-3 border-l-4 border-gray-400 bg-gray-50/70">
                                        <p><strong>Symbolism:</strong> Diamond shape (Kaustav means legendary gem)
                                            symbolizes excellence, value, and strength.</p>
                                    </div>
                                    <div class="p-3 border-l-4 border-neutral-400 bg-neutral-50/70">
                                        <p><strong>Leadership:</strong> Crown signifies leadership and foresight.</p>
                                    </div>
                                    <div class="p-3 border-l-4 border-stone-400 bg-stone-50/70">
                                        <p><strong>Resilience:</strong> Single tusk represents overcoming challenges and
                                            perseverance.</p>
                                    </div>
                                </div>
                                <div class="mt-6">
                                    <button
                                        class="flex items-center px-4 py-2 text-xs font-bold text-white transition-all duration-300 bg-gray-700 border border-gray-800 rounded-lg hover:bg-gray-800 group">
                                        <span>DECODE SYMBOLS</span>
                                        <svg xmlns="http://www.w3.org/2000/svg"
                                            class="w-4 h-4 ml-2 transition-transform duration-300 group-hover:translate-x-1"
                                            fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
                                        </svg>
                                    </button>
                                </div>
                            </div>

                            <div
                                class="absolute px-3 py-1 font-mono text-xs font-bold tracking-wider text-gray-600 uppercase transform border border-gray-600 -bottom-2 -left-4 -rotate-12 opacity-70">
                                {{ getEvidenceType(5) }} #006
                            </div>
                            <div class="absolute bottom-0 right-0 w-8 h-8 bg-gray-200 opacity-60"
                                style="clip-path: polygon(100% 0, 0 100%, 100% 100%);"></div>
                        </div>
                    </div>
                </div>
            </div>

            <svg class="absolute inset-0 z-0 w-full h-full pointer-events-none" preserveAspectRatio="none">
                <line x1="48%" y1="45%" x2="52%" y2="55%" stroke="#dc2626" stroke-width="1" stroke-dasharray="2,2"
                    opacity="0.4" class="hidden lg:block" />
            </svg>
        </section>

        <section class="relative py-8">
            <div class="container px-6 mx-auto">
                <div class="relative max-w-4xl mx-auto group">
                    <div :class="`relative p-6 text-center transform bg-gradient-to-br ${getCardBg(6)} border-2 border-slate-300 shadow-2xl hover:shadow-2xl transition-all duration-300 rotate-1`"
                        style="clip-path: polygon(0 0, 100% 0, 100% 92%, 92% 100%, 0 100%);">
                        <div
                            :class="`absolute -top-3 -left-3 w-5 h-5 ${getPinColor(6)} rounded-full shadow-lg z-10 group-hover:scale-110 transition-transform duration-300`">
                            <div class="absolute bg-white rounded-full inset-1 opacity-40"></div>
                        </div>
                        <div
                            :class="`absolute -top-3 -right-3 w-5 h-5 ${getPinColor(7)} rounded-full shadow-lg z-10 group-hover:scale-110 transition-transform duration-300`">
                            <div class="absolute bg-white rounded-full inset-1 opacity-40"></div>
                        </div>
                        <div
                            :class="`absolute -bottom-3 -left-3 w-5 h-5 ${getPinColor(0)} rounded-full shadow-lg z-10 group-hover:scale-110 transition-transform duration-300`">
                            <div class="absolute bg-white rounded-full inset-1 opacity-40"></div>
                        </div>
                        <div
                            :class="`absolute -bottom-3 -right-3 w-5 h-5 ${getPinColor(1)} rounded-full shadow-lg z-10 group-hover:scale-110 transition-transform duration-300`">
                            <div class="absolute bg-white rounded-full inset-1 opacity-40"></div>
                        </div>

                        <h3 class="mb-2 text-3xl font-bold text-black uppercase">CASE STATUS: SOLVED</h3>
                        <div class="w-full h-px my-3 bg-gray-300"></div>
                        <p class="text-lg font-semibold text-gray-700">All evidence points to a successful organization
                            dedicated to excellence</p>

                        <div
                            class="absolute px-4 py-2 text-sm font-bold text-gray-700 uppercase transform border-2 border-gray-600 rounded-full shadow-md bg-gray-50/70 -bottom-6 -right-6 rotate-12">
                            VERIFIED
                        </div>
                        <div class="absolute bottom-0 right-0 w-8 h-8 bg-gray-200 opacity-60"
                            style="clip-path: polygon(100% 0, 0 100%, 100% 100%);"></div>
                    </div>
                </div>
            </div>
        </section>
    </div>
    <Footer />
</template>

<style scoped>
/* Dot background pattern */
.dot-background {
    background-image: radial-gradient(circle at 2px 2px, rgba(107, 114, 128, 0.15) 1px, transparent 0);
    background-size: 20px 20px;
    background-position: 0 0, 10px 10px;
    animation: dot-drift 20s linear infinite;
}

@keyframes dot-drift {
    0% {
        background-position: 0 0, 10px 10px;
    }

    100% {
        background-position: 20px 20px, 30px 30px;
    }
}

.dot-background::after {
    content: '';
    position: absolute;
    inset: 0;
    background-image: radial-gradient(circle at 1px 1px, rgba(71, 85, 105, 0.08) 1px, transparent 0);
    background-size: 40px 40px;
    background-position: 20px 20px;
    animation: dot-secondary 30s linear infinite reverse;
}

@keyframes dot-secondary {
    0% {
        background-position: 20px 20px;
        opacity: 0.3;
    }

    50% {
        opacity: 0.6;
    }

    100% {
        background-position: 60px 60px;
        opacity: 0.3;
    }
}

.clean-evidence-grid {
    background-image:
        linear-gradient(to right, rgba(156, 163, 175, 0.2) 1px, transparent 1px),
        linear-gradient(to bottom, rgba(156, 163, 175, 0.2) 1px, transparent 1px);
    background-size: 15px 15px;
    /* Slightly larger grid */
}

.case-title {
    font-family: 'Courier New', Courier, monospace;
    /* Kept for specific title styling */
    letter-spacing: 2px;
}

/* Subtle pin animation */
.group:hover .absolute.-top-2,
.group:hover .absolute.-top-3 {
    animation: pin-subtle 0.4s ease-in-out;
}

.group:hover .absolute.-bottom-3 {
    animation: pin-subtle-bottom 0.4s ease-in-out;
}


@keyframes pin-subtle {

    0%,
    100% {
        transform: translate(var(--tw-translate-x, 0), var(--tw-translate-y, 0)) rotate(0deg) scale(1);
    }

    50% {
        transform: translate(var(--tw-translate-x, 0), var(--tw-translate-y, 0)) rotate(-2deg) scale(1.08);
    }
}

@keyframes pin-subtle-bottom {

    0%,
    100% {
        transform: translate(var(--tw-translate-x, 0), var(--tw-translate-y, 0)) rotate(0deg) scale(1);
    }

    50% {
        transform: translate(var(--tw-translate-x, 0), var(--tw-translate-y, 0)) rotate(2deg) scale(1.08);
    }
}


.group:hover [class*="bg-gradient-to-br"] {
    filter: brightness(1.02);
}

@keyframes string-flow {

    0%,
    100% {
        stroke-dashoffset: 0;
    }

    50% {
        stroke-dashoffset: 8;
    }

}

svg line {
    animation: string-flow 3s linear infinite;
}

.group:hover .bg-gray-100 {
    background: linear-gradient(45deg, #f3f4f6, #e5e7eb, #f3f4f6);
    animation: tape-shine 1.5s ease-in-out infinite;
}

@keyframes tape-shine {

    0%,
    100% {
        opacity: 0.8;
    }

    50% {
        opacity: 0.95;
    }
}

.group:hover [class*="border-gray-600"] {
    border-color: #4b5563;
    color: #374151;
    animation: stamp-focus 0.8s ease-in-out forwards;
}

@keyframes stamp-focus {
    0% {
        opacity: 0.7;
        transform: scale(1) rotate(var(--tw-rotate));
    }

    50% {
        opacity: 0.9;
        transform: scale(1.03) rotate(var(--tw-rotate));
    }

    100% {
        opacity: 0.85;
        transform: scale(1) rotate(var(--tw-rotate));
    }
}


.relative.group:hover {
    z-index: 20;
}

.shadow-xl {
    box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.07), 0 4px 6px -2px rgba(0, 0, 0, 0.03);
}

.shadow-2xl {
    box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
}

.group:hover .shadow-xl {
    box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.12), 0 8px 10px -6px rgba(0, 0, 0, 0.08);
}

.group:hover .shadow-2xl {
    box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.18);
}


.overflow-hidden .group:hover>div {
}
</style>