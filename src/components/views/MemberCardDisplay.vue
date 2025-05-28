<template>
    <div :class="[
        'group cursor-pointer transform transition-all duration-300 hover:scale-[1.02] hover:z-10', // Slightly reduced hover scale
        cardSpecificClass
    ]" @click="openModalFn(member)">
        <div class="relative">
            <div
                :class="`absolute -top-1.5 left-1/2 transform -translate-x-1/2 w-3.5 h-3.5 ${getPinColor(index)} rounded-full shadow-lg z-20 border-2 border-white/50 group-hover:scale-110 transition-transform duration-300`">
                <div class="absolute bg-white/30 rounded-full inset-0.5"></div>
            </div>
            <div :class="`relative bg-gradient-to-br ${getCardBgColor(index)} border border-gray-300/70 shadow-lg hover:shadow-xl transition-all duration-300 group-hover:border-gray-400 flex flex-col items-center text-center`"
                style="clip-path: polygon(0 0, 100% 0, 100% calc(100% - 12px), calc(100% - 12px) 100%, 0 100%); padding: 20px 16px 16px;">
                <div
                    class="absolute w-10 h-4 transform -rotate-[30deg] bg-gray-100/60 border border-gray-200/50 shadow-sm -top-1 -left-1 opacity-70 group-hover:opacity-90 transition-opacity">
                </div>
                <div class="relative mb-3">
                    <div class="relative overflow-hidden border-2 rounded-md shadow-sm border-gray-300/50">
                        <img :src="member.avatar || 'https://via.placeholder.com/128/d1d5db/4b5563?text=ID'"
                            :alt="member.name"
                            class="object-cover transition-all duration-500 w-60 h-80 group-hover:scale-105"
                            loading="lazy" />
                    </div>
                    <div
                        :class="['absolute w-6 h-6 border-2 border-white rounded-full shadow -bottom-2 -right-2', getStatusDot(member.status)]">
                    </div>
                </div>
                <h3
                    class="mb-0.5 text-base font-bold text-gray-800 transition-colors group-hover:text-black font-mono uppercase leading-tight">
                    {{ member.name }}
                </h3>
                <p class="mb-2 font-mono text-xs font-semibold text-gray-500 uppercase group-hover:text-gray-700">
                    {{ member.position }}
                </p>
                <div class="mt-auto">
                    <span
                        :class="['px-2.5 py-1 text-[11px] leading-none border rounded-sm', getStatusColor(member.status)]">
                        {{ member.status }}
                    </span>
                </div>
                <div class="absolute bottom-0 right-0 w-3 h-3 bg-gray-300/50 opacity-80"
                    style="clip-path: polygon(100% 0, 0 100%, 100% 100%);"></div>
            </div>
        </div>
    </div>
</template>

<script setup lang="ts">
import { computed } from 'vue';

interface Member {
    id: number;
    status: string;
    name: string;
    email: string;
    position: string;
    cabinet: string;
    batch: string;
    division: string;
    avatar: string;
    instagram: string;
    linkedin: string;
    personalDescription: string;
}

const props = defineProps<{
    member: Member;
    index: number;
    openModalFn: (member: Member) => void;
}>();

// Helper functions for styling
const getStatusColor = (status: string) => {
    switch (status.toLowerCase()) {
        case 'active': return 'bg-green-100 text-green-800 border-green-300 font-mono';
        case 'inactive': return 'bg-gray-200 text-gray-700 border-gray-400 font-mono';
        case 'alumni': return 'bg-slate-100 text-slate-700 border-slate-300 font-mono';
        default: return 'bg-gray-200 text-gray-700 border-gray-400 font-mono';
    }
};
const getStatusDot = (status: string) => {
    switch (status.toLowerCase()) {
        case 'active': return 'bg-green-500';
        case 'inactive': return 'bg-gray-400';
        case 'alumni': return 'bg-slate-500';
        default: return 'bg-gray-400';
    }
};
const cardBgColors = ['from-gray-50 to-slate-100', 'from-slate-50 to-gray-100', 'from-zinc-50 to-slate-100', 'from-neutral-50 to-gray-100', 'from-stone-50 to-slate-100'];
const getCardBgColor = (idx: number) => cardBgColors[idx % cardBgColors.length];
const pinColors = ['bg-gray-700', 'bg-slate-700', 'bg-zinc-600', 'bg-neutral-700', 'bg-stone-600'];
const getPinColor = (idx: number) => pinColors[idx % pinColors.length];

const cardSpecificClass = computed(() => {
    const classMap: { [key: number]: string } = {
        0: 'rotate-[0.5deg]',
        1: '-rotate-[0.5deg] md:translate-y-1',
        2: 'rotate-[0.8deg]',
        3: '-rotate-[0.3deg] md:-translate-y-0.5'
    };
    return classMap[props.index % 4] || '';
});

</script>

<style scoped>
</style>