<script setup lang="ts">
import { ref, computed, onMounted } from 'vue'; 
import Navbar from '../Navbar.vue';
import Footer from '../Footer.vue';

interface Aspiration {
    id: number;
    name: string;
    text: string;
    category: string;
    date: string;
    likes: number;
}

interface NewAspiration {
    name: string;
    text: string;
    category: string;
}

const formSectionRef = ref<HTMLElement | null>(null);
const showSuccess = ref<boolean>(false);
const displayLimit = ref<number>(6);
const isLoading = ref<boolean>(true); // Added for initial load effect

const newAspiration = ref<NewAspiration>({
    name: '',
    text: '',
    category: 'career'
});

const aspirations = ref<Aspiration[]>([
    {
        id: 1,
        name: "Nadia Aulia",
        text: "Saya ingin PUMA mengadakan lebih banyak event yang interaktif dan menyenangkan, seperti hackathon atau seminar dengan alumni sukses.",
        category: "event",
        date: "May 2025",
        likes: 34
    },
    {
        id: 2,
        name: "Rizky Darmawan",
        text: "Aspirasi saya adalah melihat website organisasi kita tampil lebih modern dan responsif. Mungkin kita bisa pakai Tailwind CSS atau redesign total tampilan dashboard-nya.",
        category: "technology",
        date: "May 2025",
        likes: 29
    },
    {
        id: 3,
        name: "Dewi Ananda",
        text: "Saya harap PUMA bisa lebih aktif dalam mendengarkan dan menyalurkan aspirasi mahasiswa ke pihak kampus, terutama soal fasilitas kelas dan WiFi.",
        category: "infrastructure",
        date: "May 2025",
        likes: 22
    },
    {
        id: 4,
        name: "Fajar Setiawan",
        text: "Aspirasi saya adalah ada lebih banyak kegiatan lintas jurusan agar mahasiswa bisa saling kenal dan kolaborasi antar program studi.",
        category: "campus_life",
        date: "May 2025",
        likes: 38
    },
    {
        id: 5,
        name: "Intan Nurhaliza",
        text: "Saya ingin melihat PUMA memiliki divisi kreatif yang lebih aktif memproduksi konten visual, desain feed IG, dan dokumentasi event dengan standar profesional.",
        category: "organization",
        date: "May 2025",
        likes: 25
    },
    {
        id: 6,
        name: "Andi Saputra",
        text: "Harapanku adalah sistem komunikasi internal PUMA lebih rapi, misalnya dengan pakai Notion atau platform khusus buat koordinasi tim.",
        category: "communication",
        date: "May 2025",
        likes: 17
    },
    {
        id: 7,
        name: "Melissa Prameswari",
        text: "Saya ingin lebih banyak pelatihan soft skill seperti public speaking atau kepemimpinan dalam program kerja PUMA.",
        category: "campus_life",
        date: "May 2025",
        likes: 21
    },
    {
        id: 8,
        name: "Yusuf Ibrahim",
        text: "Aspirasi saya adalah adanya dokumentasi dan publikasi rutin tentang progres dan laporan kerja PUMA agar lebih transparan.",
        category: "organization",
        date: "May 2025",
        likes: 30
    }
]);

const colors = [
    'from-gray-50 to-slate-100',
    'from-slate-50 to-gray-100',
    'from-zinc-50 to-slate-100',
    'from-neutral-50 to-gray-100',
    'from-stone-50 to-slate-100',
    'from-gray-100 to-slate-50',
    'from-slate-100 to-zinc-50',
    'from-gray-50 to-neutral-100',
    'from-zinc-100 to-slate-50'
];

const pinColors = ['bg-gray-700', 'bg-slate-700', 'bg-zinc-600', 'bg-neutral-700', 'bg-stone-600', 'bg-gray-600', 'bg-slate-600', 'bg-zinc-700', 'bg-neutral-600'];


const types = ['ORGANIZATION', 'CAMPUS_LIFE', 'TECHNOLOGY', 'EVENT', 'INFRASTRUCTURE', 'COMMUNICATION', 'OTHER'];

const categoryToEvidenceType = (category: string): string => {
    const upperCategory = category.toUpperCase();
    return types.includes(upperCategory) ? upperCategory : 'GENERAL';
}

const getColor = (index: number) => colors[index % colors.length];
const getPinColor = (index: number) => pinColors[index % pinColors.length];

const displayedAspirations = computed(() => {
    return aspirations.value.slice(0, displayLimit.value);
});

const submitAspiration = () => {
    if (newAspiration.value.name && newAspiration.value.text) {
        const aspirationToAdd: Aspiration = {
            id: Date.now(),
            name: newAspiration.value.name,
            text: newAspiration.value.text,
            category: newAspiration.value.category,
            date: new Date().toLocaleDateString('en-US', { month: 'long', year: 'numeric' }), // Current date
            likes: 0
        };
        aspirations.value.unshift(aspirationToAdd);
        newAspiration.value = { name: '', text: '', category: 'career' };
        showSuccess.value = true;
        setTimeout(() => {
            showSuccess.value = false;
        }, 3000);
    }
};

const loadMore = () => {
    displayLimit.value += 3;
};

onMounted(() => {
    setTimeout(() => {
        isLoading.value = false
    }, 300);
});

</script>

<template>
    <Navbar />
    <div class="relative min-h-screen pt-20 bg-gradient-to-br from-white via-gray-50 to-slate-50">
        <div class="absolute inset-0 dot-background"></div>
        <div class="absolute inset-0 opacity-10"
            style="background-image: radial-gradient(circle at 1px 1px, rgba(100,116,139,0.15) 1px, transparent 0); background-size: 32px 32px;">
        </div>

        <section class="relative z-10 py-16">
            <div class="container px-4 mx-auto max-w-7xl">
                <header class="relative mb-20 text-center">
                    <div class="relative inline-block">
                        <div class="absolute w-3 h-3 bg-gray-700 rounded-full shadow-lg -top-4 -left-4"></div>
                        <div class="absolute w-3 h-3 rounded-full shadow-lg -top-4 -right-4 bg-slate-700"></div>
                        <h1
                            class="mb-4 font-mono text-5xl font-bold tracking-wider text-black uppercase transform sm:text-6xl -rotate-1">
                            Aspiration <span
                                class="text-transparent bg-gradient-to-r from-gray-700 to-black bg-clip-text">Board</span>
                        </h1>
                    </div>
                    <p
                        class="max-w-2xl mx-auto font-mono text-xl leading-8 tracking-wide text-gray-600 uppercase transform rotate-1">
                        Share your dreams, inspire others
                    </p>
                    <svg class="absolute w-px h-8 mt-2 transform -translate-x-1/2 top-full left-1/2" viewBox="0 0 1 32">
                        <line x1="0.5" y1="0" x2="0.5" y2="32" stroke="#9ca3af" stroke-width="1"
                            stroke-dasharray="2,2" />
                    </svg>
                </header>

                <div v-if="isLoading" class="flex items-center justify-center py-32">
                    <div class="relative">
                        <div class="w-16 h-16 border-4 border-gray-200 rounded-full"></div>
                        <div
                            class="absolute top-0 left-0 w-16 h-16 border-4 border-black rounded-full animate-spin border-t-transparent">
                        </div>
                    </div>
                </div>

                <div v-else class="relative space-y-12">
                    <svg class="absolute inset-0 z-0 w-full h-full pointer-events-none" preserveAspectRatio="none">
                        <line x1="15%" y1="10%" x2="50%" y2="30%" stroke="#d1d5db" stroke-width="0.5"
                            stroke-dasharray="3,3" opacity="0.5" />
                        <line x1="60%" y1="20%" x2="85%" y2="40%" stroke="#9ca3af" stroke-width="0.5"
                            stroke-dasharray="3,3" opacity="0.5" />
                        <line x1="20%" y1="60%" x2="80%" y2="80%" stroke="#d1d5db" stroke-width="0.5"
                            stroke-dasharray="3,3" opacity="0.5" />
                        <line x1="10%" y1="75%" x2="35%" y2="95%" stroke="#9ca3af" stroke-width="0.5"
                            stroke-dasharray="3,3" opacity="0.5" />
                        <line x1="65%" y1="85%" x2="95%" y2="65%" stroke="#d1d5db" stroke-width="0.5"
                            stroke-dasharray="3,3" opacity="0.5" />
                    </svg>

                    <div class="relative z-10 grid grid-cols-1 gap-8 md:grid-cols-2 lg:grid-cols-3">
                        <div v-for="(aspiration, index) in displayedAspirations" :key="aspiration.id" :class="[
                            'group cursor-default transform transition-all duration-500 hover:scale-[1.02]',
                            // Dynamic rotation/translation for visual interest, can be adjusted
                            index % 3 === 0 ? 'rotate-[0.5deg]' : '',
                            index % 3 === 1 ? '-rotate-[0.5deg] md:translate-y-2' : '',
                            index % 3 === 2 ? 'rotate-[0.25deg]' : ''
                        ]" :style="{ animationDelay: index * 0.05 + 's' }" class="fade-in-up">

                            <div class="relative">
                                <div
                                    :class="`absolute -top-2 left-1/2 transform -translate-x-1/2 w-4 h-4 ${getPinColor(index)} rounded-full shadow-lg z-20 group-hover:scale-110 transition-transform duration-300`">
                                    <div class="absolute bg-white rounded-full inset-1 opacity-40"></div>
                                </div>

                                <div :class="`relative bg-gradient-to-br ${getColor(index)} border border-gray-200 shadow-lg hover:shadow-xl transition-all duration-300 group-hover:border-gray-400 group-hover:shadow-2xl`"
                                    style="clip-path: polygon(0 0, 100% 0, 100% 92%, 92% 100%, 0 100%);">

                                    <div
                                        class="absolute w-8 h-4 transition-opacity transform rotate-45 bg-gray-100 border border-gray-200 shadow-sm top-2 right-2 opacity-60 group-hover:opacity-80">
                                    </div>
                                    <div
                                        class="absolute w-6 h-3 transition-opacity transform bg-gray-100 border border-gray-200 shadow-sm opacity-50 bottom-10 left-2 group-hover:opacity-70 -rotate-12">
                                    </div>

                                    <div class="p-6 pt-8">
                                        <div
                                            class="absolute px-2 py-0.5 font-mono text-[0.6rem] font-bold tracking-wider text-gray-500 uppercase transform border border-gray-400 top-2 left-2 -rotate-12 opacity-70 group-hover:opacity-90">
                                            {{ categoryToEvidenceType(aspiration.category) }}
                                        </div>

                                        <div class="mb-3">
                                            <span class="font-mono text-xs text-gray-500 uppercase">Filed by: </span>
                                            <h3
                                                class="inline font-semibold text-gray-800 font-mono-space text-md group-hover:text-black">
                                                {{ aspiration.name }}</h3>
                                        </div>

                                        <p class="mb-4 text-sm leading-relaxed text-gray-700 min-h-[60px]">{{
                                            aspiration.text }}</p>

                                        <div class="w-full h-px mt-3 mb-3 bg-gray-300/70"></div>

                                        <div
                                            class="flex items-center justify-between text-xs text-gray-500 font-mono-space">
                                            <span>{{ aspiration.date }}</span>
                                            <div class="flex items-center">
                                                <span class="font-mono tracking-wider">LIKES: {{ aspiration.likes || 0
                                                }}</span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="absolute bottom-0 right-0 w-6 h-6 bg-gray-200/80 opacity-60 group-hover:opacity-80"
                                        style="clip-path: polygon(100% 0, 0 100%, 100% 100%);"></div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="mt-16 text-center" v-if="aspirations.length > displayLimit">
                        <button @click="loadMore"
                            class="px-8 py-3 font-mono text-sm tracking-wider text-white uppercase transition-all duration-300 bg-gray-800 rounded-sm shadow-md hover:bg-gray-700 hover:shadow-lg focus:outline-none focus:ring-2 focus:ring-gray-500 focus:ring-opacity-50">
                            Load More Entries
                        </button>
                    </div>
                </div>
            </div>
        </section>

        <section ref="formSectionRef"
            class="relative z-10 py-16 border-t border-gray-200 bg-gradient-to-br from-slate-50 via-gray-100 to-slate-100">
            <div class="container max-w-2xl px-4 mx-auto">
                <header class="relative mb-12 text-center">
                    <div class="relative inline-block">
                        <div class="absolute w-2.5 h-2.5 bg-gray-600 rounded-full shadow -top-3 -left-3"></div>
                        <div class="absolute w-2.5 h-2.5 rounded-full shadow -top-3 -right-3 bg-slate-600"></div>
                        <h2
                            class="font-mono text-4xl font-bold tracking-wider text-black uppercase transform sm:text-5xl -rotate-1">
                            Submit <span
                                class="text-transparent bg-gradient-to-r from-gray-700 to-black bg-clip-text">Entry</span>
                        </h2>
                    </div>
                    <p
                        class="max-w-md mx-auto mt-4 font-mono text-lg leading-7 tracking-wide text-gray-500 uppercase transform rotate-1">
                        Share your own aspiration
                    </p>
                </header>

                <div class="relative p-8 bg-white border border-gray-200 rounded-sm shadow-xl paper-form-look">
                    <div
                        class="absolute w-4 h-4 transform -translate-x-1/2 bg-gray-700 rounded-full shadow-lg -top-2 left-1/2">
                        <div class="absolute bg-white rounded-full inset-1 opacity-40"></div>
                    </div>

                    <form @submit.prevent="submitAspiration" class="space-y-6">
                        <div>
                            <label
                                class="block mb-1.5 font-mono text-xs font-medium tracking-wider text-gray-600 uppercase">Your
                                Name</label>
                            <input v-model="newAspiration.name" type="text"
                                class="w-full px-4 py-2.5 font-mono text-sm text-gray-800 bg-gray-50 border border-gray-300 rounded-sm focus:ring-1 focus:ring-gray-500 focus:border-gray-500 transition-all duration-200"
                                placeholder="e.g., Jamal" required />
                        </div>

                        <div>
                            <label
                                class="block mb-1.5 font-mono text-xs font-medium tracking-wider text-gray-600 uppercase">Your
                                Aspiration</label>
                            <textarea v-model="newAspiration.text" rows="5"
                                class="w-full px-4 py-2.5 font-mono text-sm text-gray-800 bg-gray-50 border border-gray-300 rounded-sm resize-none focus:ring-1 focus:ring-gray-500 focus:border-gray-500 transition-all duration-200"
                                placeholder="Detail your objective..." required></textarea>
                        </div>

                        <div>
                            <label
                                class="block mb-1.5 font-mono text-xs font-medium tracking-wider text-gray-600 uppercase">Category
                            </label>
                            <select v-model="newAspiration.category"
                                class="w-full px-4 py-2.5 font-mono text-sm text-gray-800 bg-gray-50 border border-gray-300 rounded-sm appearance-none focus:ring-1 focus:ring-gray-500 focus:border-gray-500 transition-all duration-200 custom-select">
                                <option value="career">Career</option>
                                <option value="education">Education</option>
                                <option value="personal">Personal Growth</option>
                                <option value="travel">Travel</option>
                                <option value="health">Health & Fitness</option>
                                <option value="creative">Creative</option>
                                <option value="other">Other</option>
                            </select>
                        </div>

                        <button type="submit"
                            class="w-full py-3 font-mono text-sm font-semibold tracking-wider text-white uppercase bg-gray-800 rounded-sm shadow-md hover:bg-gray-700 hover:shadow-lg transition-all duration-300 transform hover:scale-[1.01] focus:outline-none focus:ring-2 focus:ring-gray-500 focus:ring-opacity-50">
                            Submit Aspiration
                        </button>
                    </form>
                </div>
            </div>
        </section>

        <div v-if="showSuccess"
            class="fixed z-50 px-6 py-4 text-sm text-white bg-green-600 rounded-sm shadow-lg top-5 right-5 slide-in-right font-mono-space">
            <div class="flex items-center">
                <svg class="w-5 h-5 mr-2" fill="currentColor" viewBox="0 0 20 20">
                    <path fill-rule="evenodd"
                        d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z"
                        clip-rule="evenodd"></path>
                </svg>
                Aspiration Filed Successfully!
            </div>
        </div>
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

@keyframes fadeInUp {
    from {
        opacity: 0;
        transform: translateY(20px);
    }

    to {
        opacity: 1;
        transform: translateY(0);
    }
}

.fade-in-up {
    animation: fadeInUp 0.5s ease-out forwards;
}

@keyframes slideInRight {

    from {
        opacity: 0;
        transform: translateX(30px);
    }

    to {
        opacity: 1;
        transform: translateX(0);
    }
}

.slide-in-right {
    animation: slideInRight 0.5s ease-out forwards;
}


.group:hover .relative.bg-gradient-to-br {
    transform: translateY(-3px) scale(1.01);
    box-shadow: 0 15px 25px -10px rgba(0, 0, 0, 0.1), 0 8px 10px -6px rgba(0, 0, 0, 0.1);
}

.group:hover .absolute.-top-2 {
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

.font-mono-space {
    font-family: 'ui-monospace', 'SFMono-Regular', 'Menlo', 'Monaco', 'Consolas', "Liberation Mono", "Courier New", monospace;
}

.custom-select {
    background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' fill='none' viewBox='0 0 20 20'%3e%3cpath stroke='%236b7280' stroke-linecap='round' stroke-linejoin='round' stroke-width='1.5' d='M6 8l4 4 4-4'/%3e%3c/svg%3e");
    background-position: right 0.5rem center;
    background-repeat: no-repeat;
    background-size: 1.5em 1.5em;
    padding-right: 2.5rem;
}

.paper-form-look {
    position: relative;
}

.paper-form-look::before {
    content: "";
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background-image: url('data:image/svg+xml;charset=UTF-8,<svg xmlns="http://www.w3.org/2000/svg" width="100" height="100" viewBox="0 0 100 100"><filter id="n" x="0" y="0"><feTurbulence type="fractalNoise" baseFrequency=".7" numOctaves="10" stitchTiles="stitch"/></filter><rect width="100" height="100" filter="url(%23n)" opacity="0.03"/></svg>');
    opacity: 0.2;
    pointer-events: none;
    border-radius: inherit;
}


svg line {
    animation: string-flow 6s ease-in-out infinite alternate;
}

@keyframes string-flow {
    0% {
        stroke-dashoffset: 0;
        opacity: 0.3;
    }

    50% {
        stroke-dashoffset: 20;
        opacity: 0.6;
    }

    100% {
        stroke-dashoffset: 0;
        opacity: 0.3;
    }
}
</style>