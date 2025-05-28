<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import Navbar from '../Navbar.vue' 
import Footer from '../Footer.vue'   

interface Division {
    name: string
    title: string
    image: string
    description: string
}

const router = useRouter()
const isLoading = ref<boolean>(true)

const divisions: Division[] = [
    {
        name: 'ICM',
        title: 'Information and Creative Media',
        image: '/PUMA-Website/division/icm.JPG',
        description: 'Digital communication and creative content'
    },
    {
        name: 'RNT',
        title: 'Research and Technology',
        image: 'https://i.pinimg.com/736x/f2/96/65/f296659f98543ad0ee11738a62e7652f.jpg',
        description: 'Innovation and technological advancement'
    },
    {
        name: 'HRD',
        title: 'Human Resources Development',
        image: '/PUMA-Website/division/hrd.JPG',
        description: 'Talent development and organizational growth'
    },
    {
        name: 'BOD',
        title: 'Board of Directors',
        image: '/PUMA-Website/division/bod.JPG',
        description: 'Strategic leadership and organizational governance'
    },
    {
        name: 'IR',
        title: 'Internal Relations',
        image: '/PUMA-Website/division/internal.JPG',
        description: 'Building strong internal connections'
    },
    {
        name: 'ER',
        title: 'External Relations',
        image: '/PUMA-Website/division/EXT.JPG',
        description: 'External partnerships and networking'
    },
    {
        name: 'SAC',
        title: 'Student Academic & Competition',
        image: '/PUMA-Website/division/sac.JPG',
        description: 'Academic excellence and competitive achievements'
    },
    {
        name: 'SPT',
        title: 'Student Passions & Talents',
        image: '/PUMA-Website/division/spt.JPG',
        description: 'Nurturing creativity and individual talents'
    },
    {
        name: 'TECHNOPRENEUR',
        title: 'Technopreneur',
        image: '/PUMA-Website/division/Technoprenet.JPG',
        description: 'Entrepreneurship in technology and innovation'
    }
]

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
]

const pinColors = ['bg-gray-700', 'bg-slate-700', 'bg-zinc-600', 'bg-neutral-700', 'bg-stone-600', 'bg-gray-600', 'bg-slate-600', 'bg-zinc-700', 'bg-neutral-600']
const evidenceTypes = ['CASE', 'FILE', 'DATA', 'INFO', 'LEAD', 'DOCS', 'INTEL', 'PROOF', 'UNIT']

const getColor = (index: number) => colors[index % colors.length]
const getPinColor = (index: number) => pinColors[index % pinColors.length]
const getEvidenceType = (index: number) => evidenceTypes[index % evidenceTypes.length]

const goToDivisionMembers = (divisionName: string) => {
    router.push(`/division/${divisionName}`)
}

onMounted(() => {
    setTimeout(() => {
        isLoading.value = false
    }, 300);
})
</script>

<template>
    <Navbar />
    <div class="relative min-h-screen pt-20 bg-gradient-to-br from-white via-gray-50 to-slate-50">
        <div class="absolute inset-0 dot-background"></div>
        
        <div class="absolute inset-0 opacity-10" 
             style="background-image: radial-gradient(circle at 1px 1px, rgba(100,116,139,0.15) 1px, transparent 0); background-size: 32px 32px;"></div>
        
        <section class="relative z-10 py-16">
            <div class="container px-4 mx-auto max-w-7xl">
                <header class="relative mb-16 text-center">
                    <div class="relative inline-block">
                        <div class="absolute w-3 h-3 bg-gray-700 rounded-full shadow-lg -top-4 -left-4"></div>
                        <div class="absolute w-3 h-3 rounded-full shadow-lg -top-4 -right-4 bg-slate-700"></div>
                        <h1 class="mb-4 font-mono text-5xl font-bold tracking-wider text-black uppercase transform sm:text-6xl -rotate-1">
                            Division <span class="text-transparent bg-gradient-to-r from-gray-700 to-black bg-clip-text">Files</span>
                        </h1>
                    </div>
                    <p class="max-w-2xl mx-auto font-mono text-xl leading-8 tracking-wide text-gray-600 uppercase transform rotate-1">
                        Organizational units and specialized divisions
                    </p>
                    
                    <svg class="absolute w-px h-8 mt-2 transform -translate-x-1/2 top-full left-1/2" viewBox="0 0 1 32">
                        <line x1="0.5" y1="0" x2="0.5" y2="32" stroke="#dc2626" stroke-width="1" stroke-dasharray="2,2"/>
                    </svg>
                </header>

                <div v-if="isLoading" class="flex items-center justify-center py-32">
                    <div class="relative">
                        <div class="w-16 h-16 border-4 border-gray-200 rounded-full"></div>
                        <div class="absolute top-0 left-0 w-16 h-16 border-4 border-black rounded-full animate-spin border-t-transparent"></div>
                    </div>
                </div>

                <div v-else class="relative space-y-12">
                    <svg class="absolute inset-0 z-0 w-full h-full pointer-events-none" preserveAspectRatio="none">
                        <line x1="20%" y1="15%" x2="45%" y2="35%" stroke="#dc2626" stroke-width="1" stroke-dasharray="4,4" opacity="0.4"/>
                        <line x1="55%" y1="25%" x2="80%" y2="45%" stroke="#b91c1c" stroke-width="1" stroke-dasharray="4,4" opacity="0.4"/>
                        <line x1="25%" y1="55%" x2="75%" y2="75%" stroke="#ef4444" stroke-width="1" stroke-dasharray="4,4" opacity="0.4"/>
                        <line x1="10%" y1="70%" x2="40%" y2="90%" stroke="#dc2626" stroke-width="1" stroke-dasharray="4,4" opacity="0.4"/>
                        <line x1="60%" y1="80%" x2="90%" y2="60%" stroke="#b91c1c" stroke-width="1" stroke-dasharray="4,4" opacity="0.4"/>
                    </svg>

                    <div class="relative z-10 grid grid-cols-1 gap-8 md:grid-cols-3">
                        <div v-for="(division, index) in divisions.slice(0, 3)" :key="division.name"
                            @click="goToDivisionMembers(division.name)"
                            :class="[
                                'group cursor-pointer transform transition-all duration-500 hover:scale-105',
                                index === 0 ? 'rotate-1' : '',
                                index === 1 ? '-rotate-1 md:translate-y-6' : '',
                                index === 2 ? 'rotate-2' : ''
                            ]">
                            
                            <div class="relative">
                                <div :class="`absolute -top-2 left-1/2 transform -translate-x-1/2 w-4 h-4 ${getPinColor(index)} rounded-full shadow-lg z-20 group-hover:scale-110 transition-transform duration-300`">
                                    <div class="absolute bg-white rounded-full inset-1 opacity-40"></div>
                                </div>
                                
                                <div :class="`relative bg-gradient-to-br ${getColor(index)} border border-gray-200 shadow-lg hover:shadow-xl transition-all duration-300 group-hover:border-gray-400 group-hover:shadow-2xl`"
                                    style="clip-path: polygon(0 0, 100% 0, 100% 88%, 88% 100%, 0 100%);">
                                    
                                    <div class="absolute w-8 h-4 transform rotate-45 bg-gray-100 border border-gray-200 shadow-sm top-2 right-2 opacity-80"></div>
                                    <div class="absolute w-6 h-3 transform bg-gray-100 border border-gray-200 shadow-sm bottom-8 left-2 opacity-80 -rotate-12"></div>
                                    
                                    <div class="p-6 pt-8">
                                        <div class="absolute px-2 py-1 font-mono text-xs font-bold tracking-wider text-gray-600 uppercase transform border border-gray-600 top-2 left-2 -rotate-12 opacity-70">
                                            {{ getEvidenceType(index) }}
                                        </div>
                                        
                                        <h3 class="mb-2 font-mono text-sm font-bold tracking-widest text-gray-500 uppercase">
                                            UNIT #{{ String(index + 1).padStart(2, '0') }}
                                        </h3>
                                        <h4 class="mb-3 font-mono text-xl font-bold text-black uppercase transition-colors duration-300 group-hover:text-gray-700">
                                            {{ division.title }}
                                        </h4>
                                        <div class="w-full h-px mb-3 bg-gray-300"></div>
                                        <p class="mb-4 font-mono text-sm leading-relaxed text-gray-600">
                                            {{ division.description }}
                                        </p>
                                        
                                        <div class="flex items-center justify-between pt-2 border-t border-gray-200">
                                            <span class="font-mono text-xs font-bold tracking-wide text-gray-700 uppercase">
                                                {{ division.name }}
                                            </span>
                                            <div class="flex items-center space-x-2">
                                                <div class="w-2 h-2 bg-green-500 rounded-full"></div>
                                                <span class="font-mono text-xs text-gray-500 uppercase">Active</span>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="absolute bottom-0 right-0 w-6 h-6 bg-gray-200 opacity-60" 
                                        style="clip-path: polygon(100% 0, 0 100%, 100% 100%);"></div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="relative z-10 grid grid-cols-1 gap-12 md:grid-cols-2">
                        <div v-for="(division, index) in divisions.slice(3, 5)" :key="division.name"
                            @click="goToDivisionMembers(division.name)"
                            :class="[
                                'group cursor-pointer transform transition-all duration-500 hover:scale-105',
                                index === 0 ? '-rotate-1' : 'rotate-1',
                                index === 1 ? 'md:-translate-y-4' : 'md:translate-y-6'
                            ]">
                            
                            <div class="relative">
                                <div :class="`absolute -top-2 left-1/4 w-4 h-4 ${getPinColor(index + 3)} rounded-full shadow-lg z-20 group-hover:scale-110 transition-transform duration-300`">
                                    <div class="absolute bg-white rounded-full inset-1 opacity-40"></div>
                                </div>
                                <div :class="`absolute -top-2 right-1/4 w-4 h-4 ${getPinColor(index + 4)} rounded-full shadow-lg z-20 group-hover:scale-110 transition-transform duration-300`">
                                    <div class="absolute bg-white rounded-full inset-1 opacity-40"></div>
                                </div>
                                
                                <div :class="`relative bg-gradient-to-br ${getColor(index + 3)} border border-gray-200 shadow-lg hover:shadow-2xl transition-all duration-300 group-hover:border-gray-400`"
                                    style="clip-path: polygon(0 0, 100% 0, 100% 92%, 92% 100%, 0 100%);">
                                    
                                    <div class="absolute w-10 h-5 transform bg-gray-100 border border-gray-200 shadow-sm top-4 right-4 opacity-80 rotate-25"></div>
                                    <div class="absolute w-8 h-4 transform bg-gray-100 border border-gray-200 shadow-sm top-4 left-4 opacity-80 -rotate-15"></div>
                                    <div class="absolute w-6 h-3 transform rotate-45 bg-gray-100 border border-gray-200 shadow-sm bottom-12 right-8 opacity-80"></div>
                                    
                                    <div class="p-8 pt-10">
                                        <div class="absolute px-3 py-1 font-mono text-sm font-bold tracking-wider text-gray-600 uppercase transform -translate-x-1/2 border border-gray-600 top-3 left-1/2 opacity-70">
                                            Evidence
                                        </div>
                                        
                                        <h3 class="mb-2 font-mono text-lg font-bold tracking-widest text-gray-500 uppercase">
                                            DEPT #{{ String(index + 4).padStart(2, '0') }}
                                        </h3>
                                        <h4 class="mb-4 font-mono text-2xl font-bold text-black uppercase transition-colors duration-300 group-hover:text-gray-700">
                                            {{ division.title }}
                                        </h4>
                                        <div class="w-full h-px mb-4 bg-gray-300"></div>
                                        <p class="mb-6 font-mono leading-relaxed text-gray-600">
                                            {{ division.description }}
                                        </p>
                                        
                                        <div class="flex flex-wrap gap-2 mb-4">
                                            <span class="px-2 py-1 font-mono text-xs text-gray-700 uppercase bg-gray-100 border border-gray-300 rounded">files</span>
                                            <span class="px-2 py-1 font-mono text-xs uppercase border rounded bg-slate-100 text-slate-700 border-slate-300">Target</span>
                                        </div>
                                        
                                        <div class="flex items-center justify-between pt-3 border-t border-gray-200">
                                            <span class="font-mono text-sm font-bold tracking-wide text-gray-700 uppercase">
                                                {{ division.name }}
                                            </span>
                                            <div class="flex items-center space-x-3">
                                                <div class="flex space-x-1">
                                                    <div class="w-2 h-2 bg-green-500 rounded-full"></div>
                                                </div>
                                                <span class="font-mono text-xs text-gray-500 uppercase">Active</span>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="absolute bottom-0 right-0 w-8 h-8 bg-gray-200 opacity-60" 
                                        style="clip-path: polygon(100% 0, 0 100%, 100% 100%);"></div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="relative z-10 grid grid-cols-1 gap-6 sm:grid-cols-2 lg:grid-cols-4">
                        <div v-for="(division, index) in divisions.slice(5)" :key="division.name"
                            @click="goToDivisionMembers(division.name)"
                            :class="[
                                'group cursor-pointer transform transition-all duration-500 hover:scale-105',
                                index % 2 === 0 ? 'rotate-1' : '-rotate-1',
                                index === 1 ? 'lg:translate-y-4' : '',
                                index === 2 ? 'lg:-translate-y-2' : '',
                                index === 3 ? 'lg:translate-y-3' : ''
                            ]">
                            
                            <div class="relative">
                                <div :class="`absolute -top-2 left-1/2 transform -translate-x-1/2 w-3 h-3 ${getPinColor(index + 5)} rounded-full shadow-lg z-20 group-hover:scale-110 transition-transform duration-300`">
                                    <div class="absolute inset-0.5 bg-white rounded-full opacity-50"></div>
                                </div>
                                
                                <div :class="`relative bg-gradient-to-br ${getColor(index + 5)} border border-gray-200 shadow-md hover:shadow-lg transition-all duration-300 group-hover:border-gray-400`"
                                    style="clip-path: polygon(0 0, 100% 0, 100% 90%, 90% 100%, 0 100%);">
                                    
                                    <div class="absolute w-6 h-3 transform bg-gray-100 border border-gray-200 shadow-sm top-2 right-2 opacity-80 rotate-30"></div>
                                    
                                    <div class="p-5 pt-6">
                                        <div class="absolute top-1 left-1 px-1 py-0.5 border border-gray-600 text-gray-600 font-mono text-xs font-bold tracking-wider uppercase transform -rotate-15 opacity-60">
                                            {{ getEvidenceType(index + 5).slice(0, 4) }}
                                        </div>
                                        
                                        <h3 class="mb-1 font-mono text-xs font-bold tracking-widest text-gray-500 uppercase">
                                            #{{ String(index + 6).padStart(2, '0') }}
                                        </h3>
                                        <h4 class="mb-2 font-mono text-lg font-bold text-black uppercase transition-colors duration-300 group-hover:text-gray-700">
                                            {{ division.title }}
                                        </h4>
                                        <div class="w-full h-px mb-2 bg-gray-300"></div>
                                        <p class="mb-3 font-mono text-sm leading-relaxed text-gray-600">
                                            {{ division.description }}
                                        </p>
                                        
                                        <div class="flex items-center justify-between pt-2 border-t border-gray-200">
                                            <span class="font-mono text-xs font-bold tracking-wide text-gray-700 uppercase">
                                                {{ division.name }}
                                            </span>
                                            <div class="flex items-center space-x-1">
                                                <div class="w-2 h-2 bg-green-500 rounded-full"></div>
                                                <span class="font-mono text-xs text-gray-500">Active</span>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="absolute bottom-0 right-0 w-4 h-4 bg-gray-200 opacity-60" 
                                        style="clip-path: polygon(100% 0, 0 100%, 100% 100%);"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </div>
    <Footer />
</template>

<style scoped>
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

@keyframes clean-texture {
    0%, 100% { 
        background-position: 0% 50%; 
    }
    50% { 
        background-position: 100% 50%; 
    }
}

.group:hover .absolute.-top-2 {
    animation: pin-subtle 0.4s ease-in-out;
}

@keyframes pin-subtle {
    0%, 100% { transform: translateX(-50%) rotate(0deg); }
    50% { transform: translateX(-50%) rotate(-1deg) scale(1.05); }
}

.group:hover [class*="bg-gradient-to-br"] {
    filter: brightness(1.02);
}

@keyframes string-flow {
    0%, 100% { stroke-dasharray: 4,4; }
    50% { stroke-dasharray: 6,2; }
}

svg line {
    animation: string-flow 4s ease-in-out infinite;
}

.group:hover .bg-gray-100 {
    background: linear-gradient(45deg, #f3f4f6, #e5e7eb, #f3f4f6);
    animation: tape-shine 1.5s ease-in-out infinite;
}

@keyframes tape-shine {
    0%, 100% { opacity: 0.8; }
    50% { opacity: 0.95; }
}

.group:hover [class*="border-gray-600"] {
    border-color: #4b5563;
    color: #374151;
    animation: stamp-focus 1s ease-in-out infinite;
}

@keyframes stamp-focus {
    0%, 100% { opacity: 0.7; }
    50% { opacity: 0.9; }
}

.bg-green-500, .bg-blue-500, .bg-gray-500 {
    animation: status-breathe 2s ease-in-out infinite;
}

@keyframes status-breathe {
    0%, 100% { opacity: 1; transform: scale(1); }
    50% { opacity: 0.8; transform: scale(1.05); }
}

.group:hover {
    z-index: 10;
}

.shadow-2xl {
    box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.15);
}

.group:hover ~ .dot-background {
    animation-duration: 15s;
}

.relative.z-10 {
    backdrop-filter: blur(0.5px);
}
</style>