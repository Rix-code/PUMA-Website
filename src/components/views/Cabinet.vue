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
    <div class="relative min-h-screen py-12 overflow-hidden font-mono text-white bg-black">
        <div class="absolute inset-0 grid-lines opacity-10"></div>

        <div class="absolute rounded-full top-1/4 left-1/4 w-96 h-96 bg-white/5 blur-3xl"></div>
        <div class="absolute w-64 h-64 rounded-full bottom-1/3 right-1/3 bg-white/5 blur-3xl"></div>

        <!-- Organization Introduction Section -->
        <section class="relative pt-16 pb-12">
            <div class="container px-6 mx-auto text-center">
                <h1 class="mb-2 text-5xl font-bold glitch-text">PUMA INFORMATICS</h1>
                <div class="w-24 h-1 mx-auto mb-6 bg-white/50"></div>
                <p class="max-w-2xl mx-auto leading-relaxed tracking-wide text-white/70">
                    PUMA Informatics is the official student organization for the Informatics Department at President
                    University.
                    We are dedicated to developing students' capabilities in technology and fostering a community of
                    forward-thinking tech enthusiasts who contribute positively to society.
                </p>
            </div>
        </section>

        <!-- Kaustav Cabinet Section -->
        <section class="container relative z-10 px-6 py-12 mx-auto">
            <div class="mb-12 text-center">
                <h2 class="mb-4 text-4xl font-bold">KAUSTAV CABINET</h2>
                <div class="w-20 h-1 mx-auto mb-6 bg-white/50"></div>
                <p class="max-w-2xl mx-auto leading-relaxed tracking-wide text-white/70">
                    The Kaustav Cabinet is the current leadership body of PUMA Informatics for the 2024 period. Named
                    after a legendary gem,
                    the cabinet focuses on polishing the potential of each informatics student and creating
                    opportunities for growth and
                    development in the field of technology.
                </p>
            </div>
        </section>

        <!-- Vision & Mission Section -->
        <section class="container relative z-10 px-6 py-12 mx-auto">
            <div class="grid grid-cols-1 gap-8 md:grid-cols-2">
                <div
                    class="overflow-hidden transition-all duration-500 border rounded-lg bg-white/5 backdrop-blur-sm border-white/10 hover:border-white/30 group">
                    <div class="p-6">
                        <div class="flex items-center mb-4">
                            <h2 class="text-2xl font-bold tracking-wider">VISION</h2>
                        </div>

                        <div class="space-y-3 text-sm text-white/80">
                            <p class="text-lg font-semibold">
                                Kaustav CABINET PUMA Informatics serves as a platform for informatics students to become
                                an excellent generation with impactful and high-quality intellectual, emotional,
                                spiritual, moral, and social capabilities.
                            </p>
                        </div>
                    </div>
                </div>

                <div
                    class="overflow-hidden transition-all duration-500 border rounded-lg bg-white/5 backdrop-blur-sm border-white/10 hover:border-white/30 group">
                    <div class="p-6">
                        <div class="flex items-center mb-4">
                            <h2 class="text-2xl font-bold tracking-wider">MISSION</h2>
                        </div>

                        <div class="space-y-4 text-sm text-white/80">
                            <div>
                                <h3 class="mb-1 font-bold">INTELLECTUAL</h3>
                                <p>Providing innovative and effective information in the field of technology to create
                                    intellectual Informatics students.</p>
                            </div>

                            <div>
                                <h3 class="mb-1 font-bold">SOCIAL</h3>
                                <p>Taking an active social role in improving the quality of life in society through
                                    initiatives, sustainable collaborations, and developing informatics solutions that
                                    have a positive impact locally and globally.</p>
                            </div>

                            <div>
                                <h3 class="mb-1 font-bold">EMOTIONAL</h3>
                                <p>Strengthening emotional bonds by optimizing communication forums for conveying
                                    information and aspirations of informatics students within the academic community of
                                    President University's Informatics Department.</p>
                            </div>

                            <div>
                                <h3 class="mb-1 font-bold">MORAL</h3>
                                <p>Prioritizing moral and integrity in every aspect of activities and learning within
                                    the Informatics Department of President University.</p>
                            </div>

                            <div>
                                <h3 class="mb-1 font-bold">SPIRITUAL</h3>
                                <p>Integrating spiritual values into every activity and program within PUMA Informatics.
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Logo Philosophy Section -->
        <section class="relative pt-12 pb-12">
            <div class="container px-6 mx-auto mb-12 text-center">
                <h2 class="mb-4 text-4xl font-bold">LOGO PHILOSOPHY</h2>
                <div class="w-20 h-1 mx-auto mb-6 bg-white/50"></div>
            </div>

            <div class="container relative z-10 px-6 mx-auto">
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
                                <h2 class="text-2xl font-bold tracking-wider">PUMA INFORMATICS</h2>
                            </div>

                            <div class="space-y-3 text-sm text-white/80">
                                <p>Set of trapezoids forming the letter C
                                    This logo has a trapezoidal shape that forms the letter C, symbolizing the Computer
                                    Science faculty. The use of the trapezoid gives a dynamic and modern impression that
                                    is in line with the field of technology.
                                </p>
                                <p>The two rectangles that make up the IT text
                                    The placement of IT in the base of the letter C represents the Informatics
                                    department which is part of the Computing faculty. This illustrates the close
                                    relationship between the two.
                                </p>
                                <p>Distance Between Letter C Trapezoids
                                    The distance between the trapezoidal letters C shows the diversity of members at
                                    PUMA Informatics. It illustrates the space for diversity and inclusion within the
                                    organization.
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
                                    wisdom, knowledge, and success in Hindu mythology. The main element in this logo is
                                    the
                                    representation of an elephant head with a single tusk, which holds deep symbolism
                                    related to Ganesha.</p>
                                <p>The diamond-like shape of the logo also holds special significance. The name Kaustav
                                    means legendary gem, and the diamond shape symbolizes excellence, high value, and
                                    enduring strength, reflecting Kaustav Cabinet's commitment to delivering the best
                                    value
                                    and producing outstanding work in every aspect of its activities.</p>
                                <p>The crown above the elephant head signifies leadership and foresight, which are
                                    central
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
            </div>
        </section>
    </div>
    <Footer />
</template>