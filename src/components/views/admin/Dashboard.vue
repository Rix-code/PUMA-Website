<script setup lang="ts">
import AdminLayout from './Layout.vue';

defineOptions({
    name: 'Dashboard',
});
</script>

<template>
    <AdminLayout>
        <div class="min-h-screen text-gray-800 bg-white">
            <div class="flex">
                <main class="flex-1 p-6">
                    <div class="mb-8">
                        <h1 class="mb-2 text-2xl font-bold">Lorem Ipsum</h1>
                        <p class="text-gray-600">Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
                    </div>

                    <div class="grid grid-cols-1 gap-6 mb-8 md:grid-cols-2 lg:grid-cols-4">
                        <div class="p-6 transition-shadow bg-white border border-gray-200 shadow-sm rounded-2xl hover:shadow-md">
                            <div class="flex items-center justify-between mb-4">
                                <h3 class="text-sm font-medium text-gray-500">Lorem Ipsum</h3>
                                <span class="bg-green-100 text-green-800 text-xs font-medium px-2.5 py-0.5 rounded-full">+12.5%</span>
                            </div>
                            <div class="flex items-baseline">
                                <span class="text-3xl font-bold">24,892</span>
                                <span class="ml-2 text-sm font-medium text-green-500">↑ 840</span>
                            </div>
                        </div>

                        <div class="p-6 transition-shadow bg-white border border-gray-200 shadow-sm rounded-2xl hover:shadow-md">
                            <div class="flex items-center justify-between mb-4">
                                <h3 class="text-sm font-medium text-gray-500">Lorem Ipsum</h3>
                                <span class="bg-green-100 text-green-800 text-xs font-medium px-2.5 py-0.5 rounded-full">+8.2%</span>
                            </div>
                            <div class="flex items-baseline">
                                <span class="text-3xl font-bold">1,432</span>
                                <span class="ml-2 text-sm font-medium text-green-500">↑ 145</span>
                            </div>
                        </div>

                        <div class="p-6 transition-shadow bg-white border border-gray-200 shadow-sm rounded-2xl hover:shadow-md">
                            <div class="flex items-center justify-between mb-4">
                                <h3 class="text-sm font-medium text-gray-500">Lorem Ipsum</h3>
                                <span class="bg-red-100 text-red-800 text-xs font-medium px-2.5 py-0.5 rounded-full">-2.4%</span>
                            </div>
                            <div class="flex items-baseline">
                                <span class="text-3xl font-bold">64,572</span>
                                <span class="ml-2 text-sm font-medium text-red-500">↓ 1,296</span>
                            </div>
                        </div>

                        <div class="p-6 transition-shadow bg-white border border-gray-200 shadow-sm rounded-2xl hover:shadow-md">
                            <div class="flex items-center justify-between mb-4">
                                <h3 class="text-sm font-medium text-gray-500">Lorem Ipsum</h3>
                                <span class="bg-green-100 text-green-800 text-xs font-medium px-2.5 py-0.5 rounded-full">+1.8%</span>
                            </div>
                            <div class="flex items-baseline">
                                <span class="text-3xl font-bold">3.6%</span>
                                <span class="ml-2 text-sm font-medium text-green-500">↑ 0.3%</span>
                            </div>
                        </div>
                    </div>

                    <div class="grid grid-cols-1 gap-6 mb-8 lg:grid-cols-2">
                        <div class="p-6 bg-white border border-gray-200 shadow-sm rounded-2xl">
                            <div class="flex items-center justify-between mb-6">
                                <h3 class="font-medium">Lorem Ipsum</h3>
                                <div class="flex space-x-2">
                                    <button class="px-3 py-1 text-xs text-white bg-black rounded-full">Lorem</button>
                                    <button class="px-3 py-1 text-xs bg-gray-100 rounded-full">Ipsum</button>
                                    <button class="px-3 py-1 text-xs bg-gray-100 rounded-full">Dolor</button>
                                </div>
                            </div>
                            <div class="flex items-end h-64 space-x-2">
                                <div class="w-8 h-20 bg-gray-200 rounded-t-lg"></div>
                                <div class="w-8 h-32 bg-gray-300 rounded-t-lg"></div>
                                <div class="w-8 h-24 bg-gray-200 rounded-t-lg"></div>
                                <div class="w-8 h-40 bg-gray-300 rounded-t-lg"></div>
                                <div class="w-8 h-48 bg-gray-200 rounded-t-lg"></div>
                                <div class="w-8 h-56 bg-black rounded-t-lg"></div>
                                <div class="w-8 bg-gray-200 rounded-t-lg h-36"></div>
                            </div>
                        </div>

                        <div class="p-6 bg-white border border-gray-200 shadow-sm rounded-2xl">
                            <div class="flex items-center justify-between mb-6">
                                <h3 class="font-medium">Lorem Ipsum</h3>
                                <div class="flex items-center space-x-1">
                                    <span class="w-3 h-3 bg-black rounded-full"></span>
                                    <span class="mr-3 text-xs text-gray-500">Lorem</span>
                                    <span class="w-3 h-3 bg-gray-300 rounded-full"></span>
                                    <span class="text-xs text-gray-500">Ipsum</span>
                                </div>
                            </div>
                            <div class="relative h-64">
                                <div class="absolute inset-0 flex items-center justify-center">
                                    <div class="relative w-40 h-40 overflow-hidden border-8 border-black rounded-full">
                                        <div class="absolute top-0 left-0 w-1/2 h-full bg-gray-300"></div>
                                    </div>
                                    <div class="absolute text-center">
                                        <div class="text-3xl font-bold">62%</div>
                                        <div class="text-xs text-gray-500">Lorem Ipsum</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="grid grid-cols-1 gap-6 lg:grid-cols-3">
                        <div class="p-6 bg-white border border-gray-200 shadow-sm rounded-2xl lg:col-span-2">
                            <div class="flex items-center justify-between mb-6">
                                <h3 class="font-medium">Lorem Ipsum</h3>
                                <button class="text-sm text-gray-500 hover:text-black">Lorem</button>
                            </div>

                            <div class="space-y-4">
                                <div class="flex items-start space-x-4">
                                    <div class="flex items-center justify-center flex-shrink-0 w-10 h-10 bg-blue-100 rounded-full">
                                        <svg class="w-5 h-5 text-blue-600" viewBox="0 0 20 20" fill="currentColor">
                                            <path d="M10 12a2 2 0 100-4 2 2 0 000 4z" />
                                            <path fill-rule="evenodd"
                                                d="M.458 10C1.732 5.943 5.522 3 10 3s8.268 2.943 9.542 7c-1.274 4.057-5.064 7-9.542 7S1.732 14.057.458 10zM14 10a4 4 0 11-8 0 4 4 0 018 0z"
                                                clip-rule="evenodd" />
                                        </svg>
                                    </div>
                                    <div class="flex-1">
                                        <div class="flex items-center justify-between">
                                            <h4 class="text-sm font-medium">Lorem Ipsum</h4>
                                            <span class="text-xs text-gray-500">2 mins ago</span>
                                        </div>
                                        <p class="text-sm text-gray-600">Lorem ipsum dolor sit amet.</p>
                                    </div>
                                </div>

                                <div class="flex items-start space-x-4">
                                    <div class="flex items-center justify-center flex-shrink-0 w-10 h-10 bg-green-100 rounded-full">
                                        <svg class="w-5 h-5 text-green-600" viewBox="0 0 20 20" fill="currentColor">
                                            <path fill-rule="evenodd"
                                                d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z"
                                                clip-rule="evenodd" />
                                        </svg>
                                    </div>
                                    <div class="flex-1">
                                        <div class="flex items-center justify-between">
                                            <h4 class="text-sm font-medium">Lorem Ipsum</h4>
                                            <span class="text-xs text-gray-500">10 mins ago</span>
                                        </div>
                                        <p class="text-sm text-gray-600">Lorem ipsum dolor sit amet.</p>
                                    </div>
                                </div>

                                <div class="flex items-start space-x-4">
                                    <div class="flex items-center justify-center flex-shrink-0 w-10 h-10 bg-purple-100 rounded-full">
                                        <svg class="w-5 h-5 text-purple-600" viewBox="0 0 20 20" fill="currentColor">
                                            <path
                                                d="M13.586 3.586a2 2 0 112.828 2.828l-.793.793-2.828-2.828.793-.793zM11.379 5.793L3 14.172V17h2.828l8.38-8.379-2.83-2.828z" />
                                        </svg>
                                    </div>
                                    <div class="flex-1">
                                        <div class="flex items-center justify-between">
                                            <h4 class="text-sm font-medium">Lorem Ipsum</h4>
                                            <span class="text-xs text-gray-500">1 hour ago</span>
                                        </div>
                                        <p class="text-sm text-gray-600">Lorem ipsum dolor sit amet.</p>
                                    </div>
                                </div>

                                <div class="flex items-start space-x-4">
                                    <div class="flex items-center justify-center flex-shrink-0 w-10 h-10 bg-yellow-100 rounded-full">
                                        <svg class="w-5 h-5 text-yellow-600" viewBox="0 0 20 20" fill="currentColor">
                                            <path fill-rule="evenodd"
                                                d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-7 4a1 1 0 11-2 0 1 1 0 012 0zm-1-9a1 1 0 00-1 1v4a1 1 0 102 0V6a1 1 0 00-1-1z"
                                                clip-rule="evenodd" />
                                        </svg>
                                    </div>
                                    <div class="flex-1">
                                        <div class="flex items-center justify-between">
                                            <h4 class="text-sm font-medium">Lorem Ipsum</h4>
                                            <span class="text-xs text-gray-500">2 hours ago</span>
                                        </div>
                                        <p class="text-sm text-gray-600">Lorem ipsum dolor sit amet.</p>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="p-6 bg-white border border-gray-200 shadow-sm rounded-2xl">
                            <div class="flex items-center justify-between mb-6">
                                <h3 class="font-medium">Lorem Ipsum</h3>
                                <button class="text-sm text-gray-500 hover:text-black">Lorem</button>
                            </div>

                            <div class="space-y-4">
                                <div class="p-4 border border-gray-100 rounded-lg bg-gray-50">
                                    <div class="flex items-center mb-2 space-x-2">
                                        <div class="w-2 h-2 bg-blue-500 rounded-full"></div>
                                        <span class="text-xs text-gray-500">Lorem</span>
                                    </div>
                                    <h4 class="mb-1 text-sm font-medium">Lorem Ipsum</h4>
                                    <p class="text-xs text-gray-500">Lorem ipsum dolor sit amet.</p>
                                </div>

                                <div class="p-4 border border-gray-100 rounded-lg bg-gray-50">
                                    <div class="flex items-center mb-2 space-x-2">
                                        <div class="w-2 h-2 bg-green-500 rounded-full"></div>
                                        <span class="text-xs text-gray-500">Lorem</span>
                                    </div>
                                    <h4 class="mb-1 text-sm font-medium">Lorem Ipsum</h4>
                                    <p class="text-xs text-gray-500">Lorem ipsum dolor sit amet.</p>
                                </div>

                                <div class="p-4 border border-gray-100 rounded-lg bg-gray-50">
                                    <div class="flex items-center mb-2 space-x-2">
                                        <div class="w-2 h-2 bg-purple-500 rounded-full"></div>
                                        <span class="text-xs text-gray-500">Lorem</span>
                                    </div>
                                    <h4 class="mb-1 text-sm font-medium">Lorem Ipsum</h4>
                                    <p class="text-xs text-gray-500">Lorem ipsum dolor sit amet.</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </main>
            </div>
        </div>
    </AdminLayout>
</template>