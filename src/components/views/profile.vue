<script setup lang="ts">
import { ref, reactive, computed } from 'vue';
import Navbar from '../Navbar.vue';
import Footer from '../Footer.vue';

const user = reactive({
    name: 'John Doe',
    email: 'john@example.com',
    avatar: 'https://i.pinimg.com/474x/2d/66/90/2d669016a3e3f5316b0589741e8ca834.jpg',
    // ganti ke Guest untuk lihat guest view
    role: 'Member', 
    division: 'Research and Technology',
    joined: 'August 12, 2023',
    position: 'Head of Division',
    cabinet: 'Kaustav Cabinet',
    linkedin: 'https://linkedin.com/in/johndoe',
    instagram: 'https://instagram.com/johndoe',
    personalDescription: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
    batch: '2023'
});

const editedUser = reactive({
    name: user.name,
    avatar: user.avatar,
    linkedin: user.linkedin,
    instagram: user.instagram,
    personalDescription: user.personalDescription,
    batch: user.batch
});

const isEditing = ref(false);
const isUploading = ref(false);
const uploadProgress = ref(0);
const fileInput = ref<HTMLInputElement | null>(null);

const avatarOptions = [
    'https://i.pinimg.com/474x/2d/66/90/2d669016a3e3f5316b0589741e8ca834.jpg',
    'https://i.pinimg.com/474x/9c/58/0a/9c580ad4644fffdb9bf4eedb7b61eec2.jpg',
    'https://i.pinimg.com/474x/d5/14/5e/d5145e0284dcf8b0d828b78d2ebeaacc.jpg',
    'https://i.pinimg.com/474x/a1/da/a6/a1daa6f2d1416629a2af13989ebcaa9f.jpg',
    'https://i.pinimg.com/474x/8f/72/31/8f723127ce24c5983fd21d6fa84733a8.jpg',
    'https://i.pinimg.com/474x/1c/02/5f/1c025fa699fe372269009dad8681ca9e.jpg',
];

const startEditing = () => {
    editedUser.name = user.name;
    editedUser.avatar = user.avatar;
    editedUser.linkedin = user.linkedin;
    editedUser.instagram = user.instagram;
    editedUser.personalDescription = user.personalDescription;
    editedUser.batch = user.batch;
    isEditing.value = true;
};

const cancelEditing = () => {
    isEditing.value = false;
};

const saveProfile = () => {
    user.name = editedUser.name;
    user.avatar = editedUser.avatar;
    user.linkedin = editedUser.linkedin;
    user.instagram = editedUser.instagram;
    user.personalDescription = editedUser.personalDescription;
    user.batch = editedUser.batch;

    localStorage.setItem('userProfile', JSON.stringify(user));

    isEditing.value = false;
};

const selectAvatar = (avatarUrl: string) => {
    editedUser.avatar = avatarUrl;
};

const triggerFileUpload = () => {
    if (fileInput.value) {
        fileInput.value.click();
    }
};

const handleFileChange = (event: Event) => {
    const target = event.target as HTMLInputElement;
    if (target.files && target.files.length > 0) {
        const file = target.files[0];
        
        if (!file.type.match('image.*')) {
            alert('Please select an image file');
            return;
        }
        
        if (file.size > 5 * 1024 * 1024) {
            alert('File size should not exceed 5MB');
            return;
        }
        
        isUploading.value = true;
        uploadProgress.value = 0;
        
        const reader = new FileReader();
        
        const interval = setInterval(() => {
            uploadProgress.value += 5;
            
            if (uploadProgress.value >= 100) {
                clearInterval(interval);
                isUploading.value = false;
            }
        }, 100);
        
        reader.onload = (e) => {
            if (e.target && typeof e.target.result === 'string') {
                setTimeout(() => {
                    editedUser.avatar = e.target!.result as string;
                    if (fileInput.value) {
                        fileInput.value.value = ''; 
                    }
                }, uploadProgress.value * 10); 
            }
        };
        
        reader.readAsDataURL(file);
    }
};

const backgroundClasses = computed(() => {
    return isEditing.value
        ? 'bg-gradient-to-br from-gray-50 to-gray-100'
        : 'bg-white';
});
</script>

<template>
    <Navbar/>
    <div class="min-h-screen pt-12 bg-gray-50">
        <main class="container px-4 pt-20 pb-16 mx-auto">
            <div class="max-w-4xl mx-auto">
                <div :class="['transition-all duration-500 rounded-3xl shadow-lg overflow-hidden', backgroundClasses]">
                    <div class="relative h-56 bg-gradient-to-r from-gray-800 to-black">
                        <div class="absolute inset-0 opacity-20 bg-pattern"></div>

                        <router-link to="/"
                            class="absolute flex items-center px-4 py-2 font-mono text-sm text-black transition-all duration-300 rounded-full shadow-md top-6 left-6 bg-white/90 hover:bg-white">
                            <svg xmlns="http://www.w3.org/2000/svg" class="w-4 h-4 mr-1" fill="none" viewBox="0 0 24 24"
                                stroke="currentColor">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                    d="M10 19l-7-7m0 0l7-7m-7 7h18" />
                            </svg>
                            Back
                        </router-link>

                        <div class="absolute flex gap-3 top-6 right-6">
                            <button v-if="!isEditing" @click="startEditing"
                                class="flex items-center px-4 py-2 font-mono text-sm text-black transition-all duration-300 rounded-full shadow-md bg-white/90 hover:bg-white">
                                <svg xmlns="http://www.w3.org/2000/svg" class="w-4 h-4 mr-1" fill="none"
                                    viewBox="0 0 24 24" stroke="currentColor">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                        d="M15.232 5.232l3.536 3.536m-2.036-5.036a2.5 2.5 0 113.536 3.536L6.5 21.036H3v-3.572L16.732 3.732z" />
                                </svg>
                                Edit Profile
                            </button>
                            <template v-else>
                                <button @click="saveProfile"
                                    class="flex items-center px-4 py-2 font-mono text-sm text-white transition-all duration-300 bg-black rounded-full shadow-md hover:bg-gray-800">
                                    <svg xmlns="http://www.w3.org/2000/svg" class="w-4 h-4 mr-1" fill="none"
                                        viewBox="0 0 24 24" stroke="currentColor">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                            d="M5 13l4 4L19 7" />
                                    </svg>
                                    Save
                                </button>
                                <button @click="cancelEditing"
                                    class="flex items-center px-4 py-2 font-mono text-sm text-black transition-all duration-300 rounded-full shadow-md bg-white/90 hover:bg-white">
                                    <svg xmlns="http://www.w3.org/2000/svg" class="w-4 h-4 mr-1" fill="none"
                                        viewBox="0 0 24 24" stroke="currentColor">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                            d="M6 18L18 6M6 6l12 12" />
                                    </svg>
                                    Cancel
                                </button>
                            </template>
                        </div>
                    </div>

                    <div class="relative px-8 pb-8">
                        <div class="absolute -top-20 left-8">
                            <div class="relative group">
                                <div
                                    class="w-40 h-40 overflow-hidden bg-gray-100 border-4 border-white rounded-full shadow-lg">
                                    <img :src="isEditing ? editedUser.avatar : user.avatar" alt="User Avatar"
                                        class="object-cover w-full h-full" />

                                    <div v-if="isEditing"
                                        class="absolute inset-0 flex items-center justify-center transition-opacity duration-300 opacity-0 cursor-pointer bg-black/50 group-hover:opacity-100"
                                        @click="triggerFileUpload">
                                        <div class="font-mono text-xs text-center text-white">
                                            <svg xmlns="http://www.w3.org/2000/svg" class="w-8 h-8 mx-auto mb-1"
                                                fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                    d="M4 16l4.586-4.586a2 2 0 012.828 0L16 16m-2-2l1.586-1.586a2 2 0 012.828 0L20 14m-6-6h.01M6 20h12a2 2 0 002-2V6a2 2 0 00-2-2H6a2 2 0 00-2 2v12a2 2 0 002 2z" />
                                            </svg>
                                            Upload Photo
                                        </div>
                                    </div>

                                    <input 
                                        ref="fileInput" 
                                        type="file" 
                                        accept="image/*" 
                                        class="hidden" 
                                        @change="handleFileChange"
                                    />

                                    <div v-if="isUploading"
                                        class="absolute inset-0 flex items-center justify-center bg-black/30">
                                        <div class="flex items-center justify-center w-16 h-16 bg-white rounded-full">
                                            <svg class="w-8 h-8 text-black animate-spin"
                                                xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
                                                <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor"
                                                    stroke-width="4">
                                                </circle>
                                                <path class="opacity-75" fill="currentColor"
                                                    d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z">
                                                </path>
                                            </svg>
                                            <div class="absolute text-xs font-bold">{{ uploadProgress }}%</div>
                                        </div>
                                    </div>
                                </div>

                                <div
                                    class="absolute px-2 py-1 font-mono text-xs text-white bg-black rounded-full -top-2 -right-2">
                                    #000
                                </div>
                            </div>
                        </div>

                        <div class="pt-24">
                            <div class="flex items-center justify-between mb-6">
                                <div class="flex-1">
                                    <label v-if="isEditing"
                                        class="block mb-1 font-mono text-sm font-medium text-gray-600">Display Name</label>
                                    <input v-if="isEditing" v-model="editedUser.name" type="text"
                                        class="w-full px-4 py-3 font-mono text-xl text-black transition border-2 border-gray-200 outline-none rounded-xl focus:border-gray-500 focus:ring-1 focus:ring-gray-500" />
                                    <h2 v-else class="font-mono text-3xl font-bold text-gray-900">{{ user.name }}</h2>
                                </div>
                                
                                <div v-if="user.role !== 'Guest' && !isEditing" class="flex items-center space-x-3">
                                    <a :href="user.linkedin" target="_blank" class="flex items-center justify-center w-10 h-10 p-2 transition-all duration-300 bg-gray-100 rounded-full hover:bg-gray-200">
                                        <svg class="w-5 h-5" viewBox="0 0 24 24" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                                            <path d="M19 3a2 2 0 0 1 2 2v14a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h14m-.5 15.5v-5.3a3.26 3.26 0 0 0-3.26-3.26c-.85 0-1.84.52-2.32 1.3v-1.11h-2.79v8.37h2.79v-4.93c0-.77.62-1.4 1.39-1.4a1.4 1.4 0 0 1 1.4 1.4v4.93h2.79M6.88 8.56a1.68 1.68 0 0 0 1.68-1.68c0-.93-.75-1.69-1.68-1.69a1.69 1.69 0 0 0-1.69 1.69c0 .93.76 1.68 1.69 1.68m1.39 9.94v-8.37H5.5v8.37h2.77z" />
                                        </svg>
                                    </a>
                                    <a :href="user.instagram" target="_blank" class="flex items-center justify-center w-10 h-10 p-2 transition-all duration-300 bg-gray-100 rounded-full hover:bg-gray-200">
                                        <svg class="w-5 h-5" viewBox="0 0 24 24" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                                            <path d="M7.8 2h8.4C19.4 2 22 4.6 22 7.8v8.4a5.8 5.8 0 0 1-5.8 5.8H7.8C4.6 22 2 19.4 2 16.2V7.8A5.8 5.8 0 0 1 7.8 2m-.2 2A3.6 3.6 0 0 0 4 7.6v8.8C4 18.39 5.61 20 7.6 20h8.8a3.6 3.6 0 0 0 3.6-3.6V7.6C20 5.61 18.39 4 16.4 4H7.6m9.65 1.5a1.25 1.25 0 0 1 1.25 1.25A1.25 1.25 0 0 1 17.25 8 1.25 1.25 0 0 1 16 6.75a1.25 1.25 0 0 1 1.25-1.25M12 7a5 5 0 0 1 5 5 5 5 0 0 1-5 5 5 5 0 0 1-5-5 5 5 0 0 1 5-5m0 2a3 3 0 0 0-3 3 3 3 0 0 0 3 3 3 3 0 0 0 3-3 3 3 0 0 0-3-3z" />
                                        </svg>
                                    </a>
                                    <div class="flex items-center justify-center w-10 h-10 p-2 transition-all duration-300 bg-gray-100 rounded-full">
                                        <span class="font-mono text-sm font-bold">{{ user.batch }}</span>
                                    </div>
                                </div>
                            </div>

                            <div class="p-6 mb-8 transition-all duration-300 bg-white border border-gray-100 shadow-sm hover:shadow-md rounded-xl">
                                <div class="flex items-center mb-3">
                                    <svg xmlns="http://www.w3.org/2000/svg" class="w-5 h-5 mr-2 text-gray-500" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z" />
                                    </svg>
                                    <span class="font-mono text-sm font-medium text-gray-600">About</span>
                                </div>
                                <textarea v-if="isEditing" v-model="editedUser.personalDescription" rows="4"
                                    class="w-full px-4 py-3 font-mono text-sm text-black transition border-2 border-gray-200 outline-none rounded-xl focus:border-gray-500 focus:ring-1 focus:ring-gray-500"></textarea>
                                <div v-else class="font-mono text-sm leading-relaxed text-gray-900">{{ user.personalDescription }}</div>
                            </div>

                            <div class="grid grid-cols-2 gap-3 mb-8 md:grid-cols-3 lg:grid-cols-4">
                                <div class="flex flex-col p-4 transition-all duration-300 bg-white border border-gray-100 shadow-sm hover:shadow-md rounded-xl">
                                    <div class="mb-1 font-mono text-xs text-gray-500">Email</div>
                                    <div class="mt-auto font-mono text-sm font-medium text-gray-900">{{ user.email }}</div>
                                </div>
                                <div class="flex flex-col p-4 transition-all duration-300 bg-white border border-gray-100 shadow-sm hover:shadow-md rounded-xl">
                                    <div class="mb-1 font-mono text-xs text-gray-500">Role</div>
                                    <div class="mt-auto font-mono text-sm font-medium text-gray-900">{{ user.role }}</div>
                                </div>
                                <div v-if="user.role !== 'Guest'" class="flex flex-col p-4 transition-all duration-300 bg-white border border-gray-100 shadow-sm hover:shadow-md rounded-xl">
                                    <div class="mb-1 font-mono text-xs text-gray-500">Division</div>
                                    <div class="mt-auto font-mono text-sm font-medium text-gray-900">{{ user.division }}</div>
                                </div>
                                <div v-if="user.role !== 'Guest'" class="flex flex-col p-4 transition-all duration-300 bg-white border border-gray-100 shadow-sm hover:shadow-md rounded-xl">
                                    <div class="mb-1 font-mono text-xs text-gray-500">Position</div>
                                    <div class="mt-auto font-mono text-sm font-medium text-gray-900">{{ user.position }}</div>
                                </div>
                                <div v-if="user.role !== 'Guest'" class="flex flex-col p-4 transition-all duration-300 bg-white border border-gray-100 shadow-sm hover:shadow-md rounded-xl">
                                    <div class="mb-1 font-mono text-xs text-gray-500">Cabinet</div>
                                    <div class="mt-auto font-mono text-sm font-medium text-gray-900">{{ user.cabinet }}</div>
                                </div>
                                <div class="flex flex-col p-4 transition-all duration-300 bg-white border border-gray-100 shadow-sm hover:shadow-md rounded-xl">
                                    <div class="mb-1 font-mono text-xs text-gray-500">Joined</div>
                                    <div class="mt-auto font-mono text-sm font-medium text-gray-900">{{ user.joined }}</div>
                                </div>
                                <div class="flex flex-col p-4 transition-all duration-300 bg-white border border-gray-100 shadow-sm hover:shadow-md rounded-xl">
                                    <div class="mb-1 font-mono text-xs text-gray-500">Status</div>
                                    <div class="flex items-center mt-auto font-mono text-sm font-medium text-gray-900">
                                        <span class="inline-block w-2 h-2 mr-2 bg-green-500 rounded-full"></span>
                                        Active
                                    </div>
                                </div>
                            </div>

                            <div v-if="user.role !== 'Guest' && isEditing" class="grid grid-cols-1 gap-4 mb-8 md:grid-cols-3">
                                <div class="p-4 transition-all duration-300 bg-white border border-gray-100 shadow-sm hover:shadow-md rounded-xl">
                                    <div class="flex items-center mb-2 space-x-2">
                                        <svg class="w-5 h-5" viewBox="0 0 24 24" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                                            <path d="M19 3a2 2 0 0 1 2 2v14a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h14m-.5 15.5v-5.3a3.26 3.26 0 0 0-3.26-3.26c-.85 0-1.84.52-2.32 1.3v-1.11h-2.79v8.37h2.79v-4.93c0-.77.62-1.4 1.39-1.4a1.4 1.4 0 0 1 1.4 1.4v4.93h2.79M6.88 8.56a1.68 1.68 0 0 0 1.68-1.68c0-.93-.75-1.69-1.68-1.69a1.69 1.69 0 0 0-1.69 1.69c0 .93.76 1.68 1.69 1.68m1.39 9.94v-8.37H5.5v8.37h2.77z" />
                                        </svg>
                                        <div class="font-mono text-sm text-gray-500">LinkedIn</div>
                                    </div>
                                    <input v-model="editedUser.linkedin" type="text"
                                        class="w-full px-4 py-2 font-mono text-sm text-black transition border-2 border-gray-200 rounded-lg outline-none focus:border-gray-500 focus:ring-1 focus:ring-gray-500" />
                                </div>
                                <div class="p-4 transition-all duration-300 bg-white border border-gray-100 shadow-sm hover:shadow-md rounded-xl">
                                    <div class="flex items-center mb-2 space-x-2">
                                        <svg class="w-5 h-5" viewBox="0 0 24 24" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                                            <path d="M7.8 2h8.4C19.4 2 22 4.6 22 7.8v8.4a5.8 5.8 0 0 1-5.8 5.8H7.8C4.6 22 2 19.4 2 16.2V7.8A5.8 5.8 0 0 1 7.8 2m-.2 2A3.6 3.6 0 0 0 4 7.6v8.8C4 18.39 5.61 20 7.6 20h8.8a3.6 3.6 0 0 0 3.6-3.6V7.6C20 5.61 18.39 4 16.4 4H7.6m9.65 1.5a1.25 1.25 0 0 1 1.25 1.25A1.25 1.25 0 0 1 17.25 8 1.25 1.25 0 0 1 16 6.75a1.25 1.25 0 0 1 1.25-1.25M12 7a5 5 0 0 1 5 5 5 5 0 0 1-5 5 5 5 0 0 1-5-5 5 5 0 0 1 5-5m0 2a3 3 0 0 0-3 3 3 3 0 0 0 3 3 3 3 0 0 0 3-3 3 3 0 0 0-3-3z" />
                                        </svg>
                                        <div class="font-mono text-sm text-gray-500">Instagram</div>
                                    </div>
                                    <input v-model="editedUser.instagram" type="text"
                                        class="w-full px-4 py-2 font-mono text-sm text-black transition border-2 border-gray-200 rounded-lg outline-none focus:border-gray-500 focus:ring-1 focus:ring-gray-500" />
                                </div>
                                <div class="p-4 transition-all duration-300 bg-white border border-gray-100 shadow-sm hover:shadow-md rounded-xl">
                                    <div class="flex items-center mb-2 space-x-2">
                                        <div class="flex items-center justify-center w-5 h-5 text-xs font-bold text-center bg-gray-200 rounded-full">B</div>
                                        <div class="font-mono text-sm text-gray-500">Batch</div>
                                    </div>
                                    <input v-model="editedUser.batch" type="text"
                                        class="w-full px-4 py-2 font-mono text-sm text-black transition border-2 border-gray-200 rounded-lg outline-none focus:border-gray-500 focus:ring-1 focus:ring-gray-500" />
                                </div>
                            </div>

                            <div v-if="isEditing" class="mb-6">
                                <div class="flex items-center mb-3">
                                    <svg xmlns="http://www.w3.org/2000/svg" class="w-5 h-5 mr-2 text-gray-500" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 16l4.586-4.586a2 2 0 012.828 0L16 16m-2-2l1.586-1.586a2 2 0 012.828 0L20 14m-6-6h.01M6 20h12a2 2 0 002-2V6a2 2 0 00-2-2H6a2 2 0 00-2 2v12a2 2 0 002 2z" />
                                    </svg>
                                    <span class="font-mono text-sm font-medium text-gray-600">Choose an Avatar</span>
                                </div>
                                <div class="grid grid-cols-3 gap-4 sm:grid-cols-6">
                                    <div v-for="(avatar, index) in avatarOptions" :key="index"
                                        class="w-16 h-16 overflow-hidden transition-all duration-300 border-2 rounded-full cursor-pointer"
                                        :class="avatar === editedUser.avatar ? 'border-black scale-110 shadow-lg' : 'border-gray-200 hover:border-gray-400'"
                                        @click="selectAvatar(avatar)">
                                        <img :src="avatar" alt="Avatar option" class="object-cover w-full h-full" />                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>
    <Footer />
</template>

<style scoped>
.bg-pattern {
    background-image: url("https://i.pinimg.com/736x/d6/ed/1b/d6ed1b930c7809e56eada4c6510114a9.jpg");
}
</style>