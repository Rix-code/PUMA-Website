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
    <Navbar/>
    <div class="relative flex items-center justify-center min-h-screen p-4 bg-white">
        <div class="absolute inset-0 overflow-hidden">
            <div class="dot-pattern"></div>
        </div>
        
        <div class="relative w-full max-w-md py-24">
            <div class="absolute top-0 w-64 h-64 rounded-full -z-10 bg-purple-500/10 blur-3xl -left-32"></div>
            <div class="absolute bottom-0 w-64 h-64 rounded-full -z-10 bg-blue-500/10 blur-3xl -right-32"></div>

            <div class="overflow-hidden bg-white border shadow-2xl backdrop-blur-lg border-black/10 rounded-2xl">
                <div class="flex border-b border-black/10">
                    <button @click="activeTab = 'login'" :class="[
                        'flex-1 py-4 px-6 font-mono text-sm uppercase transition-all duration-300',
                        activeTab === 'login'
                            ? 'text-black bg-black/5'
                            : 'text-black/60 hover:text-black hover:bg-black/5'
                    ]">
                        <div class="flex items-center justify-center">
                            <span class="mr-2 text-xs px-1.5 py-0.5 rounded-full bg-black/10">01</span>
                            Login
                        </div>
                    </button>
                    <button @click="activeTab = 'register'" :class="[
                        'flex-1 py-4 px-6 font-mono text-sm uppercase transition-all duration-300',
                        activeTab === 'register'
                            ? 'text-black bg-black/5'
                            : 'text-black/60 hover:text-black hover:bg-black/5'
                    ]">
                        <div class="flex items-center justify-center">
                            <span class="mr-2 text-xs px-1.5 py-0.5 rounded-full bg-black/10">02</span>
                            Register
                        </div>
                    </button>
                </div>

                <div v-if="activeTab === 'login'" class="p-8 space-y-6">
                    <h2 class="font-mono text-2xl font-bold text-center text-black">
                        <span class="text-black">
                            Login
                        </span>
                    </h2>

                    <form @submit.prevent class="space-y-6">
                        <div class="space-y-2">
                            <label
                                class="block font-mono text-xs tracking-wider uppercase text-black/70">Username</label>
                            <div class="relative">
                                <div class="absolute inset-y-0 left-0 flex items-center pl-3 pointer-events-none">
                                    <span class="text-xs text-black/40">[ID]</span>
                                </div>
                                <input type="text"
                                    class="w-full py-3 pl-12 pr-4 font-mono text-black transition-all border rounded-lg bg-black/5 border-black/10 focus:outline-none focus:ring-2 focus:ring-blue-500/50 focus:border-transparent"
                                    placeholder="Enter username" />
                            </div>
                        </div>

                        <div class="space-y-2">
                            <label
                                class="block font-mono text-xs tracking-wider uppercase text-black/70">Password</label>
                            <div class="relative">
                                <div class="absolute inset-y-0 left-0 flex items-center pl-3 pointer-events-none">
                                    <span class="text-xs text-black/40">[PW]</span>
                                </div>
                                <input :type="showPassword ? 'text' : 'password'"
                                    class="w-full py-3 pl-12 pr-10 font-mono text-black transition-all border rounded-lg bg-black/5 border-black/10 focus:outline-none focus:ring-2 focus:ring-blue-500/50 focus:border-transparent"
                                    placeholder="Enter password" />
                                <button type="button" @click="showPassword = !showPassword"
                                    class="absolute inset-y-0 right-0 flex items-center pr-3 text-black/40 hover:text-black/70">
                                    <span class="text-xs">{{ showPassword ? '[HIDE]' : '[SHOW]' }}</span>
                                </button>
                            </div>
                        </div>

                        <div class="flex items-center justify-between">
                            <div class="flex items-center">
                                <input id="remember-me" type="checkbox"
                                    class="w-4 h-4 text-blue-500 border rounded bg-black/5 border-black/10 focus:ring-blue-500/50" />
                                <label for="remember-me" class="ml-2 font-mono text-sm text-black/70">Remember
                                    session</label>
                            </div>
                            <button type="button" class="font-mono text-sm text-blue-600 hover:text-blue-800">Reset
                                access</button>
                        </div>

                        <button type="submit"
                            class="w-full px-4 py-3 font-mono font-bold tracking-wider text-white uppercase transition-all duration-300 bg-black rounded-lg ">
                            <span class="flex items-center justify-center">
                                <span class="mr-2">Login</span>
                                <span class="text-xs">[→]</span>
                            </span>
                        </button>
                    </form>
                </div>

                <div v-if="activeTab === 'register'" class="p-8 space-y-6">
                    <h2 class="font-mono text-2xl font-bold text-center text-black">
                        <span class="text-black">
                            Create Account
                        </span>
                    </h2>

                    <form @submit.prevent class="space-y-6">
                        <div class="grid grid-cols-2 gap-4">
                            <div class="space-y-2">
                                <label class="block font-mono text-xs tracking-wider uppercase text-black/70">First
                                    Name</label>
                                <input type="text"
                                    class="w-full px-4 py-3 font-mono text-black transition-all border rounded-lg bg-black/5 border-black/10 focus:outline-none focus:ring-2 focus:ring-blue-500/50 focus:border-transparent"
                                    placeholder="First name" />
                            </div>
                            <div class="space-y-2">
                                <label class="block font-mono text-xs tracking-wider uppercase text-black/70">Last
                                    Name</label>
                                <input type="text"
                                    class="w-full px-4 py-3 font-mono text-black transition-all border rounded-lg bg-black/5 border-black/10 focus:outline-none focus:ring-2 focus:ring-blue-500/50 focus:border-transparent"
                                    placeholder="Last name" />
                            </div>
                        </div>

                        <div class="space-y-2">
                            <label class="block font-mono text-xs tracking-wider uppercase text-black/70">Email</label>
                            <div class="relative">
                                <div class="absolute inset-y-0 left-0 flex items-center pl-3 pointer-events-none">
                                    <span class="text-xs text-black/40">[E]</span>
                                </div>
                                <input type="email"
                                    class="w-full py-3 pl-12 pr-4 font-mono text-black transition-all border rounded-lg bg-black/5 border-black/10 focus:outline-none focus:ring-2 focus:ring-blue-500/50 focus:border-transparent"
                                    placeholder="Enter email address" />
                            </div>
                        </div>

                        <div class="space-y-2">
                            <label
                                class="block font-mono text-xs tracking-wider uppercase text-black/70">Username</label>
                            <div class="relative">
                                <div class="absolute inset-y-0 left-0 flex items-center pl-3 pointer-events-none">
                                    <span class="text-xs text-black/40">[ID]</span>
                                </div>
                                <input type="text"
                                    class="w-full py-3 pl-12 pr-4 font-mono text-black transition-all border rounded-lg bg-black/5 border-black/10 focus:outline-none focus:ring-2 focus:ring-blue-500/50 focus:border-transparent"
                                    placeholder="Choose username" />
                            </div>
                        </div>

                        <div class="space-y-2">
                            <label
                                class="block font-mono text-xs tracking-wider uppercase text-black/70">Password</label>
                            <div class="relative">
                                <div class="absolute inset-y-0 left-0 flex items-center pl-3 pointer-events-none">
                                    <span class="text-xs text-black/40">[PW]</span>
                                </div>
                                <input :type="showPassword ? 'text' : 'password'"
                                    class="w-full py-3 pl-12 pr-10 font-mono text-black transition-all border rounded-lg bg-black/5 border-black/10 focus:outline-none focus:ring-2 focus:ring-blue-500/50 focus:border-transparent"
                                    placeholder="Create password" />
                                <button type="button" @click="showPassword = !showPassword"
                                    class="absolute inset-y-0 right-0 flex items-center pr-3 text-black/40 hover:text-black/70">
                                    <span class="text-xs">{{ showPassword ? '[HIDE]' : '[SHOW]' }}</span>
                                </button>
                            </div>
                            <div class="flex mt-1">
                                <div class="flex-1 h-1 rounded-full bg-black/10"></div>
                                <div class="flex-1 h-1 ml-1 rounded-full bg-black/10"></div>
                                <div class="flex-1 h-1 ml-1 rounded-full bg-black/10"></div>
                            </div>
                        </div>

                        <div class="flex items-start">
                            <div class="flex items-center h-5">
                                <input id="terms" type="checkbox"
                                    class="w-4 h-4 text-blue-500 border rounded bg-black/5 border-black/10 focus:ring-blue-500/50" />
                            </div>
                            <div class="ml-3 text-sm">
                                <label for="terms" class="font-mono text-black/70">
                                    I accept the <a href="#" class="text-blue-600 hover:text-blue-800">terms of
                                        service</a> and <a href="#" class="text-blue-600 hover:text-blue-800">privacy
                                        policy</a>
                                </label>
                            </div>
                        </div>

                        <button type="submit"
                            class="w-full px-4 py-3 font-mono font-bold tracking-wider text-white uppercase transition-all duration-300 bg-black rounded-lg">
                            <span class="flex items-center justify-center">
                                <span class="mr-2">Register</span>
                                <span class="text-xs">[→]</span>
                            </span>
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <Footer/>
</template>

<script setup lang="ts">
import { ref } from 'vue'

const activeTab = ref('login')
const showPassword = ref(false)
</script>

<style scoped>
input[type="checkbox"] {
    appearance: none;
    background-color: rgba(0, 0, 0, 0.05);
    border: 1px solid rgba(0, 0, 0, 0.1);
    width: 16px;
    height: 16px;
    border-radius: 3px;
    display: inline-block;
    position: relative;
    cursor: pointer;
}

input[type="checkbox"]:checked {
    background-color: rgb(59, 130, 246);
    border-color: rgb(59, 130, 246);
}

input[type="checkbox"]:checked::after {
    content: "";
    position: absolute;
    left: 5px;
    top: 2px;
    width: 5px;
    height: 9px;
    border: solid white;
    border-width: 0 2px 2px 0;
    transform: rotate(45deg);
}

/* Dot pattern background */
.dot-pattern {
    position: absolute;
    width: 100%;
    height: 100%;
    background-image: radial-gradient(rgba(0, 0, 0, 0.15) 1px, transparent 1px);
    background-size: 24px 24px;
    background-position: 0 0;
    animation: moveBackground 60s linear infinite;
}

@keyframes moveBackground {
    0% {
        transform: translate(0, 0);
    }
    50% {
        transform: translate(12px, 12px);
    }
    100% {
        transform: translate(0, 0);
    }
}
</style>