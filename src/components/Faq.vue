<template>
    <div class="relative w-full min-h-screen overflow-hidden text-black bg-white faq-container question-cursor">
        <div class="absolute inset-0 grid-lines opacity-10"></div>
        <div class="container relative z-10 px-4 pt-20 pb-10 mx-auto">
            <div class="mb-16 text-center">
                <h1 class="mb-4 font-mono text-4xl font-bold tracking-wider">
                    <span>FREQUENTLY ASKED QUESTIONS</span>
                </h1>
                <div class="w-24 h-1 mx-auto mb-6 bg-black/80"></div>
                <p class="max-w-2xl mx-auto font-mono text-black/70">
                    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam euismod risus ac nisi feugiat.
                </p>
            </div>
            <div class="max-w-3xl mx-auto mb-16 space-y-6">
                <div v-for="(faq, index) in faqs" :key="index"
                    class="overflow-hidden border rounded-lg faq-item border-black/10">
                    <button @click="toggleFaq(index)"
                        class="flex items-center justify-between w-full px-6 py-4 font-mono font-medium text-left transition-all duration-300 faq-question hover:bg-black/5"
                        :class="{ 'bg-black/5': openIndex === index }">
                        <div class="flex items-center">
                            <span class="px-2 py-1 mr-3 text-xs rounded-sm bg-black/10 text-black/80">
                                {{ (index + 1).toString().padStart(2, '0') }}
                            </span>
                            <span class="font-bold">{{ faq.question }}</span>
                        </div>
                        <span class="text-xl transition-transform duration-300"
                            :class="{ 'rotate-45': openIndex === index }">+</span>
                    </button>
                    <div class="overflow-hidden font-mono transition-all duration-300 text-black/80"
                        :class="openIndex === index ? 'max-h-96 py-4' : 'max-h-0'">
                        <div class="px-6 pl-16">{{ faq.answer }}</div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>
<script setup lang="ts">
import { ref } from 'vue'
const openIndex = ref<number | null>(null)
const toggleFaq = (index: number): void => {
    openIndex.value = openIndex.value === index ? null : index
}
interface FaqItem {
    question: string;
    answer: string;
}
const loremQuestion = "Lorem ipsum dolor sit amet, consectetur adipiscing elit?"
const loremAnswer = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam euismod risus ac nisi feugiat, vel facilisis tellus dignissim. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Nulla facilisi. Sed vitae metus non enim fermentum consequat. Donec eget magna vel purus lobortis ultricies."
const faqs: FaqItem[] = [
    {
        question: loremQuestion,
        answer: loremAnswer
    },
    {
        question: loremQuestion,
        answer: loremAnswer
    },
    {
        question: loremQuestion,
        answer: loremAnswer
    }
]
</script>
<style scoped>
.grid-lines {
    background-image:
        linear-gradient(to right, rgba(0, 0, 0, 0.05) 1px, transparent 1px),
        linear-gradient(to bottom, rgba(0, 0, 0, 0.05) 1px, transparent 1px);
    background-size: 20px 20px;
}
.faq-container {
    box-shadow: 0 5px 30px rgba(0, 0, 0, 0.05);
}

</style>