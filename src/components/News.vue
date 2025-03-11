<script setup lang="ts">
import { ref } from 'vue';

interface NewsItem {
    id: number;
    category: string;
    date: string;
    title: string;
    description: string;
    content?: string;
}
const newsItems: NewsItem[] = [
    {
        id: 1,
        category: 'lorem',
        date: 'Lorem 15, 2024',
        title: 'Lorem Ipsum',
        description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
        content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum in elit ac quam cursus suscipit. Integer facilisis, justo a varius cursus, ligula turpis suscipit elit, in facilisis elit elit ut eros.\n\nSed fermentum, metus eget vehicula aliquet, urna nunc sodales eros, nec tincidunt ligula elit in libero. Curabitur sit amet arcu velit. Pellentesque at tristique ex. Fusce eu orci at erat bibendum varius sed eget odio.\n\nNunc tincidunt velit sit amet augue hendrerit, ac tempus odio eleifend. Suspendisse potenti. Nulla facilisi. Nam auctor mi eu sapien efficitur, a venenatis enim tempus.'
    },
    {
        id: 2,
        category: 'lorem',
        date: 'Lorem 15, 2024',
        title: 'Lorem Ipsum',
        description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
        content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum in elit ac quam cursus suscipit. Integer facilisis, justo a varius cursus, ligula turpis suscipit elit, in facilisis elit elit ut eros.\n\nSed fermentum, metus eget vehicula aliquet, urna nunc sodales eros, nec tincidunt ligula elit in libero. Curabitur sit amet arcu velit. Pellentesque at tristique ex. Fusce eu orci at erat bibendum varius sed eget odio.\n\nNunc tincidunt velit sit amet augue hendrerit, ac tempus odio eleifend. Suspendisse potenti. Nulla facilisi. Nam auctor mi eu sapien efficitur, a venenatis enim tempus.'
    },
    {
        id: 3,
        category: 'lorem',
        date: 'Lorem 15, 2024',
        title: 'Lorem Ipsum',
        description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
        content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum in elit ac quam cursus suscipit. Integer facilisis, justo a varius cursus, ligula turpis suscipit elit, in facilisis elit elit ut eros.\n\nSed fermentum, metus eget vehicula aliquet, urna nunc sodales eros, nec tincidunt ligula elit in libero. Curabitur sit amet arcu velit. Pellentesque at tristique ex. Fusce eu orci at erat bibendum varius sed eget odio.\n\nNunc tincidunt velit sit amet augue hendrerit, ac tempus odio eleifend. Suspendisse potenti. Nulla facilisi. Nam auctor mi eu sapien efficitur, a venenatis enim tempus.'
    },
    {
        id: 4,
        category: 'lorem',
        date: 'Lorem 15, 2024',
        title: 'Lorem Ipsum',
        description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
        content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum in elit ac quam cursus suscipit. Integer facilisis, justo a varius cursus, ligula turpis suscipit elit, in facilisis elit elit ut eros.\n\nSed fermentum, metus eget vehicula aliquet, urna nunc sodales eros, nec tincidunt ligula elit in libero. Curabitur sit amet arcu velit. Pellentesque at tristique ex. Fusce eu orci at erat bibendum varius sed eget odio.\n\nNunc tincidunt velit sit amet augue hendrerit, ac tempus odio eleifend. Suspendisse potenti. Nulla facilisi. Nam auctor mi eu sapien efficitur, a venenatis enim tempus.'
    },
    {
        id: 5,
        category: 'lorem',
        date: 'Lorem 15, 2024',
        title: 'Lorem Ipsum',
        description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
        content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum in elit ac quam cursus suscipit. Integer facilisis, justo a varius cursus, ligula turpis suscipit elit, in facilisis elit elit ut eros.\n\nSed fermentum, metus eget vehicula aliquet, urna nunc sodales eros, nec tincidunt ligula elit in libero. Curabitur sit amet arcu velit. Pellentesque at tristique ex. Fusce eu orci at erat bibendum varius sed eget odio.\n\nNunc tincidunt velit sit amet augue hendrerit, ac tempus odio eleifend. Suspendisse potenti. Nulla facilisi. Nam auctor mi eu sapien efficitur, a venenatis enim tempus.'
    }
];

const showModal = ref(false);
const currentArticle = ref<NewsItem | null>(null);

const openModal = (article: NewsItem) => {
    currentArticle.value = article;
    showModal.value = true;
    document.body.style.overflow = 'hidden'; 
};

const closeModal = () => {
    showModal.value = false;
    document.body.style.overflow = ''; 
};
</script>

<template>
    <div class="flex items-center justify-center min-h-screen px-4 py-12 bg-white sm:px-6">
        <div class="w-full max-w-6xl mx-auto overflow-hidden bg-white border border-gray-200 shadow-xl rounded-3xl">
            <div class="flex flex-col md:flex-row">
                <div
                    class="flex flex-col justify-center w-full p-8 md:w-2/5 bg-gradient-to-br from-white to-gray-50 md:p-12">
                    <div class="max-w-md mx-auto md:mx-0">
                        <div class="relative mb-12">
                            <div
                                class="absolute w-32 h-32 bg-gray-100 rounded-full opacity-50 -top-16 -left-16 blur-xl">
                            </div>
                            <div class="absolute right-0 w-24 h-24 bg-gray-200 rounded-full top-20 opacity-30 blur-lg">
                            </div>

                            <h1
                                class="relative z-10 mb-6 text-5xl font-bold text-transparent bg-clip-text bg-gradient-to-r from-gray-800 to-gray-600">
                                <span class="text-black">Latest</span> News
                            </h1>


                            <p class="relative z-10 mb-8 text-lg text-gray-800">
                                Lorem ipsum dolor sit amet consectetur adipisicing elit. Distinctio quaerat facere quam perspiciatis laboriosam corporis maxime optio, exercitationem maiores dicta tempore, cum eligendi repellendus, minima aperiam tempora quibusdam ut hic.
                            </p>

                            <div
                                class="relative inline-flex items-center justify-center px-6 py-3 overflow-hidden text-base font-medium text-white transition-all duration-300 rounded-full shadow-md cursor-pointer bg-gradient-to-r from-gray-700 to-black hover:from-gray-800 hover:to-gray-900 hover:shadow-lg group">
                                <span
                                    class="absolute w-0 h-0 transition-all duration-300 ease-out bg-white rounded-full group-hover:w-32 group-hover:h-32 opacity-10"></span>
                                <span class="relative">Subscribe to Updates</span>
                                <svg class="relative w-5 h-5 ml-2" fill="none" stroke="currentColor"
                                    viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                        d="M13 5l7 7-7 7"></path>
                                </svg>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="w-full overflow-y-auto bg-white md:w-3/5" style="max-height: 80vh;">
                    <div class="p-8 md:p-12">
                        <h2 class="mb-8 text-3xl font-bold text-gray-800 md:hidden">Top Stories</h2>

                        <div class="space-y-8">
                            <article v-for="item in newsItems" :key="item.id"
                                class="relative py-6 pl-6 pr-4 transition-all duration-300 bg-white border-l-4 border-gray-600 rounded-r-lg shadow-sm group hover:bg-gray-50 hover:shadow-md">

                                <div class="flex items-center justify-between mb-3">
                                    <span class="px-3 py-1 text-xs font-medium text-gray-700 bg-gray-100 rounded-full">{{
                                        item.category }}</span>
                                    <span class="text-sm text-gray-500">{{ item.date }}</span>
                                </div>

                                <h3
                                    class="mb-3 text-xl font-semibold text-gray-800 transition-colors group-hover:text-black">
                                    {{ item.title }}</h3>
                                <p class="mb-4 text-gray-600">{{ item.description }}</p>

                                <div class="flex justify-end">
                                    <button @click="openModal(item)"
                                        class="inline-flex items-center font-medium text-gray-700 hover:text-black">
                                        Read more
                                        <svg class="w-5 h-5 ml-2 transition-transform transform group-hover:translate-x-1"
                                            fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                d="M13 7l5 5-5 5"></path>
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                d="M6 12h12"></path>
                                        </svg>
                                    </button>
                                </div>

                                <div
                                    class="absolute top-0 right-0 w-16 h-16 rounded-bl-full bg-gradient-to-br from-gray-100 to-transparent opacity-40">
                                </div>
                            </article>
                        </div>

                        <div class="mt-12 text-center">
                            <button
                                class="inline-flex items-center justify-center px-6 py-3 text-base font-medium text-gray-700 transition-all duration-300 border border-gray-300 rounded-full hover:bg-gray-50">
                                Load More News
                                <svg class="w-5 h-5 ml-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                        d="M19 14l-7 7m0 0l-7-7m7 7V3"></path>
                                </svg>
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div v-if="showModal"
            class="fixed inset-0 z-50 flex items-center justify-center p-4 transition-opacity bg-black bg-opacity-50 backdrop-blur-sm"
            @click="closeModal">
            <div class="bg-white rounded-2xl shadow-2xl w-full max-w-4xl max-h-[90vh] overflow-y-auto" @click.stop>
                <div class="sticky top-0 flex items-center justify-between px-6 py-4 bg-white border-b border-gray-200">
                    <div class="flex items-center space-x-3">
                        <span class="px-3 py-1 text-xs font-medium text-gray-700 bg-gray-100 rounded-full">
                            {{ currentArticle?.category }}
                        </span>
                        <span class="text-sm text-gray-500">{{ currentArticle?.date }}</span>
                    </div>
                    <button @click="closeModal" class="text-gray-400 transition-colors hover:text-gray-600">
                        <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                d="M6 18L18 6M6 6l12 12"></path>
                        </svg>
                    </button>
                </div>
                <div class="p-6 md:p-8">
                    <h2 class="mb-6 text-3xl font-bold text-gray-800">{{ currentArticle?.title }}</h2>

                    <div class="prose prose-gray max-w-none">
                        <p class="leading-relaxed text-gray-700 whitespace-pre-line">{{ currentArticle?.content }}</p>
                    </div>

                    <div class="pt-6 mt-8 border-t border-gray-200">
                        <div class="flex justify-end">
                            <button
                                class="inline-flex items-center justify-center px-6 py-3 text-base font-medium text-white transition-all duration-300 rounded-full shadow-md bg-gradient-to-r from-gray-700 to-black hover:from-gray-800 hover:to-gray-900 hover:shadow-lg">
                                Share Article
                                <svg class="w-5 h-5 ml-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                        d="M8.684 13.342C8.886 12.938 9 12.482 9 12c0-.482-.114-.938-.316-1.342m0 2.684a3 3 0 110-2.684m0 2.684l6.632 3.316m-6.632-6l6.632-3.316m0 0a3 3 0 105.367-2.684 3 3 0 00-5.367 2.684zm0 9.316a3 3 0 105.368 2.684 3 3 0 00-5.368-2.684z">
                                    </path>
                                </svg>
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<style>
html {
    scroll-behavior: smooth;
}

body {
    font-family: 'Inter', 'Segoe UI', system-ui, sans-serif;
}

.overflow-y-auto::-webkit-scrollbar {
    width: 6px;
}

.overflow-y-auto::-webkit-scrollbar-track {
    background: #f5f5f5;
}

.overflow-y-auto::-webkit-scrollbar-thumb {
    background-color: #e0e0e0;
    border-radius: 6px;
}

.overflow-y-auto::-webkit-scrollbar-thumb:hover {
    background-color: #cccccc;
}

.overflow-y-auto {
    scrollbar-width: thin;
    scrollbar-color: #e0e0e0 #f5f5f5;
}

.transition-opacity {
    transition: opacity 0.3s ease;
}
</style>