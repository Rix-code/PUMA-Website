<script lang="ts">
import { defineComponent } from 'vue';
import Navbar from '../Navbar.vue';
import Footer from '../Footer.vue';

export default defineComponent({
    components: {
        Navbar,
        Footer,
    },
});
</script>

<template>
    <Navbar />
    <div class="relative min-h-screen py-12 overflow-hidden font-mono text-white bg-black ">
        <div class="absolute inset-0 grid-lines opacity-10"></div>

        <div class="absolute rounded-full top-1/4 left-1/4 w-96 h-96 bg-white/5 blur-3xl"></div>
        <div class="absolute w-64 h-64 rounded-full bottom-1/3 right-1/3 bg-white/5 blur-3xl"></div>

        <section class="relative pt-16 pb-12">
            <div class="container px-6 mx-auto text-center">
                <h1 class="mb-2 text-5xl font-bold glitch-text">LOGO PHILOSOPHY</h1>
                <div class="w-24 h-1 mx-auto mb-6 bg-white/50"></div>
                <p class="max-w-2xl mx-auto leading-relaxed tracking-wide text-white/70">
                    Lorem ipsum dolor sit amet consectetur, adipisicing elit. Minus veniam inventore numquam ducimus
                    maiores illum repellendus fuga quas tempora, repudiandae sequi non aspernatur minima unde amet
                    blanditiis laudantium nam doloremque?
                </p>
            </div>
        </section>

        <section class="container relative z-10 px-6 py-12 mx-auto">
            <div class="grid grid-cols-1 gap-8 md:grid-cols-2">
                <div
                    class="overflow-hidden transition-all duration-500 border rounded-lg bg-white/5 backdrop-blur-sm border-white/10 hover:border-white/30 group">
                    <div class="relative flex items-center justify-center h-64 p-8 overflow-hidden bg-black">
                        <div class="absolute inset-0 grid-lines opacity-20"></div>
                        <div
                            class="relative w-48 h-48 transition-transform duration-500 transform group-hover:scale-110">
                            <img src="../../../public/logo.png" alt="puma logo">
                            <div
                                class="absolute bottom-0 right-0 px-2 py-1 text-xs font-bold tracking-wider text-black bg-white rounded">
                                PUMA</div>
                        </div>
                    </div>
                    <div class="p-6">
                        <div class="flex items-center mb-4">
                            <span class="px-2 py-1 mr-3 text-xs rounded-full bg-white/10">EST.2023</span>
                            <h2 class="text-2xl font-bold tracking-wider">PUMA</h2>
                        </div>

                        <div class="space-y-3 text-sm text-white/80">
                            <p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Quasi tenetur autem error
                                repudiandae. Et nemo quae similique, quia cum, iusto cumque aliquid laborum nulla velit
                                dolorum pariatur deserunt repudiandae asperiores!</p>
                            <p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Quasi tenetur autem error
                                repudiandae. Et nemo quae similique, quia cum, iusto cumque aliquid laborum nulla velit
                                dolorum pariatur deserunt repudiandae asperiores!</p>
                            <p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Quasi tenetur autem error
                                repudiandae. Et nemo quae similique, quia cum, iusto cumque aliquid laborum nulla velit
                                dolorum pariatur deserunt repudiandae asperiores!</p>
                            <p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Quasi tenetur autem error
                                repudiandae. Et nemo quae similique, quia cum, iusto cumque aliquid laborum nulla velit
                                dolorum pariatur deserunt repudiandae asperiores!</p>
                        </div>

                        <div class="mt-6">
                            <button
                                class="flex items-center px-4 py-2 text-xs font-bold transition-all duration-300 border rounded-lg group border-white/20 hover:bg-white hover:text-black">
                                <span>EXPLORE PHILOSOPHY</span>
                                <svg xmlns="http://www.w3.org/2000/svg"
                                    class="w-4 h-4 ml-2 transition-transform duration-300 group-hover:translate-x-1"
                                    fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                        d="M14 5l7 7m0 0l-7 7m7-7H3" />
                                </svg>
                            </button>
                        </div>
                    </div>
                </div>

                <div
                    class="overflow-hidden transition-all duration-500 border rounded-lg bg-white/5 backdrop-blur-sm border-white/10 hover:border-white/30 group">
                    <div class="relative flex items-center justify-center h-64 p-8 overflow-hidden bg-black">
                        <div class="absolute inset-0 grid-lines opacity-20"></div>
                        <div
                            class="relative w-48 h-48 transition-transform duration-500 transform group-hover:scale-110">
                            <img src="../../../public/kaustav.png" alt="kaustav logo">
                            <div
                                class="absolute bottom-0 right-0 px-2 py-1 text-xs font-bold tracking-wider text-black bg-white rounded">
                                KAUSTAV</div>
                        </div>
                    </div>
                    <div class="p-6">
                        <div class="flex items-center mb-4">
                            <span class="px-2 py-1 mr-3 text-xs rounded-full bg-white/10">EST.2024</span>
                            <h2 class="text-2xl font-bold tracking-wider">KAUSTAV CABINET</h2>
                        </div>

                        <div class="space-y-3 text-sm text-white/80">
                            <p>The Kaustav Cabinet logo is inspired by the noble qualities of Ganesha, the deity of
                                wisdom, knowledge, and success in Hindu mythology. The main element in this logo is the
                                representation of an elephant head with a single tusk, which holds deep symbolism
                                related to Ganesha.</p>
                            <p>The diamond-like shape of the logo also holds special significance. The name Kaustav
                                means legendary gem, and the diamond shape symbolizes excellence, high value, and
                                enduring strength, reflecting Kaustav Cabinet's commitment to delivering the best value
                                and producing outstanding work in every aspect of its activities.</p>
                            <p>The crown above the elephant head signifies leadership and foresight, which are central
                                to the mission of Kaustav Cabinet. We are committed to leading wisely, making bold
                                decisions, and always focusing on achieving greater goals for collective progress.
                            </p>
                            <p>
                                Ganesha is known for having a single tusk after a battle, symbolizing sacrifice,
                                strength, and resilience. In this context, the remaining single tusk in the Kaustav
                                Cabinet logo represents the ability to overcome challenges and strive toward success
                                with determination and perseverance.
                            </p>
                        </div>

                        <div class="mt-6">
                            <button
                                class="flex items-center px-4 py-2 text-xs font-bold transition-all duration-300 border rounded-lg group border-white/20 hover:bg-white hover:text-black">
                                <span>EXPLORE PHILOSOPHY</span>
                                <svg xmlns="http://www.w3.org/2000/svg"
                                    class="w-4 h-4 ml-2 transition-transform duration-300 group-hover:translate-x-1"
                                    fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                        d="M14 5l7 7m0 0l-7 7m7-7H3" />
                                </svg>
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </div>
    <Footer />
</template>
