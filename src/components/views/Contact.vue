<script lang="ts">
import { defineComponent } from 'vue';
import Navbar from '../Navbar.vue';

export default defineComponent({
    components: {
        Navbar,
    },
});
</script>

<template>
    <Navbar />
    <section id="contact" class="relative py-32 bg-white">
        <div class="absolute inset-0 h-32 pointer-events-none bg-gradient-to-b from-gray-100 to-white"></div>
        <div class="container relative px-4 mx-auto">
            <h2 class="mb-4 text-4xl font-bold text-center text-black">Contact Us</h2>
            <p class="max-w-2xl mx-auto mb-12 text-center text-gray-700">
                Have questions? We'd love to hear from you. Send us a message and we'll respond as soon as possible.
            </p>
            <div class="max-w-3xl mx-auto">
                <div class="p-8 transition-all duration-300 transform bg-white border border-gray-200 shadow-xl rounded-xl hover:shadow-2xl hover:border-gray-300">
                    <form class="space-y-6">
                        <div class="grid gap-6 md:grid-cols-2">
                            <div>
                                <label class="block mb-2 font-medium text-gray-800">Name</label>
                                <input type="text"
                                    class="w-full px-4 py-3 text-black transition-all bg-white border border-gray-300 rounded-lg focus:outline-none focus:border-black focus:ring-2 focus:ring-gray-200" />
                            </div>
                            <div>
                                <label class="block mb-2 font-medium text-gray-800">Email</label>
                                <input type="email"
                                    class="w-full px-4 py-3 text-black transition-all bg-white border border-gray-300 rounded-lg focus:outline-none focus:border-black focus:ring-2 focus:ring-gray-200" />
                            </div>
                        </div>
                        <div>
                            <label class="block mb-2 font-medium text-gray-800">Subject</label>
                            <input type="text"
                                class="w-full px-4 py-3 text-black transition-all bg-white border border-gray-300 rounded-lg focus:outline-none focus:border-black focus:ring-2 focus:ring-gray-200" />
                        </div>
                        <div>
                            <label class="block mb-2 font-medium text-gray-800">Message</label>
                            <textarea rows="4"
                                class="w-full px-4 py-3 text-black transition-all bg-white border border-gray-300 rounded-lg focus:outline-none focus:border-black focus:ring-2 focus:ring-gray-200"></textarea>
                        </div>
                        <button type="submit"
                            class="w-full bg-black text-white py-3 px-6 rounded-lg hover:bg-gray-800 transition-colors transform hover:-translate-y-0.5 duration-200 font-bold">
                            Send Message
                        </button>
                    </form>
                </div>
            </div>
        </div>
        <div class="absolute inset-0 bg-[radial-gradient(circle_at_center,rgba(0,0,0,0.05),transparent)] pointer-events-none">
        </div>
        <div class="absolute w-32 h-1 bg-black top-20 left-8 opacity-20"></div>
        <div class="absolute w-16 h-1 bg-black top-24 left-12 opacity-10"></div>
        <div class="absolute w-32 h-1 bg-black bottom-20 right-8 opacity-20"></div>
        <div class="absolute w-16 h-1 bg-black bottom-24 right-12 opacity-10"></div>
    </section>
</template>